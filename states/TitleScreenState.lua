
TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
    self.image = love.graphics.newImage('bird.png')
    self.image1 = love.graphics.newImage('bird1.png')
    self.instruction = love.graphics.newImage('instruction.png')
    self.birdSmall = love.graphics.newImage('birdSmall.png')
    
end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fifty Bird', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(self.image,135,63)
    love.graphics.draw(self.image1,337,63)

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Play', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('To flap the bird:', 0, 150, VIRTUAL_WIDTH, 'center')
   
    love.graphics.draw(self.instruction,VIRTUAL_WIDTH/2 - 55,200)
    love.graphics.draw(self.birdSmall,243,175)
    love.graphics.setFont(mediumFont)
    love.graphics.printf('OR ', -3, 244, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0,0,0, 255)
    love.graphics.setFont(smallFont)
    love.graphics.printf('SPACEBAR ', 42, 244, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0,0,0, 255)
    love.graphics.setFont(mediumFont)
    love.graphics.printf('GOOD : 3 - 6 pts      GREAT: 7 - 10 pts       EXCELLENT: 11+ pts', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255,250,250, 255)
end