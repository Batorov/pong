
require("hello_page")
require("game_page")
require("win_page")
require("loss_page")
require("vector")

function love.load()
	width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    mainFont = love.graphics.newFont("fontick.otf", 40);
    sFont = love.graphics.newFont("fontick.otf", 20);
    love.graphics.setFont(mainFont);

    Page = "hello_page"
    hello_page = HelloPage:create()
    game_page = GamePage:create()
    win_page = WinPage:create()
    loss_page = LossPage:create()
end

function love.draw()
   if Page == "hello_page" then
   		hello_page:draw()
   elseif Page == "game_page" then
   		game_page:draw()
   elseif Page == "win_page" then
   		win_page:draw()
   elseif Page == "loss_page" then
   		loss_page:draw()
   end	
end

function love.update()
   if Page == "hello_page" then
   		hello_page:update()
   elseif Page == "game_page" then
   		game_page:update()
   elseif Page == "win_page" then
   		win_page:update()
   elseif Page == "loss_page" then
   		loss_page:update()
   end	
end

function love.keypressed(key)
    if Page == "hello_page" then
    	hello_page:keypressed(key)
    elseif Page == "game_page" then
    	game_page:keypressed(key) 
    elseif Page == "win_page" then
   		win_page:keypressed(key)
    elseif Page == "loss_page" then
   		loss_page:keypressed(key)
    end
end