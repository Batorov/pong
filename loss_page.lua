LossPage = {}
LossPage.__index = LossPage

function LossPage:create()
	local page = {}
    setmetatable(page, LossPage)
    return page
end

function LossPage:draw()
	love.graphics.setFont(mainFont)
	love.graphics.print("Вы проиграли!", 250, 100)
	love.graphics.setFont(sFont)
	love.graphics.print("Нажмите Enter для перезапуска.", 230, 200)
end

function LossPage:update()
end

function LossPage:keypressed(key)
	if key == 'return' then
        love.mouse.setVisible(true)
        Page="game_page"
        game_page:restart()
    end
end