require "bonkGpsUI"

BonkGPS.EveryTenMinutes = function()
    local time = getGameTime();
    local player = getPlayer();
    local inv = player:getInventory();
    local pos = BonkGPS.getPos(player);

    local GPSData = inv:FindAll("GPS")
    for i=0,GPSData:size()-1 do
        if GPSData:get(i):getModData().isOn ~= nil and GPSData:get(i):getModData().isOn == true then
            local chan = GPSData:get(i):getModData().frequency
            if chan == nil then
                chan = 0
            end
            sendClientCommand(player, 'BonkGPS', 'BonkGPSPosUpdate', {
                Pos = pos,
                GameTime = time:getHour() .. time:getMinutes(),
                Channel = chan,
            })
        end
    end

    
end

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
            context:addOption("Open GPS Menu", worldobjects, BonkGPS.test, player, tempitem);
        end 
	end
end

BonkGPS.getPos = function(player)
	local vehicle = player:getVehicle()

	if vehicle then
		return {x = vehicle:getX(), y = vehicle:getY(), z = player:getZ()}
	else
		return {x = player:getX(), y = player:getY(), z = player:getZ()}
	end
end

BonkGPS.test = function(item, player, target)
    local panel = BonkGpsUI:new(400, 400, target);
    panel:initialise();
    panel:addToUIManager();

    if target:getModData().testValue == nil then
        target:getModData().testValue = 1
    else 
        target:getModData().testValue = target:getModData().testValue + 1
    end
end

Events.EveryTenMinutes.Add(BonkGPS.EveryTenMinutes)
Events.OnFillInventoryObjectContextMenu.Add(BonkGPS.doMenu);