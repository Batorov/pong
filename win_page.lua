WinPage = {}
WinPage.__index = WinPage

function WinPage:create()
	local page = {}
    setmetatable(page, WinPage)
    return page
end

function WinPage:draw()
	love.graphics.setFont(mainFont)
	love.graphics.print("Вы выиграли!", 250, 100)
	love.graphics.setFont(sFont)
	love.graphics.print("Нажмите Enter для перезапуска.", 230, 200)
end

function WinPage:update()
end

function WinPage:keypressed(key)
	if key == 'return' then
        love.mouse.setVisible(true)
        Page="game_page"
        game_page:restart()
    end
end