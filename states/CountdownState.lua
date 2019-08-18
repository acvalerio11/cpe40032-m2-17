
CountdownState = Class{__includes = BaseState}

COUNTDOWN_TIME = 1

function CountdownState:init()
    self.count = 3
    self.timer = 0
end


function CountdownState:update(dt)
    self.timer = self.timer + dt
    sounds['music']:pause()

    if self.count == 3 then
        sounds['count']:play()
    end
    
    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 2 then
            sounds['count']:play()
        end
        if self.count == 1 then
            sounds['count']:play()
        end

        if self.count == 0 then
            sounds['count']:stop()
            sounds['music']:resume()
            gStateMachine:change('play')
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end