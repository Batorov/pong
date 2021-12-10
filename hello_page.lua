HelloPage = {}
HelloPage.__index = HelloPage

function HelloPage:create()
	local page = {}
    setmetatable(page, HelloPage)
    return page
end

function HelloPage:draw()
	love.graphics.setFont(mainFont)
	love.graphics.print("Здравствуйте!", 250, 100)
	love.graphics.setFont(sFont)
	love.graphics.print("Для старта нажмите Enter.", 260, 200)
	love.graphics.print("Управление мышью", 290, 300)
end

function HelloPage:update()
end

function HelloPage:keypressed(key)
	if key == 'return' then
        love.mouse.setVisible(true)
        Page="game_page"
    end
end