-- ============================================================================
-- API SEMPLIFICATA PER COMPATIBILITÀ
-- ============================================================================

-- Inizializza l'API se non esiste già
if not solar_panels then
    solar_panels = {}
end

if not solar_panels.api then
    solar_panels.api = {}
end

-- Funzione per ottenere l'energia solare disponibile in una posizione
function solar_panels.api.get_solar_power_at(pos)
    if not pos or type(pos) ~= "table" or not pos.x or not pos.y or not pos.z then
        return 0
    end
    
    -- Controlla che le coordinate siano numeri validi
    if type(pos.x) ~= "number" or type(pos.y) ~= "number" or type(pos.z) ~= "number" then
        return 0
    end
    
    local adjacent_positions = {
        {x = pos.x + 1, y = pos.y, z = pos.z},
        {x = pos.x - 1, y = pos.y, z = pos.z},
        {x = pos.x, y = pos.y + 1, z = pos.z},
        {x = pos.x, y = pos.y - 1, z = pos.z},
        {x = pos.x, y = pos.y, z = pos.z + 1},
        {x = pos.x, y = pos.y, z = pos.z - 1}
    }
    
    local total_power = 0
    
    for _, adj_pos in ipairs(adjacent_positions) do
        local success, node = pcall(minetest.get_node, adj_pos)
        if success and node and node.name then
            if node.name == "solar_panels:solar_panel_on" then
                total_power = total_power + 15
            elseif node.name == "solar_panels:advanced_solar_panel_on" then
                total_power = total_power + 30
            end
        end
    end
    
    return total_power
end

-- Verifica se una posizione riceve energia solare
function solar_panels.api.is_solar_powered(pos)
    return solar_panels.api.get_solar_power_at(pos) > 0
end

-- Ottieni statistiche globali sui pannelli solari
function solar_panels.api.get_global_stats()
    local stats = {
        total_panels = 0,
        active_panels = 0,
        total_power_generation = 0,
        advanced_panels = 0,
        normal_panels = 0
    }
    
    if not solar_panels then
        return stats
    end
    
    for _, panel_data in pairs(solar_panels) do
        if panel_data and type(panel_data) == "table" then
            stats.total_panels = stats.total_panels + 1
            
            if panel_data.active then
                stats.active_panels = stats.active_panels + 1
                
                if panel_data.advanced then
                    stats.total_power_generation = stats.total_power_generation + 30
                    stats.advanced_panels = stats.advanced_panels + 1
                else
                    stats.total_power_generation = stats.total_power_generation + 15
                    stats.normal_panels = stats.normal_panels + 1
                end
            end
        end
    end
    
    return stats
end

minetest.log("action", "[Solar Panels API] API semplificata inizializzata")