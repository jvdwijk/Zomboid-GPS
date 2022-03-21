
BonkGPS.ClientCommand = function(module, command, player, args)
    if module ~= BonkGPS.MOD_ID then
        return
    end
    print("Pos x:", args.Pos.x .." y:".. args.Pos.y, " Channel: ", args.Channel, "Time: ",args.GameTime)
end

Events.OnClientCommand.Add(BonkGPS.ClientCommand)