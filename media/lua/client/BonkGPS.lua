require "ISUI/ISCollapsableWindow"

BonkGPS = {};

BonkGPS.doMenu = function(player, context, items)
    if #items > 1 then 
        return
    end 

    for i,v in ipairs(items) do
        local tempitem = v;
        if not instanceof(v, "InventoryItem") then
            tempitem = v.items[1];
        end

        if tempitem:getType() == "GPS" then 
            local value = v:getModData().testValue;
            print("testValue: ", value)
            context:addOption("Hallo Dikke Man", worldobjects, BonkGPS.test, player, tempitem);
        end 

		-- 
        
		-- if(getSpecificPlayer(player):getInventory():contains(tempitem) == false) then
		-- 	if (tempitem:getType().find(tempitem:getType(),HCSleepKey) ~= nil) then
		-- 		
		-- 	end
		-- 	if (tempitem:getType().find(tempitem:getType(),HCRestKey) ~= nil) then
		-- 		context:addOption(getText("ContextMenu_Rest"), worldobjects, HCSleep.onRest, player, sleep);
		-- 	end
		-- end
	end
end

BonkGPS.test = function(item, player, target)
    print("I have u dun been pressed")

    local panel = ISCollapsableWindow:new(300, 300, 300, 300);
    panel:initialise();
    panel:addToUIManager();

    print("panel")
    print(panel)

    if target:getModData().testValue == nil then
        target:getModData().testValue = 1
    else 
        target:getModData().testValue = target:getModData().testValue + 1
    end
end

Events.OnFillInventoryObjectContextMenu.Add(BonkGPS.doMenu);