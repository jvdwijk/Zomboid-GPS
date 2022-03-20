require "ISUI/ISPanel"
require "ISUI/ISUIElement"

BonkFrequencyBar = ISPanel:derive("BonkFrequencyBar");


function BonkFrequencyBar:new (x, y, width, height)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self);
    self._index = self;

    o.lcdback = getTexture("media/ui/LCD_Display/LCDfont_background_greyscale.png");

    o.lcdGreen = {
        text = { r=0.180, g=0.2, b=0.039, a=1.0 },
        back = { r=0.686, g=0.764, b=0.172, a=1.0 },
    };
    o.background = true;
    o.font = UIFont.NewLarge;
    self.text = ""
    return o;
end

function BonkFrequencyBar:initialise()
    ISPanel:initialise();
end

function BonkFrequencyBar:render()
    ISPanel.render(self);
    local backColor = self.lcdGreen.back;
    self:drawTextureScaled(self.lcdback, 0, 0, self.width, self.height, backColor.a, backColor.r, backColor.g, backColor.b);

    local textHeight = getTextManager():MeasureStringY(self.font, self.text)
    self:drawTextRight(self.text, self.width, (self.height/2) - (textHeight / 2) , 0, 0, 0, 1, self.font)
    
end

function BonkFrequencyBar:setFrequency(frequency)
    local test = UIFont;
    self.text = tostring(frequency) .. " hz"
end