local love = require "love"
local enemy = require "Enemy"
local button = require "Button"

math.randomseed(os.time())

local game = {
    difficulty = 1,
    state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    },
    points = 0,
    levels = {10, 20, 30, 40}
}
local player = {
    radius = 20,
    x = 30,
    y = 30
}

local buttons = {
    menu_state = {},
    ended_state = {},
    paused_state = {},
    width = 120,
    height = 40,
}

local enemies = {}

local fonts = {
    medium = {
        font = love.graphics.newFont(16),
        size = 16
    },
    large = {
        font = love.graphics.newFont(24),
        size = 24
    },
    massive = {
        font = love.graphics.newFont(60),
        size = 60
    }
}

local function changeGameState(state)
    game.state["menu"] = state == "menu"
    game.state["running"] = state == "running"
    game.state["paused"] = state == "paused"
    game.state["ended"] = state == "ended"
end

local function startNewGame()
    changeGameState("running")

    game.points = 0

    enemies = {
        enemy(1)
    }
end

function love.mousepressed(x, y, button, istouch, presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menu_state) do
                    buttons.menu_state[index]:checkPressed(x, y, player.radius)
                end
            elseif game.state["ended"] then
                for index in pairs(buttons.ended_state) do
                    buttons.ended_state[index]:checkPressed(x, y, player.radius)
                end
            elseif game.state["paused"] then
                for index in pairs(buttons.paused_state) do
                    buttons.paused_state[index]:checkPressed(x, y, player.radius)
                end
            end
        end
    end
end

function love.load()
    love.window.setTitle("Save the ball")
    love.mouse.setVisible(false)

    buttons.menu_state.play_game = button("Play Game", startNewGame, nil, buttons.width, buttons.height)
    buttons.menu_state.settings = button("Settings", nil, nil, buttons.width, buttons.height)
    buttons.menu_state.exit_game = button("Quit Game", love.event.quit, nil, buttons.width, buttons.height)
    
    buttons.ended_state.replay_game = button("Replay", startNewGame, nil, buttons.width, buttons.height)
    buttons.ended_state.menu = button("Menu", changeGameState, "menu", buttons.width, buttons.height)
    buttons.ended_state.exit_game = button("Quit", love.event.quit, nil, buttons.width, buttons.height)

end

function love.update(dt)
    player.x, player.y = love.mouse.getPosition()

    function love.keypressed(key, scancode, isrepeat)
        if game.state["running"] then
            if key == "escape" then
                changeGameState("paused")
            end
        elseif game.state["paused"] then
            if key == "escape" then
                changeGameState("running")
            end
        end
    end
    if game.state["running"] then
        for i = 1, #enemies do
            if not enemies[i]:checkTouched(player.x, player.y, player.radius) then
                enemies[i]:move(player.x, player.y)

                for j = 1, #game.levels do
                    if math.floor(game.points) == game.levels[j] then
                        table.insert(enemies, 1, enemy(game.difficulty * (j + 1)))

                        game.points = game.points + 1
                    end
                end
            else
                changeGameState("ended")
            end
        end
        game.points = game.points + dt
    end
end

function love.draw()
    love.graphics.setFont(fonts.medium.font)

    love.graphics.printf("FPS: " .. love.timer.getFPS(), fonts.medium.font, 10, love.graphics.getHeight() - 30, love.graphics.getWidth())

    local play_button_x, play_button_y, play_text_x, play_text_y = 10, 20, 20, 10

    local settings_button_x, settings_button_y, settings_text_x, settings_text_y
    = play_button_x, play_button_y + buttons.height + 10, play_text_x, play_text_y

    local exit_button_x, exit_button_y, exit_text_x, exit_text_y
    = play_button_x, settings_button_y + buttons.height + 10, play_text_x, settings_text_y

    if game.state["running"] then
        love.graphics.printf(math.floor(game.points), fonts.large.font, 0, 10, love.graphics.getWidth(), "center")

        for i = 1, #enemies do
            enemies[i]:draw()
        end
        
        love.graphics.circle("fill", player.x, player.y, player.radius)
    elseif game.state["menu"] then
        buttons.menu_state.play_game:draw(play_button_x, play_button_y, play_text_x, play_text_y)
        buttons.menu_state.settings:draw(settings_button_x, settings_button_y, settings_text_x, settings_text_y)
        buttons.menu_state.exit_game:draw(exit_button_x, exit_button_y, exit_text_x, exit_text_y)

    elseif game.state["ended"] then
        love.graphics.setFont(fonts.large.font)

        buttons.ended_state.replay_game:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 2 + play_button_y, play_text_x, play_text_y)
        buttons.ended_state.menu:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 2 + settings_button_y, settings_text_x, settings_text_y)
        buttons.ended_state.exit_game:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 2 + exit_button_y, exit_text_x,exit_text_y)

        love.graphics.printf(math.floor(game.points), fonts.massive.font, 10, love.graphics.getHeight() / 2 - fonts.massive.size, love.graphics.getWidth(), "center")
    elseif game.state["paused"] then
        love.graphics.setFont(fonts.massive.font)
        
        love.graphics.printf("Paused", 0, love.graphics.getHeight() / 2 - fonts.massive.size, love.graphics.getWidth(), "center")
    end

    if not game.state["running"] then
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end
    
end