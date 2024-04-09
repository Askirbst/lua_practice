function love.conf(t)
   t.identity = "data/saves" -- assign a save file 
   t.version = "1.0.0" -- assigns a version number
   t.console = false -- is the console attached
   t.externalstorage = true -- android only 
   t.gammacorrect = true -- enable gamma correct rendering
   t.audio.mic = true -- android only 
   t.window.title = "Come Garden"
   t.window.width = 800
   t.window.height = 600
   t.window.resizable = false -- game make break if it is resized
end