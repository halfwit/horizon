local profile = {};
gcinclude = gFunc.LoadFile('common\\include.lua');

local actions = {
    ['Slug Shot']     = 'Livin\' that slug life',
    ['Sidewinder']    = 'Go go gadget Sidewinder!',
    ['Velocity Shot'] = 'MOAR POWER!',
};

local sets = {
    ['StrBalanced'] = {
        Head = 'Hunter\'s Beret',
        Neck = 'Spike Necklace',
        Ear1 = 'Genin Earring',
        Ear2 = 'Drone Earring',
        Body = 'Shikaree Aketon',
        Hands = 'Noct Gloves +1',
        Ring1 = 'Marksman\'s Ring',
        Ring2 = 'Rajas Ring',
        Waist = 'Ryl.Kgt. Belt',
        Back = 'Nomad\'s Mantle',
        Legs = 'Noct Brais +1',
        Feet = 'Savage Gaiters',
    },
    ['TpBalanced'] = {
        Head = 'Hunter\'s beret',
        Neck = 'Peacock Amulet',
        Ear1 = 'Genin Earring',
        Ear2 = 'Drone Earring',
        Body = 'Hunter\'s jerkin',
        Hands = 'Noct Gloves +1',
        Ring1 = 'Marksman\'s Ring',
        Ring2 = 'Rajas Ring',
        Waist = 'Ryl.Kgt. Belt',
        Back = 'Nomad\'s Mantle',
        Legs = 'Noct Brais +1',
        Feet = 'Savage Gaiters',
    },
    ['TpHaste'] = {
    },
    ['TpAccuracy'] = {
    },
    ['TpEvasion'] = {
        -- Actual evasion set wip
    },
    ['Kiting'] = {
        -- Same as evasion, with movement speed
    },
    ['Emnity'] = {
        Body = 'Shikaree Aketon',
        Head = 'Pumpkin Head'
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
    gcinclude.TpVariant = 3;
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
    local ss = gData.GetBuffCount('Sharpshot');
    if (player.Status == 'Engaged') then
        if(ss  == 1) then
            gFunc.EquipSet('Str' .. gcinclude.TpVariantTable[gcinclude.TpVariant]);
        else
            gFunc.EquipSet('Tp' .. gcinclude.TpVariantTable[gcinclude.TpVariant]);
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else
        gFunc.EquipSet(sets.Kiting);
    end
    gcinclude.CheckDefault();
end

profile.HandleAbility = function()
    local action = gData.GetAction();
    -- Minus emnity anywhere we don't do DPS
    gFunc.EquipSet('Emnity');
    if (action.Name == 'Camouflage') then
        gFunc.Equip('Body', 'Hunter\'s Jerkin');
    elseif (action.Name == 'Scavenge') then
        gFunc.Equip('Feet', 'Hunter\'s Socks');
    elseif(action.Name == 'Shadowbind') then
        gFunc.Equip('Hands', 'Hunter\'s Bracers');
    elseif(action.Name == 'Sharpshot') then
        gFunc.Equip('Legs', 'Hunter\'s Braccae');
    end
    gcinclude.TelegraphAction(actions, action.Name);
end

profile.HandleItem = function()
end

-- Before we cast a spell like utsu
profile.HandlePrecast = function()
    gFunc.EquipSet('Emnity');
end

profile.HandleMidcast = function()
    gFunc.EquipSet(sets.TpEvasion);
end

profile.HandlePreshot = function()
    -- Check if we can Unlimited shot?
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    gcinclude.TelegraphAction(actions, ws.Name);
end

return profile;
