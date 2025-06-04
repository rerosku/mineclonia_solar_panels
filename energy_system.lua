-- ============================================================================
-- SISTEMA ENERGIA SOLARE COMPLETO E FUNZIONANTE
-- ============================================================================

-- Tabelle globali per tracciare i dispositivi
if not minetest.global_exists("solar_panels") then
    solar_panels = {}
end

-- ============================================================================
-- FUNZIONI UTILITY BASE
-- ============================================================================

function is_daytime()
    local time_of_day = minetest.get_timeofday()
    return time_of_day > 0.25 and time_of_day < 0.75
end

function is_exposed_to_sky(pos)
    if not pos or not pos.x or not pos.y or not pos.z then
        return false
    end
    local above_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
    local light_level = minetest.get_node_light(above_pos, 0.5)
    return light_level and light_level >= 12
end

function should_panel_be_active(pos)
    if not pos then return false end
    return is_daytime() and is_exposed_to_sky(pos)
end

-- ============================================================================
-- SISTEMA TRASFERIMENTO ENERGIA CORRETTO
-- ============================================================================

-- Funzione per trasferire energia da pannelli a batterie
function transfer_energy_to_batteries(panel_pos, power)
    if not panel_pos or power <= 0 then return 0 end
    
    local batteries_charged = 0
    local radius = 5
    
    -- Trova batterie entro 5 blocchi
    local success, nodes = pcall(minetest.find_nodes_in_area,
        {x = panel_pos.x - radius, y = panel_pos.y - radius, z = panel_pos.z - radius},
        {x = panel_pos.x + radius, y = panel_pos.y + radius, z = panel_pos.z + radius},
        {"solar_panels:solar_battery"}
    )
    
    if success and nodes then
        for _, battery_pos in ipairs(nodes) do
            local meta = minetest.get_meta(battery_pos)
            if meta then
                local stored = meta:get_int("energy_stored") or 0
                local max_energy = meta:get_int("max_energy") or 10000
                
                if stored < max_energy then
                    local energy_to_add = math.min(power, max_energy - stored)
                    local new_stored = stored + energy_to_add
                    meta:set_int("energy_stored", new_stored)
                    
                    -- Aggiorna infotext
                    local percentage = math.floor((new_stored / max_energy) * 100)
                    meta:set_string("infotext", string.format("Batteria Solare (%d%% - %d/%d RF)", percentage, new_stored, max_energy))
                    
                    batteries_charged = batteries_charged + 1
                    minetest.log("action", "[Solar Panels] Pannello @ " .. minetest.pos_to_string(panel_pos) .. " ricarica batteria @ " .. minetest.pos_to_string(battery_pos) .. " +" .. energy_to_add .. " RF")
                    
                    -- Riduci il power disponibile
                    power = power - energy_to_add
                    if power <= 0 then break end
                end
            end
        end
    end
    
    return batteries_charged
end

-- Funzione per trasferire energia da batterie a dispositivi
function transfer_energy_from_batteries(battery_pos)
    if not battery_pos then return 0 end
    
    local meta = minetest.get_meta(battery_pos)
    if not meta then return 0 end
    
    local stored = meta:get_int("energy_stored") or 0
    if stored <= 0 then return 0 end
    
    local devices_powered = 0
    local total_energy_consumed = 0
    local radius = 10
    
    -- Trova dispositivi entro 10 blocchi
    local success, nodes = pcall(minetest.find_nodes_in_area,
        {x = battery_pos.x - radius, y = battery_pos.y - radius, z = battery_pos.z - radius},
        {x = battery_pos.x + radius, y = battery_pos.y + radius, z = battery_pos.z + radius},
        {"solar_panels:solar_lamp_off", "solar_panels:solar_lamp_on", "solar_panels:solar_carpet"}
    )
    
    if success and nodes then
        for _, device_pos in ipairs(nodes) do
            if stored <= 0 then break end
            
            local device_node = minetest.get_node(device_pos)
            local device_meta = minetest.get_meta(device_pos)
            
            if device_node and device_meta then
                -- Alimenta lampade
                if device_node.name:find("solar_lamp") then
                    local lamp_stored = device_meta:get_int("energy_stored") or 0
                    local lamp_max = device_meta:get_int("max_energy") or 500
                    
                    if lamp_stored < lamp_max then
                        local energy_to_give = math.min(5, stored, lamp_max - lamp_stored)
                        local new_lamp_stored = lamp_stored + energy_to_give
                        device_meta:set_int("energy_stored", new_lamp_stored)
                        
                        -- Aggiorna infotext lampada
                        local lamp_percentage = math.floor((new_lamp_stored / lamp_max) * 100)
                        device_meta:set_string("infotext", string.format("Lampada Solare (%d%% - %d/%d RF)", lamp_percentage, new_lamp_stored, lamp_max))
                        
                        stored = stored - energy_to_give
                        total_energy_consumed = total_energy_consumed + energy_to_give
                        devices_powered = devices_powered + 1
                        
                        minetest.log("action", "[Solar Panels] Batteria @ " .. minetest.pos_to_string(battery_pos) .. " alimenta lampada @ " .. minetest.pos_to_string(device_pos) .. " +" .. energy_to_give .. " RF")
                    end
                end
                
                -- Alimenta tappeti solari
                if device_node.name == "solar_panels:solar_carpet" then
                    local carpet_power = math.min(10, stored)
                    if carpet_power > 0 then
                        device_meta:set_int("powered_by_battery", 1)
                        device_meta:set_int("battery_power", carpet_power)
                        device_meta:set_string("infotext", "Tappeto Solare (Alimentato - " .. carpet_power .. " RF/t)")
                        
                        stored = stored - 1 -- Consumo minimo per mantenere il tappeto
                        total_energy_consumed = total_energy_consumed + 1
                        devices_powered = devices_powered + 1
                    end
                end
            end
        end
    end
    
    -- Aggiorna energia residua nella batteria
    if total_energy_consumed > 0 then
        meta:set_int("energy_stored", stored)
        local max_energy = meta:get_int("max_energy") or 10000
        local percentage = math.floor((stored / max_energy) * 100)
        meta:set_string("infotext", string.format("Batteria Solare (%d%% - %d/%d RF)", percentage, stored, max_energy))
        
        minetest.log("action", "[Solar Panels] Batteria @ " .. minetest.pos_to_string(battery_pos) .. " ha distribuito " .. total_energy_consumed .. " RF a " .. devices_powered .. " dispositivi")
    end
    
    return devices_powered
end

-- Funzione per propagare energia dai tappeti
function propagate_carpet_energy()
    local carpets_powered = 0
    
    -- Prima reset tutti i tappeti
    for _, player in ipairs(minetest.get_connected_players()) do
        if player and player:get_pos() then
            local player_pos = player:get_pos()
            local radius = 100
            
            local success, nodes = pcall(minetest.find_nodes_in_area,
                {x = player_pos.x - radius, y = player_pos.y - radius, z = player_pos.z - radius},
                {x = player_pos.x + radius, y = player_pos.y + radius, z = player_pos.z + radius},
                {"solar_panels:solar_carpet"}
            )
            
            if success and nodes then
                -- Reset tutti i tappeti
                for _, carpet_pos in ipairs(nodes) do
                    local meta = minetest.get_meta(carpet_pos)
                    if meta then
                        local powered_by_battery = meta:get_int("powered_by_battery") or 0
                        if powered_by_battery == 0 then
                            meta:set_int("carpet_powered", 0)
                            meta:set_int("carpet_power", 0)
                            meta:set_string("infotext", "Tappeto Solare (Inattivo)")
                        else
                            -- Tappeto alimentato da batteria
                            local battery_power = meta:get_int("battery_power") or 0
                            meta:set_int("carpet_powered", 1)
                            meta:set_int("carpet_power", battery_power)
                            carpets_powered = carpets_powered + 1
                        end
                    end
                end
                
                -- Propaga energia attraverso catene adiacenti
                local propagation_rounds = 3
                for round = 1, propagation_rounds do
                    local new_propagations = 0
                    
                    for _, carpet_pos in ipairs(nodes) do
                        local meta = minetest.get_meta(carpet_pos)
                        if meta and meta:get_int("carpet_powered") == 1 then
                            local power = meta:get_int("carpet_power") or 0
                            
                            if power > 1 then -- Deve avere almeno 2 RF per propagare
                                -- Propaga ai tappeti adiacenti
                                local adjacent_positions = {
                                    {x = carpet_pos.x + 1, y = carpet_pos.y, z = carpet_pos.z},
                                    {x = carpet_pos.x - 1, y = carpet_pos.y, z = carpet_pos.z},
                                    {x = carpet_pos.x, y = carpet_pos.y, z = carpet_pos.z + 1},
                                    {x = carpet_pos.x, y = carpet_pos.y, z = carpet_pos.z - 1}
                                }
                                
                                for _, adj_pos in ipairs(adjacent_positions) do
                                    local adj_node = minetest.get_node(adj_pos)
                                    if adj_node.name == "solar_panels:solar_carpet" then
                                        local adj_meta = minetest.get_meta(adj_pos)
                                        if adj_meta and adj_meta:get_int("carpet_powered") == 0 then
                                            local propagated_power = math.max(1, power - 2) -- Perde energia
                                            adj_meta:set_int("carpet_powered", 1)
                                            adj_meta:set_int("carpet_power", propagated_power)
                                            adj_meta:set_string("infotext", "Tappeto Solare (Catena - " .. propagated_power .. " RF/t)")
                                            new_propagations = new_propagations + 1
                                            carpets_powered = carpets_powered + 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    if new_propagations == 0 then break end
                end
                
                -- Tappeti alimentano dispositivi adiacenti
                for _, carpet_pos in ipairs(nodes) do
                    local meta = minetest.get_meta(carpet_pos)
                    if meta and meta:get_int("carpet_powered") == 1 then
                        local power = meta:get_int("carpet_power") or 0
                        
                        if power > 0 then
                            local adjacent_positions = {
                                {x = carpet_pos.x + 1, y = carpet_pos.y, z = carpet_pos.z},
                                {x = carpet_pos.x - 1, y = carpet_pos.y, z = carpet_pos.z},
                                {x = carpet_pos.x, y = carpet_pos.y + 1, z = carpet_pos.z},
                                {x = carpet_pos.x, y = carpet_pos.y - 1, z = carpet_pos.z},
                                {x = carpet_pos.x, y = carpet_pos.y, z = carpet_pos.z + 1},
                                {x = carpet_pos.x, y = carpet_pos.y, z = carpet_pos.z - 1}
                            }
                            
                            for _, adj_pos in ipairs(adjacent_positions) do
                                local adj_node = minetest.get_node(adj_pos)
                                
                                -- Alimenta lampade adiacenti
                                if adj_node.name:find("solar_lamp") then
                                    local adj_meta = minetest.get_meta(adj_pos)
                                    if adj_meta then
                                        local lamp_stored = adj_meta:get_int("energy_stored") or 0
                                        local lamp_max = adj_meta:get_int("max_energy") or 500
                                        
                                        if lamp_stored < lamp_max then
                                            local energy_to_give = math.min(3, power, lamp_max - lamp_stored)
                                            local new_lamp_stored = lamp_stored + energy_to_give
                                            adj_meta:set_int("energy_stored", new_lamp_stored)
                                            
                                            local lamp_percentage = math.floor((new_lamp_stored / lamp_max) * 100)
                                            adj_meta:set_string("infotext", string.format("Lampada Solare (%d%% - %d/%d RF)", lamp_percentage, new_lamp_stored, lamp_max))
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return carpets_powered
end

-- ============================================================================
-- TIMERS SISTEMA ENERGETICO
-- ============================================================================

-- Timer pannelli solari (ogni 2 secondi)
local panel_timer = 0
minetest.register_globalstep(function(dtime)
    panel_timer = panel_timer + dtime
    
    if panel_timer >= 2.0 then
        panel_timer = 0
        
        local panels_to_remove = {}
        local panels_processed = 0
        local panels_activated = 0
        local panels_deactivated = 0
        local batteries_charged = 0
        
        for pos_hash, panel_data in pairs(solar_panels) do
            if not panel_data or not panel_data.pos then
                table.insert(panels_to_remove, pos_hash)
            else
                panels_processed = panels_processed + 1
                local pos = panel_data.pos
                local success, node = pcall(minetest.get_node, pos)
                
                if success and node and node.name:find("solar_panel") then
                    local should_be_active = should_panel_be_active(pos)
                    local is_currently_active = node.name:find("_on") ~= nil
                    local is_advanced = node.name:find("advanced") ~= nil
                    
                    if should_be_active and not is_currently_active then
                        -- Attiva pannello
                        if is_advanced then
                            node.name = "solar_panels:advanced_solar_panel_on"
                        else
                            node.name = "solar_panels:solar_panel_on"
                        end
                        minetest.swap_node(pos, node)
                        panel_data.active = true
                        panels_activated = panels_activated + 1
                        
                        -- Aggiorna infotext
                        local meta = minetest.get_meta(pos)
                        if meta then
                            local power = is_advanced and 30 or 15
                            meta:set_string("infotext", string.format("Pannello Solare%s (Attivo - %d RF/t)", is_advanced and " Avanzato" or "", power))
                        end
                        
                    elseif not should_be_active and is_currently_active then
                        -- Disattiva pannello
                        if is_advanced then
                            node.name = "solar_panels:advanced_solar_panel_off"
                        else
                            node.name = "solar_panels:solar_panel_off"
                        end
                        minetest.swap_node(pos, node)
                        panel_data.active = false
                        panels_deactivated = panels_deactivated + 1
                        
                        -- Aggiorna infotext
                        local meta = minetest.get_meta(pos)
                        if meta then
                            local power = is_advanced and 30 or 15
                            meta:set_string("infotext", string.format("Pannello Solare%s (Inattivo - %d RF/t)", is_advanced and " Avanzato" or "", power))
                        end
                    end
                    
                    -- Se il pannello è attivo, trasferisci energia alle batterie
                    if panel_data.active then
                        local power = is_advanced and 30 or 15
                        batteries_charged = batteries_charged + transfer_energy_to_batteries(pos, power)
                    end
                else
                    table.insert(panels_to_remove, pos_hash)
                end
            end
        end
        
        -- Rimuovi pannelli non validi
        for _, pos_hash in ipairs(panels_to_remove) do
            solar_panels[pos_hash] = nil
        end
        
        if panels_activated > 0 or panels_deactivated > 0 or batteries_charged > 0 then
            minetest.log("action", "[Solar Panels] Pannelli: " .. panels_processed .. " processati, " .. panels_activated .. " attivati, " .. panels_deactivated .. " disattivati, " .. batteries_charged .. " batterie ricaricate")
        end
    end
end)

-- Timer batterie e distribuzione energia (ogni 3 secondi)
local battery_timer = 0
minetest.register_globalstep(function(dtime)
    battery_timer = battery_timer + dtime
    
    if battery_timer >= 3.0 then
        battery_timer = 0
        
        local batteries_processed = 0
        local devices_powered = 0
        
        -- Trova tutte le batterie e distribuisci energia
        for _, player in ipairs(minetest.get_connected_players()) do
            if player and player:get_pos() then
                local player_pos = player:get_pos()
                local radius = 100
                
                local success, nodes = pcall(minetest.find_nodes_in_area,
                    {x = player_pos.x - radius, y = player_pos.y - radius, z = player_pos.z - radius},
                    {x = player_pos.x + radius, y = player_pos.y + radius, z = player_pos.z + radius},
                    {"solar_panels:solar_battery"}
                )
                
                if success and nodes then
                    for _, battery_pos in ipairs(nodes) do
                        batteries_processed = batteries_processed + 1
                        devices_powered = devices_powered + transfer_energy_from_batteries(battery_pos)
                    end
                end
            end
        end
        
        if devices_powered > 0 then
            minetest.log("action", "[Solar Panels] Batterie: " .. batteries_processed .. " processate, " .. devices_powered .. " dispositivi alimentati")
        end
    end
end)

-- Timer tappeti solari (ogni 2 secondi)
local carpet_timer = 0
minetest.register_globalstep(function(dtime)
    carpet_timer = carpet_timer + dtime
    
    if carpet_timer >= 2.0 then
        carpet_timer = 0
        
        local carpets_powered = propagate_carpet_energy()
        
        if carpets_powered > 0 then
            minetest.log("action", "[Solar Panels] Tappeti: " .. carpets_powered .. " attivi nella catena")
        end
    end
end)

-- Timer lampade (ogni 4 secondi)
local lamp_timer = 0
minetest.register_globalstep(function(dtime)
    lamp_timer = lamp_timer + dtime
    
    if lamp_timer >= 4.0 then
        lamp_timer = 0
        
        local is_night = not is_daytime()
        local lamps_processed = 0
        local lamps_activated = 0
        local lamps_deactivated = 0
        
        for _, player in ipairs(minetest.get_connected_players()) do
            if player and player:get_pos() then
                local player_pos = player:get_pos()
                local radius = 80
                
                local success, nodes = pcall(minetest.find_nodes_in_area,
                    {x = player_pos.x - radius, y = player_pos.y - radius, z = player_pos.z - radius},
                    {x = player_pos.x + radius, y = player_pos.y + radius, z = player_pos.z + radius},
                    {"solar_panels:solar_lamp_off", "solar_panels:solar_lamp_on"}
                )
                
                if success and nodes then
                    for _, pos in ipairs(nodes) do
                        lamps_processed = lamps_processed + 1
                        local node = minetest.get_node(pos)
                        local meta = minetest.get_meta(pos)
                        
                        if node and meta then
                            local energy = meta:get_int("energy_stored") or 0
                            local is_currently_on = node.name == "solar_panels:solar_lamp_on"
                            
                            -- CORREZIONE: Le lampade si accendono SOLO se hanno energia E è notte
                            if is_night and energy > 0 and not is_currently_on then
                                node.name = "solar_panels:solar_lamp_on"
                                minetest.swap_node(pos, node)
                                lamps_activated = lamps_activated + 1
                                
                            elseif is_currently_on and (not is_night or energy <= 0) then
                                node.name = "solar_panels:solar_lamp_off"
                                minetest.swap_node(pos, node)
                                lamps_deactivated = lamps_deactivated + 1
                                
                            elseif is_currently_on and is_night and energy > 0 then
                                -- Consuma energia quando accesa
                                local new_energy = math.max(0, energy - 2)
                                meta:set_int("energy_stored", new_energy)
                                
                                -- Aggiorna infotext
                                local max_energy = meta:get_int("max_energy") or 500
                                local percentage = math.floor((new_energy / max_energy) * 100)
                                meta:set_string("infotext", string.format("Lampada Solare (%d%% - %d/%d RF)", percentage, new_energy, max_energy))
                            end
                        end
                    end
                end
            end
        end
        
        if lamps_activated > 0 or lamps_deactivated > 0 then
            minetest.log("action", "[Solar Panels] Lampade: " .. lamps_processed .. " trovate, " .. lamps_activated .. " accese, " .. lamps_deactivated .. " spente")
        end
    end
end)

-- ============================================================================
-- FUNZIONI UTILITY
-- ============================================================================

function add_solar_panel(pos, is_advanced)
    if not pos then return false end
    
    local pos_hash = minetest.hash_node_position(pos)
    solar_panels[pos_hash] = {
        pos = {x = pos.x, y = pos.y, z = pos.z},
        active = false,
        advanced = is_advanced or false
    }
    
    minetest.log("action", "[Solar Panels] Pannello aggiunto @ " .. minetest.pos_to_string(pos))
    return true
end

function remove_solar_panel(pos)
    if not pos then return false end
    
    local pos_hash = minetest.hash_node_position(pos)
    if solar_panels[pos_hash] then
        solar_panels[pos_hash] = nil
        minetest.log("action", "[Solar Panels] Pannello rimosso @ " .. minetest.pos_to_string(pos))
        return true
    end
    
    return false
end

function cleanup_orphaned_panels()
    local removed_count = 0
    local panels_to_remove = {}
    
    for pos_hash, panel_data in pairs(solar_panels) do
        if not panel_data or not panel_data.pos then
            table.insert(panels_to_remove, pos_hash)
        else
            local pos = panel_data.pos
            local success, node = pcall(minetest.get_node, pos)
            if not success or not node or not node.name:find("solar_panels:solar_panel") then
                table.insert(panels_to_remove, pos_hash)
            end
        end
    end
    
    for _, pos_hash in ipairs(panels_to_remove) do
        solar_panels[pos_hash] = nil
        removed_count = removed_count + 1
    end
    
    local total_panels = 0
    for _ in pairs(solar_panels) do
        total_panels = total_panels + 1
    end
    
    minetest.log("action", "[Solar Panels] Pulizia: " .. removed_count .. " pannelli orfani rimossi, " .. total_panels .. " pannelli attivi")
end

minetest.after(2, cleanup_orphaned_panels)

-- ============================================================================
-- COMANDI DEBUG
-- ============================================================================

minetest.register_chatcommand("solar_debug", {
    description = "Debug sistema solare",
    privs = {server = true},
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Giocatore non trovato" end
        
        local pos = player:get_pos()
        local panel_count = 0
        local active_panels = 0
        
        for _, panel_data in pairs(solar_panels) do 
            panel_count = panel_count + 1
            if panel_data and panel_data.active then
                active_panels = active_panels + 1
            end
        end
        
        local info = {
            "=== SISTEMA ENERGIA SOLARE ===",
            "Posizione: " .. minetest.pos_to_string(pos),
            "È giorno: " .. (is_daytime() and "SÌ" or "NO"),
            "Pannelli registrati: " .. panel_count,
            "Pannelli attivi: " .. active_panels,
            "Sistema: PANNELLI(5 blocchi) → BATTERIE(10k RF) → DISPOSITIVI(10 blocchi)",
            "Tappeti: Conducono energia se alimentati da batterie"
        }
        
        return true, table.concat(info, "\n")
    end
})

minetest.register_chatcommand("solar_update", {
    description = "Forza aggiornamento sistema",
    privs = {server = true},
    func = function(name, param)
        -- Forza un ciclo di aggiornamento
        local batteries_charged = 0
        local devices_powered = 0
        
        -- Ricarica batterie dai pannelli attivi
        for _, panel_data in pairs(solar_panels) do
            if panel_data and panel_data.active and panel_data.pos then
                local power = panel_data.advanced and 30 or 15
                batteries_charged = batteries_charged + transfer_energy_to_batteries(panel_data.pos, power)
            end
        end
        
        -- Distribuisci energia dalle batterie
        for _, player in ipairs(minetest.get_connected_players()) do
            if player and player:get_pos() then
                local player_pos = player:get_pos()
                local radius = 100
                
                local success, nodes = pcall(minetest.find_nodes_in_area,
                    {x = player_pos.x - radius, y = player_pos.y - radius, z = player_pos.z - radius},
                    {x = player_pos.x + radius, y = player_pos.y + radius, z = player_pos.z + radius},
                    {"solar_panels:solar_battery"}
                )
                
                if success and nodes then
                    for _, battery_pos in ipairs(nodes) do
                        devices_powered = devices_powered + transfer_energy_from_batteries(battery_pos)
                    end
                end
            end
        end
        
        -- Propaga tappeti
        local carpets = propagate_carpet_energy()
        
        return true, "Aggiornamento: " .. batteries_charged .. " batterie ricaricate, " .. devices_powered .. " dispositivi alimentati, " .. carpets .. " tappeti attivi"
    end
})

minetest.log("action", "[Solar Panels] Sistema energetico corretto e funzionante inizializzato")
minetest.log("action", "[Solar Panels] Flusso: Pannelli → Batterie → Dispositivi (con consumo energia reale)")