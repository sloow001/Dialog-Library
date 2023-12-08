# Dialog library

A simple library to create dialogues with love2D

## Loading the Dialogue

```lua
dialogue.load("your-dialogue-path")
```

## Updating the dialog

```lua
function love.keypressed(key)
    if key == "space" then
        dialogue.nextText()
    end
end
```

## Drawing the box
We are drawing in a if just to avoid bugs
```lua
function love.draw()
    if dialogue.data and dialogue.getCurrentText() then
        local dialogWidth = love.graphics.getWidth() - 40
        local dialogHeight = 120

        dialogue.drawDialogBox(dialogWidth, dialogHeight)
    end
end
```

## Json archive structure
For your dialog to work correctly, the structure of your json file must be like this:
```json
{
    "dialogue": [
        {
            "character": "Character 1",
            "text": "Hello, this is a dialogue box"
        },
        {
            "character": "Character 2",
            "text": "So, why u are here?"
        },
        {
            "character": "Character 1",
            "text": "Oh... u want to test this right?"
        },
        {
            "character": "Character 2",
            "text": "Okay, continue"
        }
    ]
}
```

# Here is a simple example with 2 dialogues
```lua
local dialogue = require "libraries.dialogue-lib"

function love.load()
    love.graphics.setBackgroundColor(0,0,1)

    if dialogue.load("dialogues/dialogue-test.json") then
        print("Loaded dialogue!")
        print(dialogue.getCurrentText())
    else
        print("Failed to load dialog")
    end

end

function love.update(dt)

end

function love.keypressed(key)
    if key == "space" then
        dialogue.nextText()
        print(dialogue.getCurrentText())
    elseif key == "backspace" then
        dialogue.load("dialogues/dialogue-second-test.json")
    end
end

function love.draw()
    if dialogue.data and dialogue.getCurrentText() then
        local dialogWidth = love.graphics.getWidth() - 40
        local dialogHeight = 120

        dialogue.drawDialogBox(dialogWidth, dialogHeight)
    end
end
``` 

## Credits
### [Json Library - Actboy168](https://github.com/actboy168/json.lua)
