local profile = {};
gcinclude = gFunc.LoadFile('common\\include.lua');

local actions = {
    ['Slug Shot']     = 'Livin\' that slug life',
    ['Sidewinder']    = 'Go go gadget Sidewinder!',
    ['Velocity Shot'] = 'MOAR POWER!',
};

local sets = {
    StrBalanced = {
        Head = 'Hunter\'s Beret',
        Neck = 'Spike Necklace',
        Ear1 = 'Genin Earring',
        Ear2 = 'Drone Earring',
        -- Ear2 = 'Brutal Earring',
        Body = 'Shikaree Aketon',
        Hands = 'Hunter\'s Bracers',
        -- Hands = 'Dragon Finger Gauntlets',
        Ring1 = 'Scorpion Ring +1',
        Ring2 = 'Rajas Ring',
        Waist = 'R.K. Belt +1',
        Back = 'Amemet Mantle +1',
        Legs = 'Dusk Trousers',
        Feet = 'Savage Gaiters',
    },
    TpBalanced = {
        Head = 'Hunter\'s beret',
        Neck = 'Peacock Amulet',
        Ear1 = 'Genin Earring',
        -- Ear2 = 'Brutal Earring',
        Ear2 = 'Drone Earring',
        Body = 'Hunter\'s Jerkin',
        -- Hands = 'Seiryu\'s Kote',
        Hands = 'Hunter\'s Bracers',
        Ring1 = 'Scorpion Ring +1',
        Ring2 = 'Rajas Ring',
        Waist = 'R.K. Belt +1',
        Back = 'Amemet Mantle +1',
        Legs = 'Dusk Trousers',
        Feet = 'Hunter\'s Socks',
    },
    StrHaste = {
	    Hands = 'Dusk Gloves',
	    Feet = 'Dusk Ledelsens',
	    Waist = 'Swift Belt',
    },
    TpHaste = {
	    Hands = 'Dusk Gloves',
	    Feet = 'Dusk Ledelsens',
	    Waist = 'Swift Belt',
    },
    StrAccuracy = {

    },
    TpAccuracy = {
        Head = 'Optical Hat',
        Neck = 'Peacock Amulet',
        Ear1 = 'Genin Earring',
        -- Ear2 = 'Brutal Earring',
        Ear2 = 'Drone Earring',
        Body = 'Hunter\'s Jerkin',
        -- Hands = 'Seiryu\'s Kote',
        Hands = 'Hunter\'s Bracers',
        Ring1 = 'Scorpion Ring +1',
        Ring2 = 'Rajas Ring',
        Waist = 'R.K. Belt +1',
        Back = 'Amemet Mantle +1',
        Legs = 'Dusk Trousers',
        Feet = 'Hunter\'s Socks',
    },
    StrEvasion = {

    },
    TpEvasion = {
        Head = 'Optical Hat',
	    Neck = 'Evasion Torque',
	    Ear1 = 'Genin Earring',
	    Ear2 = 'Suppanomimi',
	    Hands = 'Scout\'s Bracers',
	    Ring1 = 'Breeze Ring',
	    Back = 'Nomad\'s Mantle',
	    Waist = 'Scouter\'s Rope',
	    Legs = 'Crow Hose',
    },
    Kiting = {
	    Head = 'Optical Hat',
	    Neck = 'Evasion Torque',
	    Ear1 = 'Genin Earring',
	    Ear2 = 'Suppanomimi',
	    Hands = 'Scout\'s Bracers',
	    Ring1 = 'Breeze Ring',
	    Back = 'Nomad\'s Mantle',
	    Waist = 'Scouter\'s Rope',
	    Legs = 'Crow Hose',
    },
    Emnity = {
        Body = 'Shikaree Aketon',
        -- Head = 'Scout\'s Beret',
        Hands = 'Scout\'s Bracers',
        Head = 'Pumpkin Head',
	    Waist = 'Swift Belt',
        Legs = 'Crow Hose',
    },
    Bow = {
        Range = 'Selene\'s Bow',
        Ammo = 'Demon Arrow',
        Unlimited = 'Cmb.Cst. Arrow',
    },
    Gun = {
        -- Range = 'Hellfire +1',
        Range = 'Musketeer Gun +1',
        Ammo = 'Silver Bullet',
        Unlimited = 'Cannon Shell'
        -- Unlimited = 'Carapace Bullet',
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
    gFunc.EquipSet('TpHaste');
end

profile.HandleMidcast = function()
    gFunc.EquipSet(sets.TpEvasion);
end

profile.HandlePreshot = function()
    profile.handleUnlimitedShot();
end

profile.HandleMidshot = function()
    profile.handleUnlimitedShot();
end

profile.HandleWeaponskill = function()
    local ws = gData.GetAction();
    gcinclude.TelegraphAction(actions, ws.Name);
    profile.handleUnlimitedShot();
end

profile.handleUnlimitedShot = function()
    local us = gData.GetBuffCount('Unlimited Shot');
    local equip = gData.GetEquipment();
    -- Get the right arrow
    if (us == 0) then
        if(equip.Range.Name == sets.Bow.Range) then
            gFunc.Equip('ammo', sets.Bow.Ammo);
        else
            gFunc.Equip('ammo', sets.Gun.Ammo)
        end
    else
        gFunc.EquipSet(sets.StrBalanced);
        if (equip.Range.Name == sets.Bow.Range) then
            gFunc.Equip('ammo', sets.Bow.Unlimited);
        else
            gFunc.Equip('ammo', sets.Gun.Unlimited);
        end
    end
end
return profile;
