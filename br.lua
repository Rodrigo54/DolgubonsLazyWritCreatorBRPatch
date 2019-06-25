-----------------------------------------------------------------------------------
-- Addon Name: Dolgubon's Lazy Writ Crafter
-- Creator: Dolgubon (Joseph Heinzle)
-- Addon Ideal: Simplifies Crafting Writs as much as possible
-- Addon Creation Date: March 14, 2016
--
-- File Name: Languages/default.lua
-- File Description: Brazilian Localization
-- File translator: @rodrigo5
-- File Creation Date: April 03, 2019
-----------------------------------------------------------------------------------

local function proper(str)
	if type(str)== "string" then
		return zo_strformat("<<C:1>>",str)
	else
		return str
	end
end

-- Languages/default.lua translate --
-- line 28 in original file
-- This is in the default, so that if a new setting is added an error is not thrown, 
-- and the addon instead uses the English option strings for any that are missing.

local function runeMissingFunction (ta,essence,potency)
	local missing = {}
	if not ta["bag"] then
		missing[#missing + 1] = "|rТa|cf60000"
	end
	if not essence["bag"] then
		missing[#missing + 1] =  "|cffcc66"..essence["slot"].."|cf60000"
	end
	if not potency["bag"] then
		missing[#missing + 1] = "|c0066ff"..potency["slot"].."|r"
	end
	local text = ""
	for i = 1, #missing do
		if i ==1 then
			text = "|cf60000Um glifo não pode ser criado. Você não tem runas"..proper(missing[i])
		else
			text = text.." ou "..proper(missing[i])
		end
	end
	return text
end


local function dailyResetFunction(till, stamp) 	-- You can translate the following simple version instead.
												-- function (till) d(zo_strformat("<<1>> hours and <<2>> minutes until the daily reset.",till["hour"],till["minute"])) end,
	if till["hour"]==0 then
		if till["minute"]==1 then
			return "1 minuto para resetar as missões diárias!"
		elseif till["minute"]==0 then
			if stamp==1 then
				return "As missões diárias serão resetadas em "..stamp.." segundos!"
			else
				return "As missões diárias serão resetadas em alguns segundos! Tenha paciência"
			end
		else
			return till["minute"].." minutos para resetar as missões diárias!"
		end
	elseif till["hour"]==1 then
		if till["minute"]==1 then
			return till["hour"].." hora e "..till["minute"].." minuto para resetar as missões diárias!"
		else
			return till["hour"].." hora e "..till["minute"].." minutos para resetar as missões diárias!"
		end
	else
		if till["minute"]==1 then
			return till["hour"].." horas e "..till["minute"].." minuto para resetar as missões diárias!"
		else
			return till["hour"].." horas e "..till["minute"].." minutos para resetar as missões diárias!"
		end
	end 
end

local function masterWritEnchantToCraft (pat,set,trait,style,qual,mat,writName,Mname,generalName)
	local partialString = zo_strformat("Criar item \"<<t:6>> <<t:1>>\" уровня оч 150, комплекта \"<<t:2>>\" с особенностью \"<<t:3>>\" и в стиле \"<<t:4>>\" с качеством \"<<t:5>>\"",pat,set,trait,style,qual,mat)
	return zo_strformat("<<t:2>> <<t:3>> <<t:4>>: <<1>>",partialString,writName,Mname,generalName )
end


WritCreater.strings =
{
	["runeReq"] 					= function (essence, potency) return zo_strformat("|c2dff00A fabricação precisa de 1 |rТа|c2dff00, 1 |cffcc66<<1>>|c2dff00 e 1 |c0066ff<<2>>|r", essence, potency) end,
	["runeMissing"] 				= runeMissingFunction,
	["notEnoughSkill"]				= "Você não tem um nível de habilidade alto o suficiente para criar o equipamento necessário",
	["smithingMissing"] 			= "\n|cf60000Você não tem materiais suficientes|r",
	["craftAnyway"] 				= "Crie o que você puder",
	["smithingEnough"] 				= "\n|c2dff00Você tem materiais suficientes|r",
	["craft"] 						= "|c00ff00Fabricar|r",
	["crafting"] 					= "|c00ff00Fabricando...|r",
	["craftIncomplete"] 			= "|cf60000A fabricação não pôde ser concluída.\nVocê precisa de mais materiais...|r",
	["moreStyle"] 					= "|cf60000Você não tem material de estilo.\npara o estilo escolhido|r",
	["moreStyleSettings"]			= "|cf60000Você não tem nenhum material de estilo disponível.\nVocê pode precisar permitir mais estilos nas configurações do addon.|r",
	["moreStyleKnowledge"]			= "|cf60000Você não tem nenhum material de estilo disponível.\nVocê pode precisar aprender mais estilos de artesanato.|r",
	["dailyreset"] 					= dailyResetFunction,
	["complete"] 					= "|c00FF00Encomenda concluída.|r",
	["craftingstopped"]				= "Fabricação parada. Por favor, verifique se o addon criou os itens certos.",
	["smithingReqM"] 				= function (amount, type, more) return zo_strformat( "A Fabricação precisa de <<1>> <<2>> (|cf60000Você precisa de mais<<3>>|r)" ,amount, type, more) end,
	["smithingReq"] 				= function (amount,type, current) return zo_strformat( "A Fabricação precisa de <<1>> <<2>> (|c2dff00<<3>> já disponível|r)"  ,amount, type, current) end,
	["lootReceived"]				= "Item recebido <<1>> (Agora você os tem <<2>>)",
	["lootReceivedM"]				= "Item recebido <<1>>",
	["countSurveys"]				= "Pesquisa disponível: <<1>>",
	["countVouchers"]				= "Existem encomendas de vouchers não cobrados: <<1>>",
	["includesStorage"] 			= function(type) local a= {"Mapa", "Ordens Mestre"} a = a[type] return zo_strformat("Contando inclui <<1>> em armazenamento doméstico", a) end,
	["surveys"]						= "Crafting Surveys",
	["sealedWrits"]					= "Ordens Seladas",
	["masterWritEnchantToCraft"]	= function(lvl, type, quality, writCraft, writName, generalName) 
										return zo_strformat("<<t:4>> <<t:5>> <<t:6>>: Fabrique um <<t:1>> glifo de <<t:2>> nivel \"<<t:3>>\"",lvl, type, quality,
											writCraft,writName, generalName) end,
	["masterWritSmithToCraft"]		= masterWritEnchantToCraft,
	["withdrawItem"]				= function(amount, link, remaining) return "Dolgubon's Lazy Writ Crafter retrieved "..amount.." "..link..". ("..remaining.." in bank)" end, -- in Bank for German
	['fullBag']						= "Você não tem mais espaço. Por favor, esvazie sua bolsa.",
	['masterWritSave']				= "Dolgubon's Lazy Writ Crafter evitou você de acidentalmente aceitar um mandado de mestre! Vá para o menu de configurações para desativar essa opção.",
	['missingLibraries']			= "Dolgubon's Lazy Writ Crafter requer as seguintes bibliotecas. Faça o download, instale ou ative estas bibliotecas: ",
	['resetWarningMessageText']		= "As missões diárias serão resetadas em <<1>> hora e <<2>> minutos\nVocê pode personalizar ou desativar este aviso nas configurações.",
	['resetWarningExampleText']		= "O aviso será semelhante a este",

}


WritCreater.optionStrings = WritCreater.optionStrings or {}
WritCreater.optionStrings["nowEditing"]						= "Você está alterando as configurações de %s"
WritCreater.optionStrings["accountWide"]					= "Em toda a Conta"
WritCreater.optionStrings["characterSpecific"]				= "Apenas no Personagem"
WritCreater.optionStrings["useCharacterSettings"]			= "Use as configurações do personagem"
WritCreater.optionStrings["useCharacterSettingsTooltip"]	= "Use as configurações específicas de um personagem apenas neste personagem."
WritCreater.optionStrings["style tooltip"]                  = function (styleName) return zo_strformat("Permita que o estilo <<1>>, que usa a pedra do estilo <<2>>, seja usado na fabricação", styleName) end 
WritCreater.optionStrings["show craft window"]              = "Mostrar janela de fabricação"
WritCreater.optionStrings["show craft window tooltip"]    	= "Mostrar janela de fabricação quando uma estação de produção está aberta"
WritCreater.optionStrings["autocraft"]                      = "Auto Fabricação"
WritCreater.optionStrings["autocraft tooltip"]              = "Selecionar isso fará com que o addon comece a criar imediatamente ao entrar em uma estação de criação. Se a janela não for mostrada, isso será ativado."
WritCreater.optionStrings["blackmithing"]                   = "Ferraria"
WritCreater.optionStrings["blacksmithing tooltip"]          = "Ativar o addon para Ferraria"
WritCreater.optionStrings["clothing"]                       = "Alfaiataria"
WritCreater.optionStrings["clothing tooltip"]               = "Ativar o addon para Alfaiataria"
WritCreater.optionStrings["enchanting"]                     = "Encantamento"
WritCreater.optionStrings["enchanting tooltip"]             = "Ativar o addon para Encantamento"
WritCreater.optionStrings["alchemy"]                        = "Alquimia"
WritCreater.optionStrings["alchemy tooltip"]   	            = "Ativar o addon para Alquimia"
WritCreater.optionStrings["provisioning"]                   = "Cozinha"
WritCreater.optionStrings["provisioning tooltip"]           = "Ativar o addon para Cozinha"
WritCreater.optionStrings["woodworking"]                    = "Marcenaria"
WritCreater.optionStrings["woodworking tooltip"]            = "Ativar o addon para Marcenaria"
WritCreater.optionStrings["jewelry crafting"]				= "Joalheria"
WritCreater.optionStrings["jewelry crafting tooltip"]		= "Ativar o addon para Joalheria"
WritCreater.optionStrings["writ grabbing"]					= "Retirar itens para fabricação"
WritCreater.optionStrings["writ grabbing tooltip"]			= "Pegue os itens necessários para as encomendas (por exemplo, nirnroot, Ta, etc.) do banco"
WritCreater.optionStrings["delay"]                          = "Atraso da Retirada do Item"
WritCreater.optionStrings["delay tooltip"]					= "Quanto tempo esperar antes de pegar itens do banco (milissegundos)"
WritCreater.optionStrings["style stone menu"]				= "Pedras de Estilo Usadas"
WritCreater.optionStrings["style stone menu tooltip"]		= "Escolha quais pedras de estilo o addon usará"
WritCreater.optionStrings["send data"]                      = "Enviar dados de fabricação"
WritCreater.optionStrings["send data tooltip"]              = "Envie informações sobre as recompensas recebidas de suas caixas de fabricação. Nenhuma outra informação é enviada."
WritCreater.optionStrings["exit when done"]					= "Sair da janela de fabricação"
WritCreater.optionStrings["exit when done tooltip"]			= "Saia da janela de fabricação quando todos os itens forem criados"
WritCreater.optionStrings["automatic complete"]				= "Diálogo de missões automáticos"
WritCreater.optionStrings["automatic complete tooltip"]		= "Aceita e conclui automaticamente as missões quando você estiver no local apropiado"
WritCreater.optionStrings["new container"]					= "Mantenha o novo status"
WritCreater.optionStrings["new container tooltip"]			= "Manter o novo status para contêineres de recompensa de fabricação"
WritCreater.optionStrings["master"]							= "Ordens Mestre"
WritCreater.optionStrings["master tooltip"]					= "Se isso for ativado o addon irá fabricar as Ordens Mestre que você tem ativa"
WritCreater.optionStrings["right click to craft"]			= "Clique com o Botão Direito para Fabricar"
WritCreater.optionStrings["right click to craft tooltip"]	= "Se isso for ativado o addon irá fabricar Ordens Mestre depois que você clicar com o botão direito em uma Ordem Selada."
WritCreater.optionStrings["crafting submenu"]				= "Negociações para Artesanato"
WritCreater.optionStrings["crafting submenu tooltip"]		= "Desativar o addon para ofícios específicos"
WritCreater.optionStrings["timesavers submenu"]				= "Atalhos"
WritCreater.optionStrings["timesavers submenu tooltip"]		= "Vários pequenos atalhos"
WritCreater.optionStrings["loot container"]					= "Abrir o Recipiente quando recebido"
WritCreater.optionStrings["loot container tooltip"]			= "Abra os recipientes quando estiver com um no banco"
WritCreater.optionStrings["master writ saver"]				= "Salva Ordens Mestre"
WritCreater.optionStrings["master writ saver tooltip"]		= "Impede que Ordens Mestre seja aceito"
WritCreater.optionStrings["loot output"]					= "Alerta de recompensa valiosa"
WritCreater.optionStrings["loot output tooltip"]			= "Veja de uma mensagem quando itens valiosos são recebidos de uma encomenda"
WritCreater.optionStrings["autoloot behaviour"]				= "Comportamento Autoloot" -- Note that the following three come early in the settings menu, but becuse they were changed
WritCreater.optionStrings["autoloot behaviour tooltip"]		= "Escolher quando o addon irá abrir os Recipientes de recompensa de uma encomenda" -- they are now down below (with untranslated stuff)
WritCreater.optionStrings["autoloot behaviour choices"]		= {"Copy the setting under the Gameplay settings", "Autoloot", "Never Autoloot"}
WritCreater.optionStrings["container delay"]				= "Delay Container Looting"
WritCreater.optionStrings["container delay tooltip"]		= "Delay the autolooting of writ reward containers when you receive them"
WritCreater.optionStrings["hide when done"]					= "Hide when done"
WritCreater.optionStrings["hide when done tooltip"]			= "Hide the addon window when all items have been crafted"
WritCreater.optionStrings['reticleColour']					= "Change Reticle Colour"
WritCreater.optionStrings['reticleColourTooltip']			= "Changes the Reticle colour if you have an uncompleted or completed writ at the station"
WritCreater.optionStrings['autoCloseBank']					= "Automatic Bank Dialog"
WritCreater.optionStrings['autoCloseBankTooltip']			= "Automatically enter and exit the banking dialogue if there are items to be withdrawn"
WritCreater.optionStrings['dailyResetWarn']					= "Writ Reset Warning"
WritCreater.optionStrings['dailyResetWarnTooltip']			= "Displays a warning when writs are about to reset for the day"
WritCreater.optionStrings['dailyResetWarnTime']				= "Minutes Before Reset"
WritCreater.optionStrings['dailyResetWarnTimeTooltip']		= "How many minutes before the daily reset the warning should be displayed"
WritCreater.optionStrings['dailyResetWarnType']				= "Daily Reset Warning"
WritCreater.optionStrings['dailyResetWarnTypeTooltip']		= "What type of warning should be displayed when the daily reset is about to occur"
WritCreater.optionStrings['dailyResetWarnTypeChoices']		= { "None","Type 1", "Type 2", "Type 3", "Type 4", "All"}
WritCreater.optionStrings['stealingProtection']				= "Stealing Protection"
WritCreater.optionStrings['stealingProtectionTooltip']		= "Prevent you from stealing while near a writ turn in location"
WritCreater.optionStrings['jewelryWritDestroy']				= "Destroy Jewelry Sealed Writs"
WritCreater.optionStrings['jewelryWritDestroyTooltip']		= "Destroy looted Jewelry Sealed writs. WARNING: There is no prompt!"
WritCreater.optionStrings['jewelryWritDestroyWarning']		= "WARNING: There is no prompt when destroying jewelry writs! Enable at your own risk!"
WritCreater.optionStrings['noDELETEConfirmJewelry']			= "Easy Jewelry Destruction"
WritCreater.optionStrings['noDELETEConfirmJewelryTooltip']	= "Automatically add the DELETE text confirmation to the delete jewelry dialog box"

-- Languages/en.lua translate -- start from line 69

-----------------------------------------------------------------------------------
-- Addon Name: Dolgubon's Lazy Writ Crafter
-- Creator: Dolgubon (Joseph Heinzle)
-- Addon Ideal: Simplifies Crafting Writs as much as possible
-- Addon Creation Date: March 14, 2016
--
-- File Name: Languages/en.lua
-- File Description: Russian Localization
-- File Translator: @KiriX
-- File Creation Date: April 03, 2019
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--
-- TRANSLATION NOTES - PLEASE READ
--
-- If you are not looking to translate the addon you can ignore this. :D
--
-- If you ARE looking to translate this to something else then anything with a comment of Vital beside it is 
-- REQUIRED for the addon to function properly. These strings MUST BE TRANSLATED EXACTLY!
-- If only going for functionality, ctrl+f for Vital. Otherwise, you should just translate everything. Note that some strings
-- Note that if you are going for a full translation, you must also translate defualt.lua and paste it into your localization file.
--
-- For languages that do not use the Latin Alphabet, there is also an optional langParser() function. IF the language you are translating
-- requires some changes to the WritCreater.parser() function then write the optional langParser() function here, and the addon
-- will use that instead. Just below is a commented out langParser for English. Be sure to remove the comments if rewriting it. [[  ]]
--
-- If you run into problems, please feel free to contact me on ESOUI.
--
-----------------------------------------------------------------------------------
--
--[[
function WritCreater.langParser(str)  -- Optional overwrite function for language translations
	local seperater = "%s+"

	str = string.gsub(str,":"," ")

	local params = {}
	local i = 1
	local searchResult1, searchResult2  = string.find(str,seperater)
	if searchResult1 == 1 then
		str = string.sub(str, searchResult2+1)
		searchResult1, searchResult2  = string.find(str,seperater)
	end

	while searchResult1 do

		params[i] = string.sub(str, 1, searchResult1-1)
		str = string.sub(str, searchResult2+1)
	    searchResult1, searchResult2  = string.find(str,seperater)
	    i=i+1
	end 
	params[i] = str
	return params

end
--]]

function WritCreater.langWritNames() -- Vital
	-- Exact!!!  I know for german alchemy writ is Alchemistenschrieb - so ["G"] = schrieb, and ["A"]=Alchemisten
	local names = {
		["G"] = "Ordens",
		[CRAFTING_TYPE_ENCHANTING] 		= "Encantamento",
		[CRAFTING_TYPE_BLACKSMITHING] 	= "Ferraria",
		[CRAFTING_TYPE_CLOTHIER] 		= "Alfaiataria",
		[CRAFTING_TYPE_PROVISIONING] 	= "Culinária",
		[CRAFTING_TYPE_WOODWORKING] 	= "Marcenaria",
		[CRAFTING_TYPE_ALCHEMY] 		= "Alquimia",
		[CRAFTING_TYPE_JEWELRYCRAFTING] = "Joalheria",
	}
	return names
end

function WritCreater.langMasterWritNames()
	local names = {
		["M"]               			= "masterful",
		["M1"]               			= "mestre",
		[CRAFTING_TYPE_ALCHEMY]      	= "mistura",
		[CRAFTING_TYPE_ENCHANTING]    	= "glifo",
		[CRAFTING_TYPE_PROVISIONING]  	= "feast",
		["plate"]            			= "plate",
		["tailoring"]          			= "alfaiataria",
		["leatherwear"]          		= "leatherwear",
		["weapon"]            			= "arma",
		["shield"]            			= "escudo",
	}
return names

end

function WritCreater.writCompleteStrings() -- Vital for translation
	local strings = {
		["place"] 			= "Coloque as mercadorias",
		["sign"] 			= "Assine o Manifesto",
		["masterPlace"] 	= "Eu terminei o",
		["masterSign"] 		= "<Conclua o trabalho.>",
		["masterStart"] 	= "<Aceite o contrato.>",
		["Rolis Hlaalu"] 	= "Rolis Hlaalu", -- This is the same in most languages but ofc chinese and japanese
		["deliver"] 		= "Entregue",
	}
	return strings
end


function WritCreater.languageInfo() -- Vital

local craftInfo = 
	{
		[ CRAFTING_TYPE_CLOTHIER] = 
		{
			["pieces"] = --exact!!
			{
				 [1] = "Túnica", --robe
				 [2] = "Gibão", --jerkin
				 [3] = "Sapatos", --shoes
				 [4] = "Luvas", --gloves
				 [5] = "Chapéu", --hat
				 [6] = "Calções", --breeches
				 [7] = "Palas", --epaulet
				 [8] = "Faixa", --sash
				 [9] = "Brigantina", --jack
				[10] = "Botas", --boots
				[11] = "Braçadeiras", --bracers
				[12] = "Capacete", --helmet
				[13] = "Guardas", --guards
				[14] = "Ombreiras", --cops
				[15] = "Cinto", --belt
			},
			["match"] = --exact!!! This is not the material, but rather the prefix the material gives to equipment. e.g. Homespun Robe, Linen Robe
			{
				 [1] = "Artesana", --Homespun
				 [2] = "Linho",	--Linen
				 [3] = "Algodão", --Cotton
				 [4] = "Sedaracna", --Spidersilk
				 [5] = "Fio de Ébano", --Ebonthread
				 [6] = "Kresh",
				 [7] = "Fio Ferroso", --Ironthread
				 [8] = "Fio de Prata", --Silverweave
				 [9] = "Sombrafiada", --Shadowspun
				[10] = "Ancestor", --Seda Ancestral
				[11] = "Couro Cru", --Rawhide
				[12] = "Pele", --Hide
				[13] = "Couro", --Leather
				[14] = "Couro-Completo", --Full-Leather
				[15] = "Couro Ímpio", --Fell
				[16] = "Brigandina", --Brigandine
				[17] = "Pele de Ferro", --Ironhide
				[18] = "Pele Soberba", --Superb
				[19] = "Umbrapele", --Shadowhide
				[20] = "Couro Rubro", --Rubedo
			},
			
		},
		[CRAFTING_TYPE_BLACKSMITHING] = 
		{
			["pieces"] = --exact!!
			{
				 [1] = "Machado", --axe
				 [2] = "Maça", --mace
				 [3] = "Espada", --sword
				 [4] = "Machado de Batalha", --battle axe
				 [5] = "Malho", --maul
				 [6] = "Montante", --greatsword
				 [7] = "Adaga", --dagger
				 [8] = "Couraça", --cuirass
				 [9] = "Escarpes", --sabatons
				[10] = "Manoplas", --gauntlets
				[11] = "Elmo", --helm
				[12] = "Grevas", --greaves
				[13] = "Espaldas", --pauldron
				[14] = "Cinturão", --girdle
			},
			["match"] = --exact!!! This is not the material, but rather the prefix the material gives to equipment. e.g. Iron Axe, Steel Axe
			{
				 [1] = "Ferro", --Iron
				 [2] = "Aço", --Steel
				 [3] = "Oricalco", --Orichalcum
				 [4] = "Enânica", --Dwarven
				 [5] = "Ébano", --Ebony
				 [6] = "Calcínio", --Calcinium
				 [7] = "Galatita", --Galatite
				 [8] = "Mercúrio", --Quicksilver
				 [9] = "Aço do Vácuo", --Voidsteel
				[10] = "Rubedita", --Rubedite
			},
			
		},
		[CRAFTING_TYPE_WOODWORKING] = 
		{
			["pieces"] = --Exact!!!
			{
				[1] = "Arco", --bow
				[3] = "Infernal", --inferno
				[4] = "Gelo", --Ice
				[5] = "Raio", --lightning
				[6] = "Restauração", --restoration
				[2] = "Escudo", --shield
			},
			["match"] = --exact!!! This is not the material, but rather the prefix the material gives to equipment. e.g. Maple Bow. Oak Bow.
			{
				 [1] = "Bordo", --Maple
				 [2] = "Carvalho", --Oak
				 [3] = "Faia", --Beech
				 [4] = "Nogueira", --Hickory
				 [5] = "Teixo", --Yew
				 [6] = "Bétula", --Birch
				 [7] = "Cinzas", --Ash
				 [8] = "Mogno", --Mahogany
				 [9] = "Madeira da Noite", --Nightwood
				[10] = "Feixo Rubi", --Ruby Ash
			},
			
		},
		[CRAFTING_TYPE_JEWELRYCRAFTING] = 
		{
			["pieces"] = --Exact!!!
			{
				[1] = "anel",
				[2] = "colar",

			},
			["match"] = --exact!!! This is not the material, but rather the prefix the material gives to equipment. e.g. Maple Bow. Oak Bow.
			{
				[1] = "Peltre", -- 1 (Pewter)
				[2] = "Cobre", -- 26 (Copper)
				[3] = "Prata", -- CP10 (Silver)
				[4] = "Electrum", --CP80 (Electrum)
				[5] = "Platina", -- CP150 (Platinum)
			},

		},
		[CRAFTING_TYPE_ENCHANTING] = 
		{
			["pieces"] = --exact!!
			{ --{String Identifier, ItemId, positive or negative}
				{"Resistência ", 45841,2},
				{"Infeccioso", 45841,1},
				{"Absorver Vigor", 45833,2},
				{"Absorver Mágicka", 45832,2},
				{"Absorção de Saúde", 45831,2},
				{"Resistência ao Álgido",45839,2},
				{"Álgido",45839,1},
				{"Custo de Vigor", 45836,2},
				{"Recuperação de Vigor", 45836,1},
				{"Robustez", 45842,1},
				{"Esmagador", 45842,2},
				{"Investida", 68342,2},
				{"Defesa", 68342,1},
				{"Blindagem",45849,2},
				{"contra-ataque",45849,1},
				{"Resistência ao Venenoso",45837,2},
				{"Dano Venenoso",45837,1},
				{"Dano Mágico",45848,2},
				{"mágica",45848,1},
				{"Recuperação de Mágicka", 45835,1},
				{"Custo de Feitiços", 45835,2},
				{"Resistência ao Elétrico",45840,2},
				{"Dano Elétrico",45840,1},
				{"Recuperação de Saúde",45834,1},
				{"Redução de Saúde",45834,2},
				{"Enfraquecer",45843,2},
				{"Arma",45843,1},
				{"Alquimista",45846,1},
				{"Aceleração",45846,2},
				{"Resistência ao Ígneo",45838,2},
				{"Dano Ígneo",45838,1},
				{"Redução de Dano Físico", 45847,2},
				{"Aumento de Dano Físico", 45847,1},
				{"Vigor",45833,1},
				{"Saúde",45831,1},
				{"Mágicka",45832,1}
			},
			["match"] = --exact!!! The names of glyphs. The prefix (in English) So trifling glyph of magicka, for example
			{
				 [1] = {"insignificante", 45855},
				 [2] = {"rudimentar",45856}, -- inferior?
				 [3] = {"pequeno",45857},
				 [4] = {"leve",45806},
				 [5] = {"menor",45807},
				 [6] = {"reduzido",45808}, -- baixo?
				 [7] = {"moderado",45809},
				 [8] = {"médio",45810},
				 [9] = {"forte",45811},
				[10] = {"maior",45812},
				[11] = {"maioral",45813},
				[12] = {"grandioso",45814},
				[13] = {"esplêndido",45815},
				[14] = {"monumental",45816},
				[15] = {"verdadeiramente",{68341,68340,},},
				[16] = {"glorioso",{64509,64508,},},
				
			},
			["quality"] = -- !!!ДЛЯ РУН!!!
			{
				{"normal",45850},
				{"Fino",45851},
				{"Superior",45852},
				{"Épico",45853},
				{"Lendário",45854},
				{"", 45850} -- default, if nothing is mentioned. Default should be Ta.
			}
		},
	}

	return craftInfo

end

function WritCreater.masterWritQuality() -- Vital . This is probably not necessary, but it stays for now because it works
	return {{"Épico",4},{"Lendário",5}} -- !!!ДЛЯ КРАФТА ЭКИПИРОВКИ!!!
end




function WritCreater.langEssenceNames() -- Vital

local essenceNames =  
	{
		[1] = "Oko", --health
		[2] = "Deni", --stamina
		[3] = "Makko", --magicka
	}
	return essenceNames
end

function WritCreater.langPotencyNames() -- Vital
	--exact!! Also, these are all the positive runestones - no negatives needed.
	local potencyNames = 
	{
		 [1] = "Jora", --Lowest potency stone lvl
		 [2] = "Porade",
		 [3] = "Jera",
		 [4] = "Jejora",
		 [5] = "Odra",
		 [6] = "Pojora",
		 [7] = "Edora",
		 [8] = "Jaera",
		 [9] = "Pora",
		[10] = "Denara",
		[11] = "Rera",
		[12] = "Derado",
		[13] = "Rekura",
		[14] = "Kura",
		[15] = "Rejera",
		[16] = "Repora", --v16 potency stone
	}
	return potencyNames
end

local enExceptions = -- This is a slight misnomer. Not all are corrections - some are changes into english so that future functions will work
{
	["original"] =
	{
		[1] = "добыть",
		[2] = "Entregue",

	},
	["corrected"] = 
	{	
		[1] = "acquire",
		[2] = "Entregue",

	},
}

local exceptions = 
{
	[1] = 
	{
		["original"] = "rubedo leather",
		["corrected"] = "rubedo",
	},
	[2] = 
	{
		["original"] = "ancestor silk",
		["corrected"] = "ancestor",
	},
	[3] = 
	{
		["original"] = "ebony",
		["corrected"] = "ebon",
	},
	[4] = 
	{
		["original"] = "orichalcum",
		["corrected"] = "orichalc",
	},
	[5] = 
	{
		["original"] = "ruby ash",
		["corrected"] = "ruby",
	},
	[6] = 
	{
		["original"] = "dwarven pauldrons",
		["corrected"] = "dwarven pauldron",
	},
	[7] = 
	{
		["original"] = "epaulets",
		["corrected"] = "epaulet",
	},
	[8] = {
		["original"] = "aneis",
		["corrected"] = "anel",
	},
	[9] = {
		["original"] = "colares",
		["corrected"] = "colar",
	},
	[10] = {
		["original"] = "добыть",
		["corrected"] = "acquire",
	},
	[11] = {
		["original"] = "Entregue",
		["corrected"] = "Entregue",
	},
}


function WritCreater.exceptions(condition)
	condition = string.gsub(condition, " "," ")
	condition = string.lower(condition)

	for i = 1, #exceptions do

		if string.find(condition, exceptions[i]["original"]) then
			condition = string.gsub(condition, exceptions[i]["original"],exceptions[i]["corrected"])
		end
	end
	return condition
end

function WritCreater.questExceptions(condition)
	condition = string.gsub(condition, " "," ")
	return condition
end

function WritCreater.enchantExceptions(condition)
	condition = string.gsub(condition, " "," ")
	condition = string.lower(condition)
	for i = 1, #enExceptions["original"] do
		condition = string.gsub(condition,enExceptions["original"][i],enExceptions["corrected"][i])
	
	end
	return condition
end


function WritCreater.langTutorial(i)
	local t = {
		[5]="Há também algumas coisas que você deveria saber.\nPrimeiro, /dailyreset é um comando do chat vai dizer\nquanto tempo falta até a próxima reinicialização diária do servidor.",
		[4]="Finalmente, você também pode optar por desativar ou\native este addon para cada profissão.\nPor padrão, todas as profissões estão ativadas.\nSe você deseja desativar alguns, por favor, verifique as configurações.",
		[3]="Em seguida, você precisa escolher se deseja ver essa\njanela ao usar uma estação de criação.\nA janela mostrará quantos materiais o contrato precisa, bem como quantos você tem atualmente.",
		[2]="A primeira configuração a escolher é se você\nquer usar o AutoCraft.\nAo ativado, quando você entra em uma estação de criação, o addon vai começar a criar.",
		[1]="Bem-vindo ao Dolgubon's Lazy Writ Crafter!\nHá algumas configurações que você deve fazer primeiro.\n Você pode alterar as configurações a qualquer\nmomento no menu de configurações.",
	}
	return t[i]
end

function WritCreater.langTutorialButton(i,onOrOff) -- sentimental and short please. These must fit on a small button
	local tOn = 
	{
		[1]="Usar o Padrão",
		[2]="Ativado",
		[3]="Mostrar",
		[4]="Continuar",
		[5]="Finalizar",
	}
	local tOff=
	{
		[1]="Continuar",
		[2]="Desativado",
		[3]="Não mostrar",
	}
	if onOrOff then
		return tOn[i]
	else
		return tOff[i]
	end
end

function WritCreater.langStationNames()
	return {
		["Estação de Ferraria"] = 1, 
		["Estação de Alfaiataria"] = 2,
		["Mesa de Encantamento"] = 3,
		["Estação de Alquimia"] = 4, 
		["Fogueira"] = 5, 
		["Estação de Marcenaria"] = 6, 
		["Estação de Joalheria"] = 7, 
	}
end

-- O que é isso??! Este é apenas um divertido 'easter egg'.
-- Substitui os nomes dos materiais aleatoriamente pelos DivineMats no Dia das Bruxas, Ano Novo e Dia da Mentira.
-- se não for usar faça a função
-- shouldDivinityprotocolbeactivatednowornotitshouldbeallthetimebutwhateveritlljustbeforabit()
-- retornar false;
local DivineMats = {
	{"Ghost Eyes", "Vampire Hearts", "Werewolf Claws", "'Special' Candy", "Chopped Hands", "Zombie Guts", "Bat Livers", "Lizard Brains", "Witches Hats", "Distilled Boos", "Singing Toads"}, --Dia das Bruxas
	{"Sock Puppets", "Jester Hats","Otter Noses",  "|cFFC300Tempering Alloys|r", "Red Herrings", "Rotten Tomatoes","Fake Oil of Life", "Crowned Imposters", "Mudpies"}, --Dia da Mentira
	{"Fireworks", "Presents", "Crackers", "Reindeer Bells", "Elven Hats", "Pine Needles", "Essences of Time", "Ephemeral Lights"}, --Ano Novo
}

local function shouldDivinityprotocolbeactivatednowornotitshouldbeallthetimebutwhateveritlljustbeforabit()
	if GetDate()%10000 == 1031 then return 1 end
	if GetDate()%10000 == 401 then return 2 end
	if GetDate()%10000 == 1231 then return 3 end
	return false
end

local function wellWeShouldUseADivineMatButWeHaveNoClueWhichOneItIsSoWeNeedToAskTheGodsWhichDivineMatShouldBeUsed() 
	local a = math.random(1, #DivineMats ) 
	return DivineMats[a] 
end

local l = shouldDivinityprotocolbeactivatednowornotitshouldbeallthetimebutwhateveritlljustbeforabit()

if l then
	DivineMats = DivineMats[l]
	local DivineMat = wellWeShouldUseADivineMatButWeHaveNoClueWhichOneItIsSoWeNeedToAskTheGodsWhichDivineMatShouldBeUsed()
	
	WritCreater.strings.smithingReqM = function (amount, _,more) return zo_strformat( "Создание потребует <<4>>: <<1>> шт. (|cf60000Вам необходимо ещё - <<3>> шт.|r)" ,amount, type, more, DivineMat) end
	WritCreater.strings.smithingReqM2 = function (amount, _,more) return zo_strformat( "Также потребуется <<4>>: <<1>> шт. (|cf60000Вам необходимо ещё - <<3>> шт.|r)" ,amount, type, more, DivineMat) end
	WritCreater.strings.smithingReq = function (amount, _,more) return zo_strformat( "Создание потребует <<4>>: <<1>> шт. (|cf60000Вам необходимо ещё - <<3>> шт.|r)" ,amount, type, more, DivineMat) end
	WritCreater.strings.smithingReq2 = function (amount, _,more) return zo_strformat( "Также потребуется <<4>>: <<1>> шт. (|cf60000Вам необходимо ещё - <<3>> шт.|r)" ,amount, type, more, DivineMat) end
end


-- [[ /script local writcreater = {} local c = {a = 1} local g = {__index = c} setmetatable(writ, g) d(a.a) local e = {__index = {Z = 2}} setmetatable(c, e) d(a.Z)
local h = {__index = {}}
local t = {}
local g = {["__index"] = t}
setmetatable(t, h)
setmetatable(WritCreater, g) --]]

local function enableAlternateUniverse(override)

	if shouldDivinityprotocolbeactivatednowornotitshouldbeallthetimebutwhateveritlljustbeforabit() == 2 or override then
	--if true then
		local stations =
			{"Blacksmithing Station", "Clothing Station", "Enchanting Table",
			"Alchemy Station",  "Cooking Fire", "Woodworking Station","Jewelry Crafting Station",  "Outfit Station", "Transmute Station", "Wayshrine"}
			local stationNames =  -- in the comments are other names that were also considered, though not all were considered seriously
			{"Тяжелый металл", -- Popcorn Machine , Skyforge, Heavy Metal Station, Metal Clockwork Solid, Wightsmithing Station., Coyote Stopper
			"Чулочная фабрика", -- Sock Distribution Center, Soul-Shriven Sock Station, Grandma's Sock Knitting Station, Knits and Pieces, Sock Knitting Station
			"Дело в шляпе", -- Mahjong Station, Magic Store, Card Finder, Five Aces, Top Hat Store
			"Старый скуума-бар", -- Chemical Laboratory , Drugstore, White's Garage, Cocktail Bar, Med-Tek Pharmaceutical Company, Med-Tek Laboratories, Skooma Central, Skooma Backdoor Dealers, Sheogorath's Pharmacy
			"Каджитская курочка во фритюре", -- Khajit Fried Chicken, soup Kitchen, Some kind of bar, misspelling?, Roast Bosmer
			"Станция сборки IKEA", -- Chainsaw Massace, Saw Station, Shield Corp, IKEA Assembly Station, Wood Splinter Removal Station
			"Золото дураков",--"Diamond Scam Store", -- Lucy in the Sky, Wedding Planning Hub, Shiny Maker, Oooh Shiny, Shiny Bling Maker, Cubit Zirconia, Rhinestone Palace
			-- April Fool's Gold
			"Каджитские торговые меха", -- Jester Dressing Room Loincloth Shop, Khajit Walk, Khajit Fashion Show, Mummy Maker, Thalmor Spy Agency, Tamriel Catwalk, 
			--	Tamriel Khajitwalk, second hand warehouse,. Dye for Me, Catfur Jackets, Outfit station "Khajiit Furriers", Khajit Fur Trading Outpost
			"Алтарь заклания козла",-- Heisenberg's Station Correction Facility, Time Machine, Probability Redistributor, Slot Machine Rigger, RNG Countermeasure, Lootcifer Shrine, Whack-a-mole
			-- Anti Salt Machine, Department of Corrections, Quantum State Rigger , Unnerf Station
			"ТАРДИС" } -- Transporter, Molecular Discombobulator, Beamer, Warp Tunnel, Portal, Stargate, Cannon!, Warp Gate
			
			local crafts = {"Кузнечное дело", "Портняжное дело", "Зачарование","Алхимия","Снабжение","Столярное дело","Ювелирное дело" }
			local craftNames = {
				"Тяжёлый металл",
				"Кройка и шитьё",
				"Дело в шляпе",
				"Скуумодел",
				"Курочка во фритюре",
				"IKEA",
				"Золото дураков",
			}
			local quest = {"кузнец", "портно", "зачаров" ,"алхимик", "снабжен", "столяр", "ювелир"}
			local questNames = 	
			{
				"Wightsmith",
				"Sock Knitter",
				"Top Hat Trickster",
				"Skooma Brewer",
				"Chicken Fryer",
				"IKEA Assembly",
				"Золото дураков",
			}
			local items = {"кузне", "портно", "зачаров", "алхими", "еда и напитки",  "столяр", "ювелир"}
			local itemNames = {
				"Wight",
				"Sock Puppet",
				"Top Hat",
				"Skooma",
				"Fried Chicken",
				"IKEA",
				"Золото дураков",
			}
			local coffers = {"кузнеца", "портного", "зачарователя" ,"алхимика", "снабженца", "столяра", "ювелира",}
			local cofferNames = {
				"Wightsmith",
				"Sock Knitter",
				"Top Hat Trickster",
				"Skooma Brewer",
				"Chicken Fryer",
				"IKEA Assembly",
				"Золото дураков",
			}
			local ones = {"Ювелир"}
			local oneNames = {"Золото дураков"}


		local t = {["__index"] = {}}
		function h.__index.alternateUniverse()
			return stations, stationNames
		end
		function h.__index.alternateUniverseCrafts()
			return crafts, craftNames
		end
		function h.__index.alternateUniverseQuests()
			return quest, questNames
		end
		function h.__index.alternateUniverseItems()
			return items, itemNames
		end
		function h.__index.alternateUniverseCoffers()
			return coffers, cofferNames
		end
		function h.__index.alternateUniverseOnes()
			return ones, oneNames
		end

 
		h.__metatable = "No looky!"
		local a = WritCreater.langStationNames()
		a[1] = 1
		for i = 1, 7 do
			a[stationNames[i]] = i
		end
		WritCreater.langStationNames = function() 
			return a
		end
		local b =WritCreater.langWritNames()
		for i = 1, 7 do
			b[i] = questNames[i]
		end
		-- WritCreater.langWritNames = function() return b end

	end
end

-- For Transmutation: "Well Fitted Forever"
-- So far, I like blacksmithing, clothing, woodworking, and wayshrine, enchanting
-- that leaves , alchemy, cooking, jewelry, outfits, and transmutation

local lastYearStations = 
{"Кузница", "Портняжный станок", "Столярный верстак", "Огонь для приготовления пищи", 
"Стол для зачарования", "Алхимическая станция", "Станция создания нарядов", "Станция трансмутации", "Дорожное святилище"}
local stationNames =  -- in the comments are other names that were also considered, though not all were considered seriously
{"Тяжёлый металл 112.3 FM", -- Popcorn Machine , Skyforge, Heavy Metal Station
 "Кукольный театр", -- Sock Distribution Center, Soul-Shriven Sock Station, Grandma's Sock Knitting Station, Knits and Pieces
 "Стружки и опилки", -- Chainsaw Massace, Saw Station, Shield Corp, IKEA Assembly Station, Wood Splinter Removal Station
 "МакШеогорат", 
 "Тетрис", -- Mahjong Station
 "Центр контроля заражений", -- Chemical Laboratory , Drugstore, White's Garage, Cocktail Bar, Med-Tek Pharmaceutical Company, Med-Tek Laboratories
 "Уголок талморского шпиона", -- Jester Dressing Room Loincloth Shop, Khajit Walk, Khajit Fashion Show, Mummy Maker, Thalmor Spy Agency, Morag Tong Information Hub, Tamriel Spy HQ, 
 "Отдел коррекции",-- Heisenberg's Station Correction Facility, Time Machine, Probability Redistributor, Slot Machine Rigger, RNG Countermeasure, Lootcifer Shrine, Whack-a-mole
 -- Anti Salt Machine, Department of Corrections
 "Варп-врата" } -- Transporter, Molecular Discombobulator, Beamer, Warp Tunnel, Portal, Stargate, Cannon!, Warp Gate

-- enableAlternateUniverse(GetDisplayName()=="@RODRIGO5")
enableAlternateUniverse()

local function alternateListener(eventCode,  channelType, fromName, text, isCustomerService, fromDisplayName)
	-- if GetDisplayName() == "@Dolgubon" then
	-- 	d(WritCreater.alternateUniverse)
	-- 	return
	-- end
	if not WritCreater.alternateUniverse and fromDisplayName == "@Dolgubon" and text == "Пусть Острова истекут на Нирн!" then	
		enableAlternateUniverse(true)	
		WritCreater.WipeThatFrownOffYourFace(true)	
	end	
end	


 EVENT_MANAGER:RegisterForEvent(WritCreater.name,EVENT_CHAT_MESSAGE_CHANNEL, alternateListener)

--Hide craft window when done
--"Verstecke Fenster anschließend",
-- [tooltip ] = "Verstecke das Writ Crafter Fenster an der Handwerksstation automatisch, nachdem die Gegenstände hergestellt wurden"

function WritCreater.langWritRewardBoxes () return {
	[CRAFTING_TYPE_ALCHEMY] = "Recipiente de Alquimista",
	[CRAFTING_TYPE_ENCHANTING] = "Cofre do Encantador",
	[CRAFTING_TYPE_PROVISIONING] = "Pacote de Culinária",
	[CRAFTING_TYPE_BLACKSMITHING] = "Caixa de Ferreiro",
	[CRAFTING_TYPE_CLOTHIER] = "Sacola de Alfaiate",
	[CRAFTING_TYPE_WOODWORKING] = "Estojo de Marceneiro",
	[CRAFTING_TYPE_JEWELRYCRAFTING] = "Cofre de Joalheria",
	[8] = "Carregamento",
}
end


function WritCreater.getTaString()
	return "та"
end

WritCreater.optionStrings["alternate universe"]				= "Отключить 1-апрельские шутки"
WritCreater.optionStrings["alternate universe tooltip"] 	= "Отключает переименовывание ремесленных станций, ремесла и прочих интерактивных предметов"

WritCreater.lang = "br"
WritCreater.langIsMasterWritSupported = false

--[[
SLASH_COMMANDS['/opencontainers'] = function()local a=WritCreater.langWritRewardBoxes() for i=1,200 do for j=1,6 do if a[j]==GetItemName(1,i) then if IsProtectedFunction("endUseItem") then
	CallSecureProtected("endUseItem",1,i)
else
	UseItem(1,i)
end end end end end]]