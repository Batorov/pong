P = {}
P.__index = P

function P:create()
	local p = {}
    setmetatable(p, P)
    return p
end

function P:draw()
	love.graphics.print(Text, 400, 300)
end