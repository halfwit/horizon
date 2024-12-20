local profile = {};
gcinclude = gFunc.LoadFile('common\\include.lua');

local actions = {

};

local sets = {
    -- Haste == Attack here, useful when sharpshot overcaps us
    ['TpHaste'] = {
        Head = 'Noct Beret +1',
        Neck = 'Peacock Amulet',
        Ear1 = 'Genin Earring',
        Ear2 = 'Drone Earring',
        Body = 'Noct Doublet +1',
        Hands = 'Noct Gloves +1',
        Ring1 = 'Beetle Ring +1',
        --Ring2 = 'Beetle Ring +1',
        Ring2 = 'Rajas Ring',
        Waist = 'Brave Belt',
        Back = 'Nomad\'s Mantle',
        Legs = 'Noct Brais +1',
        Feet = 'Savage Gaiters',
    },
    ['TpBalanced'] = {
        Head = 'Noct Beret +1',
        Neck = 'Peacock Amulet',
        Ear1 = 'Genin Earring',
        Ear2 = 'Drone Earring',
        Body = 'Noct Doublet +1',
        Hands = 'Noct Gloves +1',
        Ring1 = 'Beetle Ring +1',
        --Ring2 = 'Beetle Ring +1',
        Ring2 = 'Rajas Ring',
        Waist = 'Brave Belt',
        Back = 'Nomad\'s Mantle',
        Legs = 'Noct Brais +1',
        Feet = 'Savage Gaiters',
    },
    ['TpAccuracy'] = {
        Head = 'Noct Beret +1',
        Neck = 'Peacock Amulet',
        Ear1 = 'Genin Earring',
        Ear2 = 'Drone Earring',
        Body = 'Noct Doublet +1',
        Hands = 'Noct Gloves +1',
        Ring1 = 'Beetle Ring +1',
        --Ring2 = 'Beetle Ring +1',
        Ring2 = 'Rajas Ring',
        Waist = 'Brave Belt',
        Back = 'Nomad\'s Mantle',
        Legs = 'Noct Brais +1',
        Feet = 'Savage Gaiters',
    },
    ['TpEvasion'] = {
        -- Actual evasion set wip
    },
    ['Kiting'] = {
        -- Same as evasion, with movement speed
    },
    ['WsAccuracy'] = {
        Head = 'Noct Beret +1',
        Neck = 'Peacock Amulet',
        Ear1 = 'Genin Earring',
        Ear2 = 'Optical Earring',
        -- Ear2 = 'Drone Earring',
        Body = 'Noct Doublet +1',
        Hands = 'Noct Gloves +1',
        Ring1 = 'Beetle Ring +1',
        Ring2 = 'Beetle Ring +1',
        Waist = 'Brave Belt',
        Back = 'Nomad\'s Mantle',
        Legs = 'Noct Brais +1',
        Feet = 'Savage Gaiters',
    },
    ['WsDmg'] = {

    }
};

profile.Sets = sets;

profile.Packer = {
};

profile.Macros = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
end

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    gcinclude.Initialize();
    profile.Macros();
end

profile.OnUnload = function()
    gcinclude.Unload();
end

profile.HandleCommand = function(args)
    profile.Macros();
    gcinclude.HandleCommands(args);
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        gFunc.EquipSet('Tp' .. gcinclude.TpVariantTable[gcinclude.TpVariant]);
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
        gFunc.EquipSet(sets.Kiting);
    end
    gcinclude.CheckDefault();
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    -- Check for Sharpshot acc boost
    -- If so, use the higher str set
    gFunc.EquipSet(sets.WsAccuracy);
end

return profile;