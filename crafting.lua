-- ============================================================================
-- RICETTE DI CRAFTING SEMPLIFICATE
-- ============================================================================

-- Pannello Solare Base
minetest.register_craft({
    output = "solar_panels:solar_panel_off",
    recipe = {
        {"mcl_core:glass", "mcl_core:glass", "mcl_core:glass"},
        {"mcl_core:glass", "mcl_core:diamond", "mcl_core:glass"},
        {"mcl_core:iron_ingot", "mcl_core:iron_ingot", "mcl_core:iron_ingot"}
    }
})

-- Pannello Solare Avanzato
minetest.register_craft({
    output = "solar_panels:advanced_solar_panel_off",
    recipe = {
        {"solar_panels:solar_panel_off", "mcl_core:diamond", "solar_panels:solar_panel_off"},
        {"mcl_core:gold_ingot", "mcl_core:emerald", "mcl_core:gold_ingot"},
        {"mcl_core:iron_ingot", "mcl_core:redstone", "mcl_core:iron_ingot"}
    }
})

-- Batteria Solare
minetest.register_craft({
    output = "solar_panels:solar_battery",
    recipe = {
        {"mcl_core:iron_ingot", "mcl_core:redstone", "mcl_core:iron_ingot"},
        {"mcl_core:redstone", "mcl_core:gold_ingot", "mcl_core:redstone"},
        {"mcl_core:iron_ingot", "mcl_core:redstone", "mcl_core:iron_ingot"}
    }
})

-- Tappeto Solare
minetest.register_craft({
    output = "solar_panels:solar_carpet 4",
    recipe = {
        {"mcl_core:glass", "mcl_core:glass", "mcl_core:glass"},
        {"mcl_core:redstone", "mcl_core:iron_ingot", "mcl_core:redstone"},
        {"", "", ""}
    }
})

-- Lampada Solare
minetest.register_craft({
    output = "solar_panels:solar_lamp_off",
    recipe = {
        {"", "mcl_core:glass", ""},
        {"mcl_core:glass", "mcl_torches:torch", "mcl_core:glass"},
        {"mcl_core:glass", "mcl_core:redstone", "mcl_core:glass"}
    }
})

minetest.log("action", "[Solar Panels] Ricette di crafting registrate")