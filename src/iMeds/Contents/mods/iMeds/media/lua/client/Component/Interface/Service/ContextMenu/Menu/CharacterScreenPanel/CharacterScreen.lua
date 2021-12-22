CharacterScreen = {}
CharacterScreen.render = ISCharacterScreen.render

function ISCharacterScreen:render()
    CharacterScreen.render(self)

    if Survivor:isKnowOwnBloodGroup() then
        local textWidth = math.max(0, getTextManager():MeasureStringX(UIFont.Small, Survivor:getBlood():getGroup():getName()))
        self:drawText(Survivor:getBlood():getGroup():getName(), self.width - 20 - textWidth, 40, 1, 1, 1, 1, UIFont.Small);
    end
end