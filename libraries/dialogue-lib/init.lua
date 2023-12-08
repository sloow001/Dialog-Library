local dialogue = {}

PATH = ...
local json = require(PATH .. ".json")

function dialogue.load(filename)
    local file = love.filesystem.newFile(filename)
    if file then
        file:open("r")
        local contents = file:read()
        file:close()

        dialogue.data = json.decode(contents)
        dialogue.currentText = 1
        return true
    else
        return false
    end
end

function dialogue.drawDialogBox(width, height)
    local x = 20
    local y = love.graphics.getHeight() - height - 20

    if dialogue.data then
        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle("fill", x, y, width, height)

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(love.graphics.newFont(18))

        local character, text = dialogue.getCurrentText()
        if character ~= "" and text ~= "" then
            love.graphics.printf(text, x + 10, y + 10, width - (2 * 10), "left")

            local charWidth = love.graphics.getFont():getWidth(character) + 2 * 5
            local charHeight = love.graphics.getFont():getHeight() + 2 * 5

            local rectX = 20
            local rectY = y - 30 + (love.graphics.getFont():getHeight() - charHeight) / 2

            love.graphics.setColor(0.5, 0.5, 0.5)
            love.graphics.rectangle("fill", rectX, rectY, charWidth, charHeight, 5)

            love.graphics.setColor(1, 1, 1)
            love.graphics.printf(character, rectX + 5, rectY + 5, charWidth - 2 * 5, "left")
        else
            dialogue.currentText = 0
            dialogue.data = nil
        end
    end
end


function dialogue.getCurrentText()
    if dialogue.data then
        local currentDialogue = dialogue.data.dialogue[dialogue.currentText]
        if currentDialogue then
            return currentDialogue.character, currentDialogue.text
        end
    end
    return "", ""
end

function dialogue.nextText()
    dialogue.currentText = dialogue.currentText + 1
end

return dialogue