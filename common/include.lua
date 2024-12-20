local gcinclude = T{};

local function getKeyByValue(tbl, value)
    for k, v in pairs(tbl) do
        if string.lower(v) == string.lower(value) then
            return k
        end
    end
    return 0 
end

-- Universal sets, fishing/crafting/etc
gcinclude.sets = {
    GatheringFish = {
		Range	= 'Lu Shang\'s F. Rod',
		Body	= 'Fisherman\'s Apron',
        Hands	= 'Angler\'s Gloves',
        Legs	= 'Angler\'s Hose',
        Feet	= 'Angler\'s Boots',
        Ring1	= 'Albatross Ring',
		Ring2	= 'Pelican Ring',
        Waist	= 'Fisherman\'s Belt',
    },
	GatheringLegendary = {
		Range	= 'Lu Shang\'s F. Rod',
        Body	= 'Angler\'s Tunica',
        Hands	= 'Angler\'s Gloves',
        Legs	= 'Angler\'s Hose',
		Feet	= 'Waders',
        Ring1	= 'Albatross Ring',
		Ring2	= 'Pelican Ring',
        Waist	= 'Fisherman\'s Belt',
	},
	GatheringItemFishing = {
		Range	= 'Lu Shang\'s F. Rod',
        Body	= 'Angler\'s Tunica',
        Hands	= 'Angler\'s Gloves',
        Legs	= 'Angler\'s Hose',
        Feet	= 'Angler\'s Boots',
        Ring1	= 'Albatross Ring',
		Ring2	= 'Pelican Ring',
        Waist	= 'Fisherman\'s Belt',
	},
	GatheringLogging = {
		Body	= 'Field Tunica',
		Hands	= 'Field Gloves',
		Gloves	= 'Field Hose',
	},
	CraftingBonecraft = {
		Head	= 'Protective Spectacles',
		Body	= 'Boneworker\'s Apron',
	},
}

-- All Aliases we want
gcinclude.AliasList = T{
	'toggleTreasureHunter',
    'telegraphSkills',
	'changeTPMode',
	'gather',
	'craft',
};

gcinclude.TpVariant = 1;
gcinclude.TreasureHunter = false;
gcinclude.Telegraphed = false;
gcinclude.Gathering = false;
gcinclude.GatheringVariant = 1;
gcinclude.Crafting = false;
gcinclude.CraftingVariant = 1;
gcinclude.sandy = T{'Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille'};
gcinclude.basty = T{'Bastok Mines','Bastok Markets','Port Bastok','Metalworks'};
gcinclude.windy = T{'Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower'};
gcinclude.jeuno = T{'Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno'};


gcinclude.TpVariantTable = {
	[1] = 'Haste',
	[2] = 'Accuracy',
	[3] = 'Balanced',
	[4] = 'Evasion',
};

gcinclude.GatheringVariantTable = {
	[1] = 'Fish',
	[2] = 'Legendary',
	[3] = 'ItemFishing',
	[4] = 'Digging',
	[5] = 'Logging',
	[6] = 'Harvesting',
};

gcinclude.CraftingVariantTable = T{
	[1]	= 'Woodworking',
	[2] = 'Smithing',
	[3] = 'Goldsmithing',
	[4] = 'Clothcraft',
	[5] = 'Leathercraft',
	[6] = 'Bonecraft',
	[7] = 'Alchemy',
	[8] = 'Cooking',
};

function gcinclude.SetAlias()
	for _, v in ipairs(gcinclude.AliasList) do
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /' .. v .. ' /lac fwd ' .. v);
	end
end

function gcinclude.SetBindings()
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F6 /telegraphSkills');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F7 /changeTPMode');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /toggleTreasureHunter');
end

function gcinclude.ClearAlias()
	for _, v in ipairs(gcinclude.AliasList) do
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias del /' .. v);
	end
end

function gcinclude.Unload()
	gcinclude.ClearAlias();
end

function gcinclude.CheckDefault()
	-- Check area for Aketons
	local zone = gData.GetEnvironment();
	if (zone.Area ~= nil) then
		if (gcinclude.sandy:contains(zone.Area)) then gFunc.Equip('Body', 'Kingdom Aketon') end
		if (gcinclude.windy:contains(zone.Area)) then gFunc.Equip('Body', 'Federation Aketon') end
		if (gcinclude.basty:contains(zone.Area)) then gFunc.Equip('Body', 'Republic Aketon') end
	end
	-- Set up fishing based on the current variant
	if (gcinclude.Gathering == true) then 
		local variant = 'Gathering' .. gcinclude.GatheringVariantTable[gcinclude.GatheringVariant];
		gFunc.EquipSet(gcinclude.sets[variant]);
	elseif (gcinclude.Crafting == true) then
		local variant = 'Crafting' .. gcinclude.CraftingVariantTable[gcinclude.CraftingVariant];
		gFunc.EquipSet(gcinclude.sets[variant]);
	end
end

function gcinclude.Initialize()
	-- Load some defaults
    AshitaCore:GetChatManager():QueueCommand(-1, '/fps 1');
	AshitaCore:GetChatManager():QueueCommand(-1, '/localsettings blureffect off');
    AshitaCore:GetChatManager():QueueCommand(-1, '/addon load xicamera');
	AshitaCore:GetChatManager():QueueCommand(-1, '/addon load points');

	-- Run our init
	gcinclude.SetAlias:once(2);
    gcinclude.SetBindings();
end

function gcinclude.TelegraphAction(actions, target)
	if not gcinclude.Telegraphed then return end
	AshitaCore:GetChatManager():AddChatMessage(4, 0, actions[target]);
end

function gcinclude.HandleCommands(args)
	if not gcinclude.AliasList:contains(args[1]) then return end
	if (args[1] == 'toggleTreasureHunter') then
		gcinclude.TreasureHunter = (gcinclude.TreasureHunter == false);
		print('TH3: ' .. ((gcinclude.TreasureHunter == true) and '\31\213Enabled' or '\31\167Disabled'));
	elseif (args[1] == 'telegraphSkills') then
		gcinclude.Telegraphed = (gcinclude.Telegraphed == false);
		print('Action telegraphing: ' .. ((gcinclude.Telegraphed == true) and '\31\213Enabled' or '\31\167Disabled'));
    elseif (args[1] == 'changeTPMode') then
        gcinclude.TpVariant = gcinclude.TpVariant + 1;
        if (gcinclude.TpVariant > #gcinclude.TpVariantTable) then
            gcinclude.TpVariant = 1;
       	end
        print('TP Set: \31\220' .. gcinclude.TpVariantTable[gcinclude.TpVariant]);
	elseif (args[1]) == 'crafting' then
		gcinclude.Crafting = true;
		gcinclude.Gathering = false; -- just in case
		-- Check our table for an entry, else it's likely 'cancel', 'exit', etc
		gcinclude.CraftingVariant = getKeyByValue(gcinclude.CraftingVariantTable, args[2]);
		if (gcinclude.CraftingVariant == 0 or args[2] == 'cancel') then
			print('Crafting mode: \31\167off');
			gcinclude.Crafting = false;
		elseif (gcinclude.Crafting) then
			AshitaCore:GetChatManager():QueueCommand(-1, '/macro book 6');
    		AshitaCore:GetChatManager():QueueCommand(-1, '/macro set 1');
			print('Crafting mode: \31\213' .. gcinclude.CraftingVariantTable[gcinclude.CraftingVariant]);
		end
    elseif (args[1] == 'gather') then
		gcinclude.Gathering = true;
		gcinclude.Crafting = false; -- just in case
		-- Check our table for an entry, else it's likely 'cancel', 'exit', etc
		gcinclude.GatheringVariant = getKeyByValue(gcinclude.GatheringVariantTable, args[2]);
		if (gcinclude.GatheringVariant == 0 or args[2] == 'cancel') then
			AshitaCore:GetChatManager():QueueCommand(-1, '/addon unload hgather');
            print('Gathering mode: \31\167off');
			gcinclude.Gathering = false;
		elseif (gcinclude.Gathering) then
			AshitaCore:GetChatManager():QueueCommand(-1, '/addon load hgather');
            AshitaCore:GetChatManager():QueueCommand(-1, '/macro book 6');
    		AshitaCore:GetChatManager():QueueCommand(-1, '/macro set 1');
			print('Gathering mode: \31\213' .. gcinclude.GatheringVariantTable[gcinclude.GatheringVariant]);
		end
	end
end

return gcinclude;
