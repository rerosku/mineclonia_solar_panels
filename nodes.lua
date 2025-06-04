-- ============================================================================
-- DEFINIZIONI NODI SISTEMA ENERGIA SOLARE
-- ============================================================================

-- ============================================================================
-- PANNELLO SOLARE BASE
-- ============================================================================

minetest.register_node("solar_panels:solar_panel_off", {
    description = "Pannello Solare\nRicarica batterie entro 5 blocchi",
    tiles = {
        "solar_panel_top.png",
        "solar_panel_bottom.png",
        "solar_panel_side.png",
        "solar_panel_side.png",
        "solar_panel_back.png",
        "solar_panel_front.png"
    },
    
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    
    node_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.4, 0.4, -0.3, 0.4},
            {-0.4, -0.3, -0.4, -0.3, 0.1, -0.3},
            {0.3, -0.3, -0.4, 0.4, 0.1, -0.3},
            {-0.4, -0.3, 0.3, -0.3, 0.1, 0.4},
            {0.3, -0.3, 0.3, 0.4, 0.1, 0.4},
            {-0.5, -0.1, -0.5, 0.5, 0.0, 0.3},
            {-0.5, 0.0, -0.3, 0.5, 0.1, 0.1},
            {-0.5, 0.1, -0.1, 0.5, 0.2, 0.5}
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.2, 0.5}
    },
    
    groups = {cracky = 2, oddly_breakable_by_hand = 2, solar_panel = 1},
    sounds = mcl_sounds and mcl_sounds.node_sound_metal_defaults() or {},
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_string("infotext", "Pannello Solare (Inattivo - 15 RF/t)")
        end
        
        if add_solar_panel then
            add_solar_panel(pos, false)
        end
        
        minetest.log("action", "[Solar Panels] Pannello base costruito @ " .. minetest.pos_to_string(pos))
    end,
    
    on_destruct = function(pos)
        if remove_solar_panel then
            remove_solar_panel(pos)
        end
    end
})

minetest.register_node("solar_panels:solar_panel_on", {
    description = "Pannello Solare (Attivo)",
    tiles = {
        "solar_panel_top_on.png",
        "solar_panel_bottom.png",
        "solar_panel_side.png",
        "solar_panel_side.png",
        "solar_panel_back.png",
        "solar_panel_front.png"
    },
    
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 3,
    
    node_box = {
        type = "fixed",
        fixed = {
            {-0.4, -0.5, -0.4, 0.4, -0.3, 0.4},
            {-0.4, -0.3, -0.4, -0.3, 0.1, -0.3},
            {0.3, -0.3, -0.4, 0.4, 0.1, -0.3},
            {-0.4, -0.3, 0.3, -0.3, 0.1, 0.4},
            {0.3, -0.3, 0.3, 0.4, 0.1, 0.4},
            {-0.5, -0.1, -0.5, 0.5, 0.0, 0.3},
            {-0.5, 0.0, -0.3, 0.5, 0.1, 0.1},
            {-0.5, 0.1, -0.1, 0.5, 0.2, 0.5}
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.2, 0.5}
    },
    
    groups = {cracky = 2, oddly_breakable_by_hand = 2, solar_panel = 1, not_in_creative_inventory = 1},
    drop = "solar_panels:solar_panel_off",
    sounds = mcl_sounds and mcl_sounds.node_sound_metal_defaults() or {},
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_string("infotext", "Pannello Solare (Attivo - 15 RF/t)")
        end
    end,
    
    on_destruct = function(pos)
        if remove_solar_panel then
            remove_solar_panel(pos)
        end
    end
})

-- ============================================================================
-- PANNELLO SOLARE AVANZATO
-- ============================================================================

minetest.register_node("solar_panels:advanced_solar_panel_off", {
    description = "Pannello Solare Avanzato\nRicarica batterie entro 5 blocchi\nDoppia efficienza (30 RF/t)",
    tiles = {
        "advanced_solar_panel_top.png",
        "advanced_solar_panel_bottom.png",
        "advanced_solar_panel_side.png",
        "advanced_solar_panel_side.png",
        "advanced_solar_panel_back.png",
        "advanced_solar_panel_front.png"
    },
    
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5},
            {-0.4, -0.2, -0.4, -0.2, 0.3, -0.2},
            {0.2, -0.2, -0.4, 0.4, 0.3, -0.2},
            {-0.4, -0.2, 0.2, -0.2, 0.3, 0.4},
            {0.2, -0.2, 0.2, 0.4, 0.3, 0.4},
            {-0.5, 0.0, -0.5, 0.0, 0.1, 0.5},
            {0.0, 0.0, -0.5, 0.5, 0.1, 0.5},
            {-0.5, 0.1, -0.3, 0.5, 0.2, 0.5},
            {-0.5, 0.2, -0.1, 0.5, 0.3, 0.5}
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.3, 0.5}
    },
    
    groups = {cracky = 1, oddly_breakable_by_hand = 1, solar_panel = 2},
    sounds = mcl_sounds and mcl_sounds.node_sound_metal_defaults() or {},
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_string("infotext", "Pannello Solare Avanzato (Inattivo - 30 RF/t)")
        end
        
        if add_solar_panel then
            add_solar_panel(pos, true)
        end
        
        minetest.log("action", "[Solar Panels] Pannello avanzato costruito @ " .. minetest.pos_to_string(pos))
    end,
    
    on_destruct = function(pos)
        if remove_solar_panel then
            remove_solar_panel(pos)
        end
    end
})

minetest.register_node("solar_panels:advanced_solar_panel_on", {
    description = "Pannello Solare Avanzato (Attivo)",
    tiles = {
        "advanced_solar_panel_top_on.png",
        "advanced_solar_panel_bottom.png",
        "advanced_solar_panel_side.png",
        "advanced_solar_panel_side.png",
        "advanced_solar_panel_back.png",
        "advanced_solar_panel_front.png"
    },
    
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 5,
    
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5},
            {-0.4, -0.2, -0.4, -0.2, 0.3, -0.2},
            {0.2, -0.2, -0.4, 0.4, 0.3, -0.2},
            {-0.4, -0.2, 0.2, -0.2, 0.3, 0.4},
            {0.2, -0.2, 0.2, 0.4, 0.3, 0.4},
            {-0.5, 0.0, -0.5, 0.0, 0.1, 0.5},
            {0.0, 0.0, -0.5, 0.5, 0.1, 0.5},
            {-0.5, 0.1, -0.3, 0.5, 0.2, 0.5},
            {-0.5, 0.2, -0.1, 0.5, 0.3, 0.5}
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.3, 0.5}
    },
    
    groups = {cracky = 1, oddly_breakable_by_hand = 1, solar_panel = 2, not_in_creative_inventory = 1},
    drop = "solar_panels:advanced_solar_panel_off",
    sounds = mcl_sounds and mcl_sounds.node_sound_metal_defaults() or {},
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_string("infotext", "Pannello Solare Avanzato (Attivo - 30 RF/t)")
        end
    end,
    
    on_destruct = function(pos)
        if remove_solar_panel then
            remove_solar_panel(pos)
        end
    end
})

-- ============================================================================
-- BATTERIA SOLARE
-- ============================================================================

minetest.register_node("solar_panels:solar_battery", {
    description = "Batteria Solare\nCapacità: 10.000 RF\nAlimenta dispositivi entro 10 blocchi",
    tiles = {
        "solar_battery_top.png",
        "solar_battery_bottom.png",
        "solar_battery_side.png"
    },
    
    groups = {cracky = 2, oddly_breakable_by_hand = 2},
    sounds = mcl_sounds and mcl_sounds.node_sound_metal_defaults() or {},
    paramtype2 = "facedir",
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_int("energy_stored", 0)
            meta:set_int("max_energy", 10000)
            meta:set_string("infotext", "Batteria Solare (0% - 0/10.000 RF)")
        end
        
        minetest.log("action", "[Solar Panels] Batteria costruita @ " .. minetest.pos_to_string(pos))
    end,
    
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        if not pos or not clicker then return end
        
        local meta = minetest.get_meta(pos)
        if not meta then return end
        
        local stored = meta:get_int("energy_stored") or 0
        local max_energy = meta:get_int("max_energy") or 10000
        local percentage = math.floor((stored / math.max(max_energy, 1)) * 100)
        
        local status = "Standby"
        if stored >= max_energy then
            status = "Carica completa"
        elseif stored > 0 then
            status = "Distribuzione energia"
        else
            status = "Scarica"
        end
        
        minetest.show_formspec(clicker:get_player_name(), "solar_battery",
            "size[8,6]" ..
            "label[0,0;Batteria Solare]" ..
            "label[0,1;Stato: " .. status .. "]" ..
            string.format("label[0,2;Energia: %d/%d RF (%d%%)]", stored, max_energy, percentage) ..
            "label[0,3;Range alimentazione: 10 blocchi]" ..
            "label[0,4;Funziona 24/7 se ha energia]" ..
            "label[0,5;Ricaricata dai pannelli solari]"
        )
    end
})

-- ============================================================================
-- TAPPETO SOLARE
-- ============================================================================

minetest.register_node("solar_panels:solar_carpet", {
    description = "Tappeto Solare\nConduce energia solare\nSi propaga a catena tra tappeti adiacenti",
    tiles = {
        "solar_carpet_top.png",
        "solar_carpet_bottom.png",
        "solar_carpet_side.png"
    },
    
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
    },
    
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
    },
    
    groups = {cracky = 3, oddly_breakable_by_hand = 3, carpet = 1, solar_device = 1},
    sounds = mcl_sounds and mcl_sounds.node_sound_wool_defaults() or {},
    walkable = true,
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_int("carpet_powered", 0)
            meta:set_int("carpet_power", 0)
            meta:set_int("powered_by_battery", 0)
            meta:set_int("battery_power", 0)
            meta:set_string("infotext", "Tappeto Solare (Inattivo)")
        end
        
        minetest.log("action", "[Solar Panels] Tappeto solare costruito @ " .. minetest.pos_to_string(pos))
    end,
    
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        if not pos or not clicker then return end
        
        local meta = minetest.get_meta(pos)
        if not meta then return end
        
        local powered = meta:get_int("carpet_powered") or 0
        local power = meta:get_int("carpet_power") or 0
        
        local status = "Inattivo"
        if powered == 1 then
            status = "Conduce energia (" .. power .. " RF/t)"
        end
        
        minetest.show_formspec(clicker:get_player_name(), "solar_carpet",
            "size[8,6]" ..
            "label[0,0;Tappeto Solare]" ..
            "label[0,1;Stato: " .. status .. "]" ..
            "label[0,2;Funzione: Conduce energia senza accumulo]" ..
            "label[0,3;Giorno: Pannelli → Batterie via tappeti]" ..
            "label[0,4;Notte: Batterie → Dispositivi via tappeti]" ..
            "label[0,5;Si propaga a catena tra tappeti adiacenti]"
        )
    end,
    
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        if not pos then return end
        
        -- Verifica che ci sia un blocco sotto
        local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
        local below_node = minetest.get_node(below_pos)
        
        if below_node.name == "air" then
            if placer then
                minetest.chat_send_player(placer:get_player_name(), "Il tappeto solare deve essere posizionato sopra un blocco solido!")
            end
            minetest.remove_node(pos)
            return itemstack
        end
    end
})

-- ============================================================================
-- LAMPADA SOLARE
-- ============================================================================

minetest.register_node("solar_panels:solar_lamp_off", {
    description = "Lampada Solare\nSi accende automaticamente di notte\nAlimentata dalle batterie solari",
    tiles = {"solar_lamp_off.png"},
    
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    
    node_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.45, 0.1},
            {-0.05, -0.45, -0.05, 0.05, -0.1, 0.05},
            {-0.25, -0.1, -0.25, 0.25, 0.1, 0.25},
            {-0.2, -0.2, -0.2, 0.2, 0.2, 0.2},
            {-0.15, -0.25, -0.15, 0.15, 0.25, 0.15},
            {-0.3, -0.05, -0.3, 0.3, 0.05, 0.3},
            {-0.1, -0.3, -0.1, 0.1, 0.3, 0.1},
            {-0.35, 0, -0.05, 0.35, 0.05, 0.05},
            {-0.05, 0, -0.35, 0.05, 0.05, 0.35}
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4}
    },
    
    groups = {cracky = 2, oddly_breakable_by_hand = 2},
    sounds = mcl_sounds and mcl_sounds.node_sound_glass_defaults() or {},
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_int("energy_stored", 0)
            meta:set_int("max_energy", 500)
            meta:set_string("infotext", "Lampada Solare (0% - 0/500 RF)")
        end
        
        minetest.log("action", "[Solar Panels] Lampada costruita @ " .. minetest.pos_to_string(pos))
    end,
    
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        if not pos or not clicker then return end
        
        local meta = minetest.get_meta(pos)
        if not meta then return end
        
        local stored = meta:get_int("energy_stored") or 0
        local max_energy = meta:get_int("max_energy") or 500
        local percentage = math.floor((stored / math.max(max_energy, 1)) * 100)
        
        local status = "Spenta"
        if stored > 0 then
            status = "Pronta (energia disponibile)"
        end
        
        minetest.show_formspec(clicker:get_player_name(), "solar_lamp",
            "size[8,6]" ..
            "label[0,0;Lampada Solare Sferica]" ..
            "label[0,1;Stato: " .. status .. "]" ..
            string.format("label[0,2;Energia: %d/%d RF (%d%%)]", stored, max_energy, percentage) ..
            "label[0,3;Si accende automaticamente di notte]" ..
            "label[0,4;Alimentata dalle batterie solari]" ..
            "label[0,5;Consumo: 2 RF ogni 4 secondi]"
        )
    end
})

minetest.register_node("solar_panels:solar_lamp_on", {
    description = "Lampada Solare (Accesa)",
    tiles = {"solar_lamp_on.png"},
    light_source = 14,
    
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    
    node_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.45, 0.1},
            {-0.05, -0.45, -0.05, 0.05, -0.1, 0.05},
            {-0.3, -0.15, -0.3, 0.3, 0.15, 0.3},
            {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
            {-0.2, -0.3, -0.2, 0.2, 0.3, 0.2},
            {-0.35, -0.1, -0.35, 0.35, 0.1, 0.35},
            {-0.1, -0.35, -0.1, 0.1, 0.35, 0.1},
            {-0.4, 0, -0.05, 0.4, 0.05, 0.05},
            {-0.05, 0, -0.4, 0.05, 0.05, 0.4}
        }
    },
    
    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4}
    },
    
    groups = {cracky = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    drop = "solar_panels:solar_lamp_off",
    sounds = mcl_sounds and mcl_sounds.node_sound_glass_defaults() or {},
    
    on_construct = function(pos)
        if not pos then return end
        
        local meta = minetest.get_meta(pos)
        if meta then
            meta:set_string("infotext", "Lampada Solare (Accesa)")
        end
    end
})

minetest.log("action", "[Solar Panels] Nodi registrati: Pannelli, Batterie (10k RF), Tappeti solari, Lampade")