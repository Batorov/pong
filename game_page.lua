GamePage = {}
GamePage.__index = GamePage

function GamePage:create()
	local page = {}
    setmetatable(page, GamePage)
    page.ball = {}
    page.ball.location = Vector:create(width/2, 0)
    --page.ball.velocity = Vector:create(-1.5, 0.9)
    page.ball.xspeed = 5
    page.ball.velocity = Vector:create(-page.ball.xspeed, 1.8)
    page.win_audio = love.audio.newSource("resources/victory.wav", "static")
    page.go_audio = love.audio.newSource("resources/gameover.wav", "static")
    page.pong_audio = love.audio.newSource("resources/pong.wav", "static")

    page.score = {0, 0}
    page.player = {}
    page.player.location = Vector:create(15/2, height/2)

    page.enemy = {}
    page.enemy.location = Vector:create(width-15/2, 40)
    page.enemy.velocity = Vector:create(0, 0)
    return page
end

function GamePage:restart()
	-- body
	self.ball = {}
    self.ball.location = Vector:create(width/2, 0)
    --page.ball.velocity = Vector:create(-1.5, 0.9)
    self.ball.xspeed = 5
    self.ball.velocity = Vector:create(-self.ball.xspeed, 1.8)

    self.score = {0, 0}
    self.player = {}
    self.player.location = Vector:create(15/2, height/2)

    self.enemy = {}
    self.enemy.location = Vector:create(width-15/2, 40)
    self.enemy.velocity = Vector:create(0, 0)
end

function GamePage:draw()
	love.graphics.print(tostring(self.score[1]), 10, 10)
	love.graphics.print(tostring(self.score[2]), width - 18, 10)
	love.graphics.rectangle("fill", width/2, 0, 1, height)
    love.graphics.rectangle("fill", self.player.location.x - 15/2, self.player.location.y-80/2, 15, 80)
    love.graphics.rectangle("fill", self.enemy.location.x - 15/2, self.enemy.location.y-80/2, 15, 80)
    love.graphics.circle("fill", self.ball.location.x, self.ball.location.y, 10)
end



function GamePage:update()
	xold = x or 0
	yold = y or 0
	x, y = love.mouse.getPosition()
	self.player.location.y = y
	yspeed = y - yold
	
	self.ball.location = self.ball.location + self.ball.velocity
	move_random = love.math.random()
	if move_random > 0.9 then self.enemy.velocity.y = self.ball.velocity.y end
	self.enemy.location = self.enemy.location + self.enemy.velocity

	if self.ball.location.x > self.player.location.x - 15/2 - 10 and self.ball.location.x < self.player.location.x + 15/2 + 10 and self.ball.location.y < self.player.location.y + 80/2 + 10 and self.ball.location.y > self.player.location.y - 80/2 - 10 then
		if self.ball.location.x - self.ball.velocity.x >= self.player.location.x + 15/2 + 10 then
			self.ball.velocity.x = self.ball.velocity.x * -1
			self.pong_audio:play()
			if yspeed > 3 then yspeed = 3 end
			if yspeed < -3 then yspeed = -3 end
			self.ball.velocity.y = self.ball.velocity.y + yspeed
			if self.ball.velocity.y > 5 then self.ball.velocity.y = 5 end
			if self.ball.velocity.y < -5 then self.ball.velocity.y = -5 end
		end
		if self.ball.location.y - self.ball.velocity.y >= self.player.location.y + 80/2 + 10 then
			self.pong_audio:play()
			self.ball.velocity.y = self.ball.velocity.y * -1
		end
		if self.ball.location.y - self.ball.velocity.y <= self.player.location.y - 80/2 - 10 then
			self.pong_audio:play()
			self.ball.velocity.y = self.ball.velocity.y * -1
		end
	end

	if self.ball.location.x > self.enemy.location.x - 15/2 - 10 and self.ball.location.x < self.enemy.location.x + 15/2 + 10 and self.ball.location.y < self.enemy.location.y + 80/2 + 10 and self.ball.location.y > self.enemy.location.y - 80/2 - 10 then
		if self.ball.location.x - self.ball.velocity.x <= self.enemy.location.x - 15/2 - 10 then
			self.ball.velocity.x = self.ball.velocity.x * -1
			self.pong_audio:play()
			--self.ball.velocity.y = self.ball.velocity.y + yspeed
		end
		if self.ball.location.y - self.ball.velocity.y >= self.enemy.location.y + 80/2 + 10 then
			self.ball.velocity.y = self.ball.velocity.y * -1
			self.pong_audio:play()
		end
		if self.ball.location.y - self.ball.velocity.y <= self.enemy.location.y - 80/2 - 10 then
			self.ball.velocity.y = self.ball.velocity.y * -1
			self.pong_audio:play()
		end
	end


    if self.ball.location.y > height - 10 then 
        self.ball.location.y = height - 10
        self.ball.velocity.y = -1*self.ball.velocity.y
    elseif self.ball.location.y < 10 then 
        self.ball.location.y = 10
        self.ball.velocity.y = -1*self.ball.velocity.y
    end
    if self.player.location.y > height - 40 then 
        self.player.location.y = height - 40
    elseif self.player.location.y < 40 then 
        self.player.location.y = 40
    end
    if self.enemy.location.y > height - 40 then 
        self.enemy.location.y = height - 40
    elseif self.enemy.location.y < 40 then 
        self.enemy.location.y = 40
    end

    if self.ball.location.x > width - 10 then 
        --self.ball.location.x = width - 10
        --self.ball.velocity.x = -1*self.ball.velocity.x
        if self.score[1] == 8 then 
        	Page = "win_page"
        	self.win_audio:play() 
        end
        self.ball.location.x = width/2
        self.ball.location.y = 0
        throw_random = love.math.random(2)
    	if throw_random==1 then self.ball.velocity.x = -self.ball.xspeed else self.ball.velocity.x = self.ball.xspeed end
    	self.ball.xspeed = self.ball.xspeed + 0.5
    	self.score[1] = self.score[1] + 1;

    	self.enemy.location.x = width-15/2
    	self.enemy.location.y = 40/2

    elseif self.ball.location.x < 10 then 
        --self.ball.location.x = 10
        --self.ball.velocity.x = -1*self.ball.velocity.x
        if self.score[2] == 8 then 
        	Page = "loss_page"
        	self.go_audio:play() 
        end
        self.ball.location.x = width/2
        self.ball.location.y = 0
        throw_random = love.math.random(2)
    	if throw_random==1 then self.ball.velocity.x = -self.ball.xspeed else self.ball.velocity.x = self.ball.xspeed end
    	self.ball.xspeed = self.ball.xspeed + 0.5
    	self.score[2] = self.score[2] + 1;

    	self.enemy.location.x = width-15/2
    	self.enemy.location.y = 40/2
    end

end

function GamePage:keypressed(key)

	if key == 'return' then
        Page="hello_page"
    end
end