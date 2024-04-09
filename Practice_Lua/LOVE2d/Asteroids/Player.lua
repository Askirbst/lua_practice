---@diagnostic disable: lowercase-global

local love = require "love"

function Player(debugging)
    local SHIP_SIZE = 30
    local VIEW_ANGLE = math.rad(90)

    debugging = debugging or false

    return {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        radius = SHIP_SIZE / 2,
        angle = VIEW_ANGLE,
        rotation = 0,
        thrusting = false,
        thrust = {
            x = 0,
            y = 0,
            speed = 5,
            big_flame = false,
            flame = 2.0
        },

        drawFlameThrust = function (self, fillType, color)
            love.graphics.setColor(color)
            love.graphics.polygon(
                fillType,
                self.x - self.radius * (2 / 3 * math.cos(self.angle) + 0.5 * math.sin(self.angle)),
                self.y + self.radius * (2 / 3 * math.sin(self.angle) - 0.5 * math.cos(self.angle)),
                self.x - self.radius * self.thrust.flame * math.cos(self.angle),
                self.y + self.radius * self.thrust.flame * math.sin(self.angle),
                self.x - self.radius * (2 / 3 * math.cos(self.angle) - 0.5 * math.sin(self.angle)),
                self.y + self.radius * (2 / 3 * math.sin(self.angle) + 0.5 * math.cos(self.angle))
            )
        end,

        draw = function (self)
            local opacity = 1

            if self.thrusting then
                if not self.thrust.big_flame then
                    self.thrust.flame = self.thrust.flame - 1 / (1 / love.timer.getDelta())

                    if self.thrust.flame < 1.5 then
                        self.thrust.big_flame = true
                    end
                else
                    self.thrust.flame = self.thrust.flame + 1 / (1 / love.timer.getDelta())

                    if self.thrust.flame > 2.5 then
                        self.thrust.big_flame = false
                    end
                end
                self:drawFlameThrust("fill", { 255 / 255, 102 / 255, 25 / 255})
                self:drawFlameThrust("line", { 1, 0.16, 0})
            end

            if debugging then
                love.graphics.setColor(1, 0 , 0)

                love.graphics.rectangle("fill", self.x - 1, self.y - 1, 2, 2)

                love.graphics.circle("line", self.x, self.y, self.radius)
            end

            love.graphics.setColor(1, 1, 1, opacity)
            
            love.graphics.polygon(
                "line",
                self.x + ((4 / 3) * self.radius) * math.cos(self.angle),
                self.y - ((4 / 3) * self.radius) * math.sin(self.angle),
                self.x - self.radius * (2 / 3 * math.cos(self.angle) + math.sin(self.angle)),
                self.y + self.radius * (2 / 3 * math.sin(self.angle) - math.cos(self.angle)),
                self.x - self.radius * (2 / 3 * math.cos(self.angle) - math.sin(self.angle)),
                self.y + self.radius * (2 / 3 * math.sin(self.angle) + math.cos(self.angle))
            )
        end,

        movePlayer = function (self)
            local DT = 1 / love.timer.getDelta()
            local friction = 1.7

            local window_top = 1
            local window_bottom = love.graphics.getHeight()
            local window_left = 1
            local window_right = love.graphics.getWidth()

            self.rotation = (360 / 180) * (math.pi / DT)

            if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
                self.angle = self.angle + self.rotation
            end
            
            if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
                self.angle = self.angle - self.rotation
            end

            if self.thrusting then
                if self.x >= window_right then 
                    self.thrust.x = 0
                    self.x = self.x - 5
                elseif self.x <= window_left then
                    self.thrust.x = 0
                    self.x = self.x + 5
                elseif self.y >= window_bottom then
                    self.thrust.y = 0
                    self.y = self.y - 5
                elseif self.y <= window_top then
                    self.thrust.y = 0
                    self.y = self.y + 5
                else
                    self.thrust.x = self.thrust.x + self.thrust.speed * math.cos(self.angle) / DT
                    self.thrust.y = self.thrust.y - self.thrust.speed * math.sin(self.angle) / DT 
                end
            elseif self.thrust.x ~= 0 or self.thrust.y ~= 0 then
                if (self.x <= window_right and self.x >= window_left) and (self.y <= window_bottom and self.y >= window_top) then
                    self.thrust.x = self.thrust.x - friction * self.thrust.x / DT
                    self.thrust.y = self.thrust.y - friction * self.thrust.y / DT
                else
                    if self.x >= window_right or self.x <= window_left then
                        self.thrust.x = self.thrust.x - self.thrust.x
                        self.thrust.y = self.thrust.y - friction * self.thrust.y / DT
                    elseif self.y >= window_bottom or self.y <= window_top then
                        self.thrust.x = self.thrust.x - friction * self.thrust.x / DT
                        self.thrust.y = self.thrust.y - self.thrust.y
                    end
                end
            end            
            self.x = self.x + self.thrust.x
            self.y = self.y + self.thrust.y
        end
    }
end

return Player