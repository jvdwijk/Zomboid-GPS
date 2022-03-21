require "ISUI/ISCollapsableWindow"
require "ISUI/ISButton"
require "BonkFrequencyBar"

BonkGpsUI = ISCollapsableWindow:derive("BonkGpsUI");

BonkGpsUI.maxFrequency = 300;
BonkGpsUI.minFrequency = 0;

function BonkGpsUI:new(x, y, gps)
    local o = {};
    o = ISCollapsableWindow:new(x, y, 400, 500)
    setmetatable(o, self);
    self._index = self;
    o:setResizable(false);
    o.gps = gps;

    if gps:getModData().frequency == nil then
        gps:getModData().frequency = 0
    end 

    if gps:getModData().isOn == nil then
        gps:getModData().isOn = true
    end 

    return o;
end

function BonkGpsUI:initialise()

    local spacing = 10;
    local buttonCount = 3;

    local buttonHeight = 50;
    local negativeRowY = self.height - spacing - buttonHeight;
    local positiveRowY = self.height - spacing * 2 - buttonHeight * 2;

    local buttonWidth = self.width / buttonCount - spacing - spacing / buttonCount;

    self.addOneButton = self:createFrequencyChangeButton(spacing, positiveRowY, buttonWidth, buttonHeight, 1)
    self.addTenButton = self:createFrequencyChangeButton(spacing * 2 + buttonWidth, positiveRowY, buttonWidth, buttonHeight, 10)
    self.addHundredButton = self:createFrequencyChangeButton(spacing * 3 + buttonWidth * 2, positiveRowY, buttonWidth, buttonHeight, 100)

    self.subtractOneButton = self:createFrequencyChangeButton(spacing, negativeRowY, buttonWidth, buttonHeight, -1)
    self.subtractTenButton = self:createFrequencyChangeButton(spacing * 2 + buttonWidth, negativeRowY, buttonWidth, buttonHeight, -10)
    self.subtractHundredButton = self:createFrequencyChangeButton(spacing * 3 + buttonWidth * 2, negativeRowY, buttonWidth, buttonHeight, -100)

    self.frequencyBar = BonkFrequencyBar:new(10, 30, self.width-20, 50);
    self.frequencyBar:initialise();



    self.onOffButton = ISButton:new(10, 100, self.width - 20, 50, "", self, BonkGpsUI.switchGpsOnState)
    self.onOffButton:initialise();
    self:addChild(self.onOffButton);
    self:updateOnOffButtonText();

    self:updateFrequencyText();
    self:addChild(self.frequencyBar);
end


function BonkGpsUI:createFrequencyChangeButton(x, y, width, height, amount)
    local numberString = tostring(amount);

    if(amount > 0) then
        numberString = "+" .. numberString;
    end

    local button = ISButton:new(x, y, width, height, numberString, self, function () self:changeFrequency(amount) end)
    button:initialise();
    self:addChild(button);
    return button;
end

function BonkGpsUI:changeFrequency(amount)
    local newFrequency = math.min(BonkGpsUI.maxFrequency, math.max(BonkGpsUI.minFrequency, self.gps:getModData().frequency + amount))
    if self.gps:getModData().frequency == newFrequency then
        return;
    end
    self.gps:getModData().frequency = newFrequency;
    self:updateFrequencyText();
end

function BonkGpsUI:updateFrequencyText()
    self.frequencyBar:setFrequency(self.gps:getModData().frequency);
end

function BonkGpsUI:switchGpsOnState()
    self.gps:getModData().isOn = not self.gps:getModData().isOn 
    self:updateOnOffButtonText();
end

function BonkGpsUI:updateOnOffButtonText()
    local onOffButtonTitle = "Turn On";
    if self.gps:getModData().isOn then
        onOffButtonTitle = "Turn Off";
    end
    self.onOffButton.title = onOffButtonTitle;
end