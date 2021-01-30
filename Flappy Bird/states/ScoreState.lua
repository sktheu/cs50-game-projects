--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score

    self.medal = ScoreState:SetMedalSprite(self.score) -- Allocating the returned sprite in medal
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 32, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 64, VIRTUAL_WIDTH, 'center')

    -- renders the medal in the middle of the screen
    love.graphics.draw(self.medal, VIRTUAL_WIDTH / 2 - self.medal:getWidth() / 2, (VIRTUAL_HEIGHT / 2 - self.medal:getHeight() / 2) - 8)

    love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
end

--[[
    Returns a medal sprite based on the player's score.
]]
function ScoreState:SetMedalSprite(score)
    if score >= 30 then
        return love.graphics.newImage('sprites/diamond_medal.png')
    elseif score >= 15 then
        return love.graphics.newImage('sprites/gold_medal.png')
    elseif score >= 10 then
        return love.graphics.newImage('sprites/silver_medal.png')
    elseif score >= 5 then
        return love.graphics.newImage('sprites/bronze_medal.png')
    else
        return love.graphics.newImage('sprites/without_medal.png')
    end
end