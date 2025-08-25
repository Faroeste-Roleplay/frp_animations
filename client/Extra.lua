
local knockedOut = false
local gShouldRagdoll = false

RegisterCommand("spin", function(source, args)
    local kit_emote_twirl_type = `KIT_EMOTE_TWIRL_GUN`
    local kit_emote_twirl_variation_num = tonumber( args[1] )

    if args[2] == "dual" then
        kit_emote_twirl_type = `KIT_EMOTE_TWIRL_GUN_DUAL`
    elseif args[2] == "" then
        kit_emote_twirl_type = `KIT_EMOTE_TWIRL_GUN_LEFT_HOLSTER`
    end

    if ( kit_emote_twirl_variation_num ) then
        local weapon_twirl_variation_names = {
            [0] = "REVERSE_SPIN",
            [1] = "SPIN_UP",
            [2] = "REVERSE_SPIN_UP",
            [3] = "ALTERNATING_FLIPS",
            [4] = "SHOULDER_TOSS",
            [5] = "FIGURE_EIGHT_TOSS",
        }
        local ped = PlayerPedId()

        local kit_emote_twirl_variation = weapon_twirl_variation_names[kit_emote_twirl_variation_num] or weapon_twirl_variation_names[0]
        local emote_category = 4  -- category "TwirlGun"

        Citizen.InvokeNative(0xCBCFFF805F1B4596, ped, kit_emote_twirl_type)
        Citizen.InvokeNative(0xB31A277C1AC7B7FF, ped, emote_category, 1, kit_emote_twirl_type, true, false, false, false, false)
        Citizen.InvokeNative(0x01F661BB9C71B465, ped, 0, GetHashKey(kit_emote_twirl_variation))
        Citizen.InvokeNative(0x408CF580C5E96D49, ped, 0)

    else
        print("Argumento inválido. Utilize um número de 0 a 5 para selecionar a variação.")
    end
end)


function handleUpdatePlayerRagdollState()
    Citizen.CreateThread(function()
        while gShouldRagdoll do
            Citizen.Wait(0)

            local playerPedId = PlayerPedId()

            if not IsPedRagdoll(playerPedId) then
                SetPedToRagdoll(playerPedId, 0, 1, 0, false, false, false)
            end

            ResetPedRagdollTimer(playerPedId)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Z Key.
        if IsControlJustPressed(0, `INPUT_FRONTEND_LS`) then
            gShouldRagdoll = not gShouldRagdoll

            if gShouldRagdoll then
                if not isPedLassoed(PlayerPedId()) then
                    handleUpdatePlayerRagdollState()
                end
            end
        end
    end
end)

function isPedLassoed(ped)
    return Citizen.InvokeNative(0x9682F850056C9ADE, ped)
end



Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if IsControlJustPressed(0,0x156F7119) then
            local canClear = LocalPlayer.state?.canClearAnim
            if canClear then
                Wait(100)
                ClearPedTasks(PlayerPedId())
            end
        end 
    end
end)



RegisterCommand("acomida",function(source, args)
    local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
    local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)

    Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)

    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)

    TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
    TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)

    Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
end
)