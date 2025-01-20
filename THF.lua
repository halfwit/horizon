local profile = {};
gcinclude = gFunc.LoadFile('common\\include.lua');

local actions = {
	['Shark Bite']      = 'Gonna take a chomp outta this <t>! Shark Bite',
	['Evisceration']	= 'Exsanguinate. Eviscerate. Exterminate.',
	['Accomplice']		= 'Accomplice <t>',
	['Collaborator']	= 'Collaborator <t>',
};

local sets = {
    TpHaste = {
        Head	= 'Panther Mask',
        Neck	= 'Peacock Amulet',
        Ear1	= 'Brutal Earring',
        Ear2	= 'Suppanomimi',
        Body	= 'Rapparee Harness',
        Hands	= 'Dusk Gloves',
        Ring1	= 'Toreador\'s Ring',
        Ring2	= 'Rajas Ring',
        Back	= 'Amemet Mantle +1',
        Waist	= 'Swift Belt',
        Legs	= 'Homam Cosciales',
        Feet	= 'Dusk Ledelsens',
    },
    TpBalanced = {
        Head	= 'Optical Hat',
        Neck	= 'Peacock Amulet',
        Ear1	= 'Brutal Earring',
        Ear2	= 'Suppanomimi',
        Body	= 'Rapparee Harness',
        Hands	= 'Dusk Gloves',
        Ring1	= 'Toreador\'s Ring',
        Ring2	= 'Rajas Ring',
        Back	= 'Amemet Mantle +1',
        Waist	= 'Swift Belt',
        Legs	= 'Homam Cosciales',
        Feet	= 'Dusk Ledelsens',
    },
    TpAccuracy = {
        Head = 'Optical Hat',
        Neck	= 'Peacock Amulet',
        Ear1	= 'Optical Earring',
        Ear2	= 'Suppanomimi',
        Body	= 'Scorpion Harness',
        Hands	= 'War Gloves +1',
        Ring1	= 'Toreador\'s Ring',
        Ring2	= 'Rajas Ring',
        Back	= 'Amemet Mantle +1',
        Waist	= 'Swift Belt',
        Legs	= 'Dragon Subligar',
        Feet	= 'Dusk Ledelsens',
    },
    Kiting = {
        Head = 'Optical Hat',
        Body	= 'Scorpion Harness',
        Neck	= 'Evasion Torque',
        Ear1	= 'Genin Earring',
        Ear2	= 'Suppanomimi',
        Hands	= 'War Gloves +1',
        Ring1	= 'Breeze Ring',
        Ring2	= 'Rajas Ring',
        Back	= 'Nomad\'s Mantle',
        Waist	= 'Scouter\'s Rope',
        Legs	= 'Crow Hose',
        Feet	= 'Dance Shoes',
	-- Feet	= 'Trotters Boots',
    },
    SneakAttack = {
        Head	= 'Assassin\'s Bonnet',
        Neck	= 'Spike Necklace',
        Ear1	= 'Spike Earring',
        Ear2	= 'Suppanomimi',
        Body	= 'Dragon Harness',
        Hands	= 'Hecatomb Mittens',
        Ring1	= 'Thunder Ring',
        Ring2	= 'Rajas Ring',
        Back	= 'Amemet Mantle +1',
        Waist	= 'Warwolf Belt',
        Legs	= 'Dragon Subligar',
        Feet	= 'Hct. Leggings',
    },
    TpEvasion = {
        Head = 'Optical Hat',
        Body	= 'Scorpion Harness',
        Neck	= 'Evasion Torque',
        Ear1	= 'Brutal Earring',
        Ear2	= 'Suppanomimi', 
        Hands	= 'War Gloves +1',
        Ring1	= 'Breeze Ring',
        Ring2	= 'Rajas Ring',
        Back	= 'Nomad\'s Mantle',
        Waist	= 'Scouter\'s Rope',
        Legs	= 'Crow Hose',
        Feet	= 'Dance Shoes',
	   -- Feet	= 'Dance Shoes +1',
    },
    Ranged = {
        Head	= 'Optical Hat',
        Neck	= 'Peacock Amulet',
        Ear1	= 'Drone Earring',
        Ear2	= 'Genin Earring',
        Body	= 'Dragon Harness',
        Hands	= 'Dragon Mittens',
        Ring1	= 'Behemoth Ring',
        Ring2	= 'Behemoth Ring',
        Back	= 'Amemet Mantle +1',
        Waist	= 'Ryl.Kgt. Belt +1',
        Legs	= 'Dusk Trousers',
        Feet	= 'Dragon Leggings',
    },
    TrickAttack = {
        Head	= 'Dragon Cap',
        Neck	= 'Spike Necklace',
        Ear1	= 'Spike Earring',
        Ear2	= 'Suppanomimi',
        Body	= 'Dragon Harness',
        Hands	= 'Rog. Armlets +1',
        Ring1	= 'Breeze Ring',
        Ring2	= 'Rajas Ring',
        Back	= 'Amemet Mantle +1',
        Waist	= 'Warwolf Belt',
        Legs	= 'Rogue\'s Culottes',
        Feet	= 'Dragon Leggings',
    },
    Steal = {
        Head	= 'Rogue\'s Bonnet',
        Hands	= 'Thief\'s Kote',
        Legs	= 'Rogue\'s Culottes',
        Feet	= 'Rogue\'s Poulaines',
    },
};
profile.Sets = sets;
profile.Packer = {
    -- Shihei, Shinobi Tabi, food, bolts, etc
};

profile.Macros = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
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
    local sa = gData.GetBuffCount('Sneak Attack');
    local ta = gData.GetBuffCount('Trick Attack');

    -- Catch our SATA states, otherwise use our normal variant check
	if (sa == 1) then
        gFunc.EquipSet(sets.SneakAttack);
    elseif (ta == 1) then
        gFunc.EquipSet(sets.TrickAttack);
    else
        if (player.Status == 'Engaged') then
            gFunc.EquipSet('Tp' .. gcinclude.TpVariantTable[gcinclude.TpVariant]);
            if (gcinclude.TreasureHunter == true) then
                gFunc.Equip('Neck', 'Nanaa\'s Charm');
            end
        elseif (player.Status == 'Resting') then
            gFunc.EquipSet(sets.Resting);
        else
            gFunc.EquipSet(sets.Kiting);
        end
        gcinclude.CheckDefault();
    end
end

profile.HandleAbility = function()
    local action = gData.GetAction();
    if (action.Name == 'Sneak Attack') then
        gFunc.EquipSet(sets.SneakAttack);
    elseif (action.Name == 'Trick Attack') then
        gFunc.EquipSet(sets.TrickAttack);
    elseif (action.Name == 'Steal') then
        gFunc.EquipSet(sets.Steal);
    elseif (action.Name == 'Hide') then
        gFunc.Equip('Body', 'Rogue\'s Vest');
    elseif (action.Name == 'Flee') then
        gFunc.Equip('Feet', 'Rogue\'s Poulaines');
    end
    gcinclude.TelegraphAction(actions, action.Name);
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    gFunc.EquipSet(sets.TpEvasion);
    gFunc.Equip('Legs', 'Homam Cosciales');
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
	gFunc.EquipSet(sets.Ranged);
end

profile.HandleWeaponskill = function()
	-- We can really curate to Evisceration/Shark Bite/Dancing Edge and whether we use SA, TA, or neither here.
    local ws = gData.GetAction();
	if string.match(ws.Name, 'Evisceration') then
        -- TODO: Create a evisceration-specific set
		gFunc.EquipSet(sets.SneakAttack);
		gFunc.Equip('body', 'Hecatomb Harness');
	end
    gcinclude.TelegraphAction(actions, ws.Name);
end

return profile;
