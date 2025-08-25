MenuData = {}
TriggerEvent("menu_base:getData",function(call)
    MenuData = call
end)

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

if Config.MenuPosition then
    if Config.MenuPosition == "left" then
        menuPosition = leftPosition
    elseif Config.MenuPosition == "right" then
        menuPosition = rightPosition
    end
end



function ShowNotification(text)
    -- SetNotificationTextEntry("STRING")
    -- AddTextComponentString(text)
    -- DrawNotification(false, false)
end

local EmoteTable = {}
local FavEmoteTable = {}
local DanceTable = {}
local PropETable = {}
local WalkTable = {}
local FaceTable = {}
local FavoriteEmote = ""


function AddEmoteMenu()  
	MenuData.CloseAll()

    local elements = {
        {label = "Animações", value = 'emotes' , desc = "Escolha uma opção"},
		{label = "🕺 Danças", value = 'dances' , desc = "Escolha uma opção"},
		-- {label = "📦 Objetos", value = 'props' , desc = "Escolha uma opção"},
    }
    
	MenuData.Open(
    'default', GetCurrentResourceName(), 'EMOTEMENU',

    {
        title    = 'Emotes',
        subtext    = 'Estolha um emote',
        align    = 'top-' .. Config.MenuPosition,
        elements = elements,
    },

    function(data, menu)
        if data.current.value == 'emotes' then
            if EmoteTable[index] ~= "🌟 Keybind" then
                OpenEmoteSubMenu("emotes")
            end
        elseif data.current.value == 'dances' then
            OpenEmoteSubMenu("dances")            
        elseif data.current.value == 'props' then
            OpenEmoteSubMenu("props")
        end
    end,
    
    function(data, menu)
        MenuData.CloseAll()
    end)
end



function OpenEmoteSubMenu(menuType)
    MenuData.CloseAll()
    
    local elements = {}

    if menuType == 'emotes' then
        for a,b in pairsByKeys(AnimationList.Emotes) do
            x,y,z = table.unpack(b)
            table.insert(elements, {label = "/a ("..a..")", value = 'emotes', index = z, desc = "Escolha uma opção"})
            --favmenu:AddItem(favemoteitem)
            EmoteTable[z] = a
            FavEmoteTable[z] = a
            -- table.insert(EmoteTable, a)
            -- table.insert(FavEmoteTable, a)
        end
    elseif menuType == 'dances' then
        for a,b in pairsByKeys(AnimationList.Dances) do
            x,y,z = table.unpack(b)
            table.insert(elements, {label = "/a ("..a..")", value = 'dances', index = z, desc = "Escolha uma opção"})
            DanceTable[z] = a
        end
    elseif menuType == 'props' then
        for a,b in pairsByKeys(AnimationList.PropEmotes) do
            x,y,z = table.unpack(b)
            table.insert(elements, {label = "/a ("..a..")", value = 'props', index = z, desc = "Escolha uma opção"})
            -- favmenu:AddItem(propfavitem)
            PropETable[z] = a
            FavEmoteTable[z] = a
        end
    end

    local titleMenu = ""

    if menuType == 'emotes' then
        titleMenu = "Animações"
    elseif menuType == 'dances' then        
        titleMenu = "🕺 Danças"
    elseif menuType == 'props' then
        titleMenu = "📦 Objetos"
    end

    MenuData.Open(
    'default', GetCurrentResourceName(), 'EMOTEMENU',

    {
        title    = titleMenu,
        subtext    = 'Estolha um emote',
        align    = 'top-' .. Config.MenuPosition,
        elements = elements,
    },

    function(data, menu)
        if menuType == 'emotes' then
            if EmoteTable[index] ~= "🌟 Keybind" then
                EmoteMenuStart(EmoteTable[data.current.index], "emotes")
            end
        elseif menuType == 'dances' then
            EmoteMenuStart(DanceTable[data.current.index], "dances")            
        elseif menuType == 'props' then
            EmoteMenuStart(PropETable[data.current.index], "props")
        end
    end,
    
    function(data, menu)
        AddEmoteMenu()
    end)
end

function OpenEmoteMenu()
    AddEmoteMenu()
end

RegisterNetEvent('animations:client:ToggleMenu')
AddEventHandler('animations:client:ToggleMenu', function()
    if CanDoEmote then
        OpenEmoteMenu()
    else
        Core.Functions.Notify("You can't do emotes right now", "error")
    end
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end