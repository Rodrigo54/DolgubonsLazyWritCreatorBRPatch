-----------------------------------------------------------------------------------
-- Addon Name: Dolgubon's Lazy Writ Crafter
-- Creator: Dolgubon (Joseph Heinzle)
-- Addon Ideal: Simplifies Crafting Writs as much as possible
-- Addon Creation Date: March 14, 2016
--
-- File Name: Languages/default.lua
-- File Description: Russian Localization
-- File translator: @KiriX
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
		missing[#missing + 1] = "|rТа|cf60000"
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
			text = "|cf60000Глиф не может быть создан. У вас нет ни одной руны "..proper(missing[i])
		else
			text = text.." или "..proper(missing[i])
		end
	end
	return text
end


local function dailyResetFunction(till, stamp) 	-- You can translate the following simple version instead.
												-- function (till) d(zo_strformat("<<1>> hours and <<2>> minutes until the daily reset.",till["hour"],till["minute"])) end,
	if till["hour"]==0 then
		if till["minute"]==1 then
			return "1 минута до сброса ежедневных заданий!"
		elseif till["minute"]==0 then
			if stamp==1 then
				return "Ежедневные заданий сбросятся через "..stamp.." секунд!"
			else
				return "Серьёзно... Хватит спрашивать. Ты настолько нетерпелив??? Они сбросятся через пару секунд, проклятье. Тупые, так называемые ММОшники. *бур-бур-бур*"
			end
		else
			return till["minute"].." минут до сброса ежедневных заданий!"
		end
	elseif till["hour"]==1 then
		if till["minute"]==1 then
			return till["hour"].." час и "..till["minute"].." минута до сброса ежедневных заданий"
		else
			return till["hour"].." час и "..till["minute"].." минут до сброса ежедневных заданий"
		end
	else
		if till["minute"]==1 then
			return till["hour"].." часов и "..till["minute"].." минута до сброса ежедневных заданий"
		else
			return till["hour"].." часов и "..till["minute"].." минут до сброса ежедневных заданий"
		end
	end 
end

local function masterWritEnchantToCraft (pat,set,trait,style,qual,mat,writName,Mname,generalName)
	local partialString = zo_strformat("Создать предмет \"<<t:6>> <<t:1>>\" уровня оч 150, комплекта \"<<t:2>>\" с особенностью \"<<t:3>>\" и в стиле \"<<t:4>>\" с качеством \"<<t:5>>\"",pat,set,trait,style,qual,mat)
	return zo_strformat("<<t:2>> <<t:3>> <<t:4>>: <<1>>",partialString,writName,Mname,generalName )
end


WritCreater.strings =
{
	["runeReq"] 					= function (essence, potency) return zo_strformat("|c2dff00Создание потребует 1 |rТа|c2dff00, 1 |cffcc66<<1>>|c2dff00 и 1 |c0066ff<<2>>|r", essence, potency) end,
	["runeMissing"] 				= runeMissingFunction,
	["notEnoughSkill"]				= "У вас недостаточно высокий уровень навыка, чтобы создать требуемую экипировку",
	["smithingMissing"] 			= "\n|cf60000У вас недостаточно материалов|r",
	["craftAnyway"] 				= "Создать что можно",
	["smithingEnough"] 				= "\n|c2dff00У вас достаточно материалов|r",
	["craft"] 						= "|c00ff00Создать|r",
	["crafting"] 					= "|c00ff00Создание...|r",
	["craftIncomplete"] 			= "|cf60000Создание не может быть завершено.\nВам нужно больше материалов.|r",
	["moreStyle"] 					= "|cf60000У вас нет ни одного стилевого материала\nдля выбранного стиля|r",
	["moreStyleSettings"]			= "|cf60000У вас нет ни одного доступного стилевого материала.\nВозможно, вам нужно разрешить использовать больше стилей в меню настроек|r",
	["moreStyleKnowledge"]			= "|cf60000У вас нет ни одного доступного стилевого материала.\nВозможно, вам нужно изучить больше ремесленных стилей|r",
	["dailyreset"] 					= dailyResetFunction,
	["complete"] 					= "|c00FF00Заказ выполнен.|r",
	["craftingstopped"]				= "Создание остановлено. Пожалуйста, проверьте, что аддон создал правильные предметы.",
	["smithingReqM"] 				= function (amount, type, more) return zo_strformat( "Создание потребует <<1>> <<2>> (|cf60000Вам необходимо ещё <<3>>|r)" ,amount, type, more) end,
	["smithingReq"] 				= function (amount,type, current) return zo_strformat( "Создание потребует <<1>> <<2>> (|c2dff00<<3>> уже имеется|r)"  ,amount, type, current) end,
	["lootReceived"]				= "Был получен предмет <<1>> (Теперь у вас их <<2>>)",
	["lootReceivedM"]				= "Был получен предмет <<1>>",
	["countSurveys"]				= "Исследований в наличии: <<1>>",
	["countVouchers"]				= "Имеется неполученных ваучеров заказов: <<1>>",
	["includesStorage"] 			= function(type) local a= {"Surveys", "Master Writs"} a = a[type] return zo_strformat("Подсчёт включает <<1>> в домашнем хранилище", a) end,
	["surveys"]						= "Исследования",
	["sealedWrits"]					= "Запечатанные заказы",
	["masterWritEnchantToCraft"]	= function(lvl, type, quality, writCraft, writName, generalName) 
										return zo_strformat("<<t:4>> <<t:5>> <<t:6>>: Создать <<t:1>> Glyph of <<t:2>> с качеством \"<<t:3>>\"",lvl, type, quality,
											writCraft,writName, generalName) end,
	["masterWritSmithToCraft"]		= masterWritEnchantToCraft,
	["withdrawItem"]				= function(amount, link, remaining) return "Аддон Dolgubon's Lazy Writ Crafter забрал из банка предмет \""..link.."\" в количестве: "..amount..". (В банке осталось: "..remaining..")" end,
	['fullBag']						= "У вас нет свободного места в инвентаре. Пожалуйста, освободите свою сумку.",
	['masterWritSave']				= "Аддон Dolgubon's Lazy Writ Crafter уберёг вас от случайного принятия мастерского заказа! Идите в настройки, чтобы отключить эту функцию.",
	['missingLibraries']			= "Аддону Dolgubon's Lazy Writ Crafter требуются следующие отдельно установленные библиотеки. Пожалуйста, скачайте, установите или включите следующие библиотеки: ",
	['resetWarningMessageText']		= "Сброс ежедневных ремесленных заданий произойдёт через <<1>> часов и <<2>> минут\nВы можете настроить или выключить это предупреждение в настройках",
	['resetWarningExampleText']		= "Предупреждение будет выглядеть так",

}


WritCreater.optionStrings = WritCreater.optionStrings or {}
WritCreater.optionStrings["nowEditing"]						= "Вы изменяете настройку %s"
WritCreater.optionStrings["accountWide"]					= "На аккаунт"
WritCreater.optionStrings["characterSpecific"]				= "Для персонажа"
WritCreater.optionStrings["useCharacterSettings"]			= "Использовать настройки для персонажа"
WritCreater.optionStrings["useCharacterSettingsTooltip"]	= "Будут использоваться уникальные настройки для конкретного персонажа вместо единых настроек на весь аккаунт."
WritCreater.optionStrings["style tooltip"]                  			= function (styleName) return zo_strformat("Разрешить использовать стиль <<1>> для создания предметов",styleName) end 
WritCreater.optionStrings["show craft window"]              			= "Показать окно аддона"
WritCreater.optionStrings["show craft window tooltip"]    				= "Показывает окно аддона при использовании ремесленных станков"
WritCreater.optionStrings["autocraft"]                      			= "Автосоздание"
WritCreater.optionStrings["autocraft tooltip"]              			= "Включение этой настройки активизирует автоматическое создание аддоном необходимых для выполнения заказа предметов при использовании ремесленного станка. Если окно аддона выключено, эта настройка будет включена."
WritCreater.optionStrings["blackmithing"]                   			= "Кузнечное дело"
WritCreater.optionStrings["blacksmithing tooltip"]          			= "Включает аддон для Кузнечного дела"
WritCreater.optionStrings["clothing"]                       			= "Портняжное дело"
WritCreater.optionStrings["clothing tooltip"]               			= "Включает аддон для Портняжного дела"
WritCreater.optionStrings["enchanting"]                     			= "Зачарование"
WritCreater.optionStrings["enchanting tooltip"]             			= "Включает аддон для Зачарования"
WritCreater.optionStrings["alchemy"]                        			= "Алхимия"
WritCreater.optionStrings["alchemy tooltip"]   	            			= "Включает аддон для Алхимии"
WritCreater.optionStrings["provisioning"]                   			= "Снабжение"
WritCreater.optionStrings["provisioning tooltip"]           			= "Включает аддон для Снабжения"
WritCreater.optionStrings["woodworking"]                    			= "Столярное дело"
WritCreater.optionStrings["woodworking tooltip"]            			= "Включает аддон для Столярного дела"
WritCreater.optionStrings["jewelry crafting"]							= "Ювелирное дело"
WritCreater.optionStrings["jewelry crafting tooltip"]					= "Включает аддон для Ювелирного дела"
WritCreater.optionStrings["writ grabbing"]                  			= "Забирать предметы для заказов"
WritCreater.optionStrings["writ grabbing tooltip"]          			= "Забирает предметы, необходимые для выполнения заказов (напр. Корень нирна, Та и т.д. и т.п.), из банка"
WritCreater.optionStrings["delay"]                          			= "Задержка снятия"
WritCreater.optionStrings["delay tooltip"]                  			= "Устанавливает задержку, с которой предметы будут сниматься из банка (миллисекунды)"
WritCreater.optionStrings["style stone menu"]               			= "Стилевой материал"
WritCreater.optionStrings["style stone menu tooltip"]       			= "Выберите, какой стилевой материал использовать"
WritCreater.optionStrings["send data"]                      			= "Отправить данные о награде"
WritCreater.optionStrings["send data tooltip"]              			= "Отправляет данные о награде, полученной из контейнеров за выполнение заказа. Никакая другая информация не будет отправлена."
WritCreater.optionStrings["exit when done"]								= "Выход из окна крафта"
WritCreater.optionStrings["exit when done tooltip"]						= "Закрывает окно крафта, когда будут сделаны все необходимые предметы"
WritCreater.optionStrings["automatic complete"]							= "Авто-квестинг"
WritCreater.optionStrings["automatic complete tooltip"]					= "Автоматически принимает и завершает задания, когда имеется всё необходимое"
WritCreater.optionStrings["new container"]								= "Сохранить статус нового"
WritCreater.optionStrings["new container tooltip"]						= "Сохраняет статус нового для контейнеров в награду за ремесленные заказы"
WritCreater.optionStrings["master"]										= "Мастерские заказы"
WritCreater.optionStrings["master tooltip"]								= "Включает модификацию для Мастерских заказов"
WritCreater.optionStrings["right click to craft"]						= "ПКМ, чтобы создать"
WritCreater.optionStrings["right click to craft tooltip"]				= "Если настройка ВКЛЮЧЕНА аддон будет создавать мастерский заказ, который вы ему укажите правым щелчком мыши на запечатанном заказе"
WritCreater.optionStrings["crafting submenu"]							= "Различные ремесла"
WritCreater.optionStrings["crafting submenu tooltip"]					= "Включает аддон для отдельных видов ремесла"
WritCreater.optionStrings["timesavers submenu"]							= "Экономия времени"
WritCreater.optionStrings["timesavers submenu tooltip"]					= "Различные возможности небольшой экономии времени"
WritCreater.optionStrings["loot container"]								= "Открыть контейнер при получении"
WritCreater.optionStrings["loot container tooltip"]						= "Автоматически открывает контейнеры в награду за ремесленные заказы при получении"
WritCreater.optionStrings["master writ saver"]							= "Сохранять мастерские заказы"
WritCreater.optionStrings["master writ saver tooltip"]					= "Предотвращает принятие Мастерских заказов"
WritCreater.optionStrings["loot output"]								= "Предупреждение о ценной награде"
WritCreater.optionStrings["loot output tooltip"]						= "Предупреждает о получении ценного предмета за заказ"
WritCreater.optionStrings["autoloot behaviour"]							= "Автолут"
WritCreater.optionStrings["autoloot behaviour tooltip"]					= "Выберите, должен ли аддон автоматически забирать награду из контейнеров"
WritCreater.optionStrings["autoloot behaviour choices"]					= {"Копировать настройку из настроек игры", "Включен", "Выключен"}
WritCreater.optionStrings["container delay"]							= "Задержка автолута"
WritCreater.optionStrings["container delay tooltip"]					= "Задержка для автоматического сбора награды из контейнеров после их получения"
WritCreater.optionStrings["hide when done"]								= "Скрыть по завершению"
WritCreater.optionStrings["hide when done tooltip"]						= "Скрывает окно аддона, когда все предметы будут изготовлены"
WritCreater.optionStrings['reticleColour'] 								= "Цвет прицела"
WritCreater.optionStrings['reticleColourTooltip'] 						= "Меняет цвет прицела при наведении на станцию, если для данного ремесла имеется невыполненный или выполненный ремесленный заказ"
WritCreater.optionStrings['autoCloseBank']								= "Авто-банкинг"
WritCreater.optionStrings['autoCloseBankTooltip']						= "Автоматические входит в диалог банка и выходит из него, если из банка требуется забрать предметы"
WritCreater.optionStrings['dailyResetWarn']								= "Предупреждение о сбросе"
WritCreater.optionStrings['dailyResetWarnTooltip']						= "Выводит предупреждение о приближении времени сброса ремесленных ежедневных заданий"
WritCreater.optionStrings['dailyResetWarnTime']							= "Минут до сброса"
WritCreater.optionStrings['dailyResetWarnTimeTooltip']					= "За сколько минут до сброса ежедневных ремесленных заданий должно выводиться предупреждение"
WritCreater.optionStrings['dailyResetWarnType']							= "Вид предупреждения"
WritCreater.optionStrings['dailyResetWarnTypeTooltip']					= "Какой вид предупреждения должен быть показан перед сбросом"
WritCreater.optionStrings['dailyResetWarnTypeChoices']					={ "Нет","Вид 1", "Вид 2", "Вид 3", "Вид 4", "Все"}


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
		["G"] = "Encomenda",
		[CRAFTING_TYPE_ENCHANTING] 		= "Encantamento",
		[CRAFTING_TYPE_BLACKSMITHING] 	= "Ferreiro",
		[CRAFTING_TYPE_CLOTHIER] 		= "Tecidos",
		[CRAFTING_TYPE_PROVISIONING] 	= "Provedor",
		[CRAFTING_TYPE_WOODWORKING] 	= "Marceneiro",
		[CRAFTING_TYPE_ALCHEMY] 		= "Alquimista",
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
		["sign"] 			= "Sign the Manifest",
		["masterPlace"] 	= "I've finished the",
		["masterSign"] 		= "<Finish the job.>",
		["masterStart"] 	= "<Aceite o contrato.>",
		["Rolis Hlaalu"] 	= "Rolis Hlaalu", -- This is the same in most languages but ofc chinese and japanese
		["Deliver"] 		= "Entregue",
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
				[2] = {"inferior",45856}, -- inferior?
				[3] = {"pequeno",45857},
				[4] = {"leve",45806},
				[5] = {"menor",45807},
				[6] = {"inferior",45808}, -- baixo?
				[7] = {"moderado",45809},
				[8] = {"médio",45810},
				[9] = {"forte",45811},
				[10]= {"maior",45812},
				[11]= {"maioral",45813},
				[12]= {"grandioso",45814},
				[13]= {"esplêndido",45815},
				[14]= {"monumental",45816},
				[15]= {"Verdadeiramente",{68341,68340,},},
				[16]= {"Esplêndido",{64509,64508,},},
				
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
		[10]= "Denara",
		[11]= "Rera",
		[12]= "Derado",
		[13]= "Rekura",
		[14]= "Kura",
		[15]= "Rejera",
		[16]= "Repora", --v16 potency stone
	}
	return potencyNames
end

local enExceptions = -- This is a slight misnomer. Not all are corrections - some are changes into english so that future functions will work
{
	["original"] =
	{
		[1] = "добыть",
		[2] = "доставить",

	},
	["corrected"] = 
	{	
		[1] = "acquire",
		[2] = "deliver",

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
		["original"] = "доставить",
		["corrected"] = "deliver",
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
		[4]="Continue",
		[5]="Finalizar",
	}
	local tOff=
	{
		[1]="Continue",
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

-- What is this??! This is just a fun 'easter egg' that is never activated on easter.
-- Replaces mat names with a random DivineMats on Halloween, New Year's, and April Fools day. You don't need this many! :D
-- Translate it or don't, completely up to you. But if you don't translate it, replace the body of 
-- shouldDivinityprotocolbeactivatednowornotitshouldbeallthetimebutwhateveritlljustbeforabit()
-- with just a return false. (This will prevent it from ever activating. Also, if you're a user and don't like this,
-- you're boring, and also that's how you can disable it. )
local DivineMats =
{
	{"Ghost Eyes", "Vampire Hearts", "Werewolf Claws", "'Special' Candy", "Chopped Hands", "Zombie Guts", "Bat Livers", "Lizard Brains", "Witches Hats", "Distilled Boos", "Singing Toads"},
	{"Sock Puppets", "Jester Hats","Otter Noses",  "|cFFC300Tempering Alloys|r", "Red Herrings", "Rotten Tomatoes","Fake Oil of Life", "Crowned Imposters", "Mudpies"},
	{"Fireworks", "Presents", "Crackers", "Reindeer Bells", "Elven Hats", "Pine Needles", "Essences of Time", "Ephemeral Lights"},
}

-- confetti?
-- random sounds?
-- 

local function shouldDivinityprotocolbeactivatednowornotitshouldbeallthetimebutwhateveritlljustbeforabit()
	if GetDate()%10000 == 1031 then return 1 end
	if GetDate()%10000 == 401 then return 2 end
	if GetDate()%10000 == 1231 then return 3 end
	return false
end

local function wellWeShouldUseADivineMatButWeHaveNoClueWhichOneItIsSoWeNeedToAskTheGodsWhichDivineMatShouldBeUsed() local a= math.random(1, #DivineMats ) return DivineMats[a] end
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
			{"Кузница", "Портняжный станок", "Стол для зачарования", 
			"Алхимическая станция", "Огонь для приготовления пищи", "Столярный верстак", "Ювелирная станция", "Станция создания нарядов", "Станция трансмутации", "Дорожное святилище"}
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

enableAlternateUniverse(GetDisplayName()=="@Dolgubon")
-- enableAlternateUniverse()

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
	[CRAFTING_TYPE_ALCHEMY] = "сосуд алхимика",
	[CRAFTING_TYPE_ENCHANTING] = "шкатулка зачарователя",
	[CRAFTING_TYPE_PROVISIONING] = "сумка снабженца",
	[CRAFTING_TYPE_BLACKSMITHING] = "ящик кузнеца",
	[CRAFTING_TYPE_CLOTHIER] = "ранец портного",
	[CRAFTING_TYPE_WOODWORKING] = "футляр столяра",
	[CRAFTING_TYPE_JEWELRYCRAFTING] = "шкатулка ювелира",
	[8] = "Carregamento",
}
end


function WritCreater.getTaString()
	return "та"
end

WritCreater.optionStrings["alternate universe"]				= "Отключить 1-апрельские шутки"
WritCreater.optionStrings["alternate universe tooltip"] 	= "Отключает переименовывание ремесленных станций, ремесла и прочих интерактивных предметов"

WritCreater.lang = "ru"
WritCreater.langIsMasterWritSupported = true

--[[
SLASH_COMMANDS['/opencontainers'] = function()local a=WritCreater.langWritRewardBoxes() for i=1,200 do for j=1,6 do if a[j]==GetItemName(1,i) then if IsProtectedFunction("endUseItem") then
	CallSecureProtected("endUseItem",1,i)
else
	UseItem(1,i)
end end end end end]]