
PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

gamePause = false

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    self.pause = love.graphics.newImage('pause.png')
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    
    self.timer = self.timer + dt
    if gamePause == false then
        if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('P') then
            gamePause = true
        end
        if self.timer > math.random(2,20) then
            local y = math.max(-PIPE_HEIGHT + 15, 
                math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - GAP_HEIGHT - PIPE_HEIGHT))
            self.lastY = y

            table.insert(self.pipePairs, PipePair(y))

            self.timer = 0
        end

        for k, pair in pairs(self.pipePairs) do
            if not pair.scored then
                if pair.x + PIPE_WIDTH < self.bird.x then
                    self.score = self.score + 1
                    pair.scored = true
                    sounds['score']:play()
                end
            end
            pair:update(dt)
        end

        for k, pair in pairs(self.pipePairs) do
            if pair.remove then
                table.remove(self.pipePairs, k)
            end
        end

        for k, pair in pairs(self.pipePairs) do
            for l, pipe in pairs(pair.pipes) do
                if self.bird:collides(pipe) then
                    sounds['explosion']:play()
                    sounds['hurt']:play()

                    gStateMachine:change('score', {
                        score = self.score
                    })
                end
            end
        end

        self.bird:update(dt)

        if self.bird.y > VIRTUAL_HEIGHT - 15 then
            sounds['explosion']:play()
            sounds['hurt']:play()

            gStateMachine:change('score', {
                score = self.score
            })
        end

    else 
        sounds['music']:pause()
        scrolling = false
        if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('P') then
            gamePause = false
            scrolling = true
            sounds['music']:resume()
        end
    end

end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()

    if gamePause == true then 
        love.graphics.setFont(flappyFont)
        love.graphics.setColor(204,204,0, 255)
        love.graphics.print('PAUSED',210,200)
        love.graphics.setColor(255,250,250, 255)
        love.graphics.draw(self.pause,(VIRTUAL_WIDTH/2) - 36,(VIRTUAL_HEIGHT/2)-36)
    end
end


function PlayState:enter()
    scrolling = true
end


function PlayState:exit()
    scrolling = false
end