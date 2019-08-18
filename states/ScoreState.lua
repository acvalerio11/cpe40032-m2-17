
ScoreState = Class{__includes = BaseState}
medal1 = love.graphics.newImage('first.png')
medal2 = love.graphics.newImage('second.png')
medal3 = love.graphics.newImage('third.png')

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
        sounds['award']:stop()
        
    end
end

function ScoreState:render()
    love.graphics.setColor(255,250,250, 255)
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 114, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 150, VIRTUAL_WIDTH, 'center')

    if self.score > 2 and self.score < 7 then
        sounds['music']:pause()
        sounds['award']:play()
        love.graphics.setFont(flappyFont)
        love.graphics.draw(medal3,(VIRTUAL_WIDTH/2)-22,40)
        love.graphics.setColor(86,129,202, 255)
        love.graphics.printf('GOOD!', 0, 10, VIRTUAL_WIDTH, 'center')
        
        
    end

    if self.score > 6 and self.score < 11 then
        sounds['music']:pause()
        sounds['award']:play()
        love.graphics.setFont(flappyFont)
        love.graphics.draw(medal2,(VIRTUAL_WIDTH/2)-21,40)
        love.graphics.setColor(212,175,55, 255)
        love.graphics.printf('GREAT!', 0, 10, VIRTUAL_WIDTH, 'center')
    end

    if self.score > 10 then
        sounds['music']:pause()
        sounds['award']:play()
        love.graphics.setFont(flappyFont)
        love.graphics.draw(medal1,(VIRTUAL_WIDTH/2)-29,40)
        love.graphics.setColor(255,223,0, 255)
        love.graphics.printf('EXCELLENT!', 0, 10, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setColor(204,204,0, 255)
    love.graphics.printf('Press Enter to Play Again!', 0, 210, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255,250,250, 255)
end