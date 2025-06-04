-- ============================================================================
-- SOLAR PANELS MOD - INIZIALIZZAZIONE COMPLETA
-- ============================================================================

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

-- Inizializza tabelle globali
if not solar_panels then
    solar_panels = {}
end

if not solar_batteries then
    solar_batteries = {}
end

if not solar_carpets then
    solar_carpets = {}
end

minetest.log("action", "[Solar Panels] ========================================")
minetest.log("action", "[Solar Panels] INIZIALIZZAZIONE SISTEMA ENERGIA SOLARE")
minetest.log("action", "[Solar Panels] ========================================")

-- Carica API semplificata
minetest.log("action", "[Solar Panels] Caricamento API...")
local api_success, api_error = pcall(dofile, modpath .. "/api.lua")
if not api_success then
    minetest.log("error", "[Solar Panels] ERRORE API: " .. (api_error or "Errore sconosciuto"))
else
    minetest.log("action", "[Solar Panels] ✅ API caricata")
end

-- Carica sistema energetico
minetest.log("action", "[Solar Panels] Caricamento sistema energetico...")
local energy_success, energy_error = pcall(dofile, modpath .. "/energy_system.lua")
if not energy_success then
    minetest.log("error", "[Solar Panels] ERRORE sistema energetico: " .. (energy_error or "Errore sconosciuto"))
else
    minetest.log("action", "[Solar Panels] ✅ Sistema energetico caricato")
end

-- Carica definizioni nodi
minetest.log("action", "[Solar Panels] Caricamento nodi...")
local nodes_success, nodes_error = pcall(dofile, modpath .. "/nodes.lua")
if not nodes_success then
    minetest.log("error", "[Solar Panels] ERRORE nodi: " .. (nodes_error or "Errore sconosciuto"))
else
    minetest.log("action", "[Solar Panels] ✅ Nodi caricati")
end

-- Carica ricette
minetest.log("action", "[Solar Panels] Caricamento ricette...")
local crafting_success, crafting_error = pcall(dofile, modpath .. "/crafting.lua")
if not crafting_success then
    minetest.log("error", "[Solar Panels] ERRORE ricette: " .. (crafting_error or "Errore sconosciuto"))
else
    minetest.log("action", "[Solar Panels] ✅ Ricette caricate")
end

-- Verifica finale dopo inizializzazione
minetest.after(3, function()
    minetest.log("action", "[Solar Panels] ========================================")
    minetest.log("action", "[Solar Panels] VERIFICA SISTEMA")
    minetest.log("action", "[Solar Panels] ========================================")
    
    local checks = {
        global_tables = type(solar_panels) == "table" and type(solar_batteries) == "table" and type(solar_carpets) == "table",
        energy_functions = type(is_daytime) == "function" and type(transfer_energy_to_batteries) == "function",
        node_functions = type(add_solar_panel) == "function" and type(remove_solar_panel) == "function",
        api_functions = solar_panels.api and type(solar_panels.api.get_solar_power_at) == "function"
    }
    
    local all_ok = true
    for check_name, result in pairs(checks) do
        if result then
            minetest.log("action", "[Solar Panels] ✅ " .. check_name .. " OK")
        else
            minetest.log("error", "[Solar Panels] ❌ " .. check_name .. " ERRORE")
            all_ok = false
        end
    end
    
    -- Verifica nodi registrati
    local nodes_registered = {
        "solar_panels:solar_panel_off",
        "solar_panels:solar_panel_on", 
        "solar_panels:advanced_solar_panel_off",
        "solar_panels:advanced_solar_panel_on",
        "solar_panels:solar_battery",
        "solar_panels:solar_carpet",
        "solar_panels:solar_lamp_off",
        "solar_panels:solar_lamp_on"
    }
    
    local nodes_ok = 0
    for _, node_name in ipairs(nodes_registered) do
        if minetest.registered_nodes[node_name] then
            nodes_ok = nodes_ok + 1
        else
            minetest.log("error", "[Solar Panels] ❌ Nodo " .. node_name .. " non registrato")
            all_ok = false
        end
    end
    
    minetest.log("action", "[Solar Panels] Nodi registrati: " .. nodes_ok .. "/" .. #nodes_registered)
    
    -- Conta pannelli esistenti nel mondo
    local panel_count = 0
    for _ in pairs(solar_panels) do
        panel_count = panel_count + 1
    end
    
    minetest.log("action", "[Solar Panels] ========================================")
    if all_ok and nodes_ok == #nodes_registered then
        minetest.log("action", "[Solar Panels] 🌞 SISTEMA COMPLETAMENTE FUNZIONANTE!")
        minetest.log("action", "[Solar Panels] ✅ Tutti i componenti operativi")
        minetest.log("action", "[Solar Panels] ✅ " .. nodes_ok .. " nodi registrati")
        minetest.log("action", "[Solar Panels] ✅ " .. panel_count .. " pannelli nel mondo")
        minetest.log("action", "[Solar Panels] ⚡ FLUSSO ENERGIA:")
        minetest.log("action", "[Solar Panels] ⚡ Pannelli(5 blocchi) → Batterie(10k RF)")
        minetest.log("action", "[Solar Panels] ⚡ Batterie(10 blocchi) → Dispositivi")
        minetest.log("action", "[Solar Panels] ⚡ Tappeti → Catena conduzione energia")
        minetest.log("action", "[Solar Panels] ⚡ Sistema: Energia reale con consumo/ricarica")
        minetest.log("action", "[Solar Panels] 🎮 Comandi: /solar_debug, /solar_update")
    else
        minetest.log("error", "[Solar Panels] ❌ SISTEMA CON PROBLEMI")
        minetest.log("error", "[Solar Panels] ❌ Controlla errori sopra")
    end
    minetest.log("action", "[Solar Panels] ========================================")
end)

minetest.log("action", "[Solar Panels] Mod Solar Panels inizializzata - Sistema energia solare completo")