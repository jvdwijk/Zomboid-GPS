BonkGPS = {};

BonkGPS.doMenu = function(player, context, items)
    -- print("Items:", dump(items))

    for i,v in ipairs(items) do

        if v.name == "Ultra High Def GPS" then 
            print("Je dikke mama")
            context:addOption("Hallo Dikke Man", worldobjects, BonkGPS.test, player);
        end 

		-- local tempitem = v;
        -- if not instanceof(v, "InventoryItem") then
        --     tempitem = v.items[1];
        -- end
        
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

BonkGPS.test = function(item, player)
    print("I have u dun been pressed")
end

Events.OnFillInventoryObjectContextMenu.Add(BonkGPS.doMenu);