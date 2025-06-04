# 🌞 Solar Panels Mod per Luanti MineClonia

Una mod completa che aggiunge pannelli solari funzionanti e un sistema di energia solare a Luanti MineClonia.

## 📋 Indice

- [Caratteristiche](#caratteristiche)
- [Installazione](#installazione)
- [Oggetti Disponibili](#oggetti-disponibili)
- [Ricette di Crafting](#ricette-di-crafting)
- [Come Funziona](#come-funziona)
- [API per Sviluppatori](#api-per-sviluppatori)
- [Compatibilità](#compatibilità)
- [Risoluzione Problemi](#risoluzione-problemi)

## ✨ Caratteristiche

### 🔋 Sistema Energetico
- **Nuovo tipo di energia**: Sistema solare separato ma compatibile con redstone
- **Generazione realistica**: I pannelli funzionano solo durante il giorno (6:00-18:00)
- **Trasmissione diretta**: Energia trasmessa ai 6 blocchi adiacenti
- **Efficienza variabile**: Pannelli normali (15 RF/t) e avanzati (30 RF/t)

### 🏗️ Blocchi Disponibili
- **Pannello Solare Base**: Design realistico inclinato 30°
- **Pannello Solare Avanzato**: Doppia efficienza con design più complesso
- **Batteria Solare**: Immagazzina fino a 1000 RF di energia
- **Lampada Solare**: Si accende automaticamente di notte

### 🎮 Funzionalità Avanzate
- **GUI informative**: Mostra stato, energia prodotta, statistiche
- **Attivazione automatica**: Cambio automatico giorno/notte
- **Compatibilità redstone**: Funziona con mesecons di MineClonia
- **Sistema di debug**: Comandi per amministratori

## 📦 Installazione

### Requisiti
- **Luanti 5.0+** (ex Minetest)
- **MineClonia 0.86+** (ex MineClone2)
- **mcl_core** (incluso in MineClonia)

### Opzionali
- **mesecons** (per compatibilità redstone)
- **mcl_sounds** (per effetti sonori)

### Passi
1. Scarica tutti i file della mod
2. Crea una cartella `solar_panels` in `mods/`
3. Copia tutti i file nella cartella:
   ```
   solar_panels/
   ├── init.lua
   ├── mod.conf
   ├── energy_system.lua
   ├── nodes.lua
   ├── crafting.lua
   ├── api.lua
   ├── README.md
   └── textures/
       ├── solar_panel_top.png
       ├── solar_panel_top_on.png
       ├── (altre texture...)
   ```
4. Attiva la mod nel menu delle mod
5. Riavvia il mondo

## 🧱 Oggetti Disponibili

### Pannello Solare Base
- **Produzione**: 15 RF/tick durante il giorno
- **Dimensioni**: 1×1 blocco con design inclinato
- **Attivazione**: Automatica con luce solare (livello ≥12)
- **Compatibilità**: Redstone/Mesecons

### Pannello Solare Avanzato
- **Produzione**: 30 RF/tick durante il giorno
- **Dimensioni**: 1×1 blocco con design multipannello
- **Efficienza**: 200% rispetto al pannello base
- **Costo**: Richiede pannelli base + materiali rari

### Batteria Solare
- **Capacità**: 1000 RF
- **Ricarica**: Automatica dai pannelli adiacenti
- **Funzione**: Immagazzina energia per uso futuro
- **GUI**: Mostra livello di carica e stato

### Lampada Solare
- **Illuminazione**: 12 livelli di luce
- **Autonomia**: Fino a 500 RF di capacità
- **Funzione**: Si accende automaticamente di notte
- **Consumo**: 1 RF ogni 3 secondi

## 🔨 Ricette di Crafting

### Pannello Solare Base
```
[Vetro] [Vetro] [Vetro]
[Vetro] [Diamante] [Vetro]
[Ferro] [Ferro] [Ferro]
```

**Alternativa con Redstone:**
```
[Vetro] [Vetro] [Vetro]
[Redstone] [Diamante] [Redstone]
[Ferro] [Ferro] [Ferro]
```

### Pannello Solare Avanzato
```
[Pannello] [Diamante] [Pannello]
[Oro] [Smeraldo] [Oro]
[Ferro] [Redstone] [Ferro]
```

### Batteria Solare
```
[Ferro] [Redstone] [Ferro]
[Redstone] [Oro] [Redstone]
[Ferro] [Redstone] [Ferro]
```

### Lampada Solare
```
[Vuoto] [Vetro] [Vuoto]
[Vetro] [Torcia] [Vetro]
[Vetro] [Redstone] [Vetro]
```

## ⚙️ Come Funziona

### Sistema Giorno/Notte
- **Ore attive**: 6:00 - 18:00 (tempo di gioco)
- **Condizioni**: Esposizione diretta al cielo
- **Livello luce**: Minimo 12 di luce naturale

### Trasmissione Energia
I pannelli trasmettono energia ai **6 blocchi adiacenti**:
- ⬆️ Sopra
- ⬇️ Sotto  
- ➡️ Est
- ⬅️ Ovest
- ⬆️ Nord
- ⬇️ Sud

### Compatibilità Redstone
- I pannelli attivi forniscono segnale redstone
- Compatibile con circuiti mesecons esistenti
- Può alimentare pistoni, porte, e altri dispositivi

## 🔧 API per Sviluppatori

### Registrare un Ricevitore di Energia
```lua
solar_panels.api.register_solar_receiver("mio_mod:macchina", function(pos, power)
    local meta = minetest.get_meta(pos)
    if power > 0 then
        -- Ricevi energia
        local energia = meta:get_int("energia") + power
        meta:set_int("energia", energia)
    end
end)
```

### Verificare Energia Disponibile
```lua
local power = solar_panels.api.get_solar_power_at(pos)
if power > 0 then
    minetest.chat_send_player(player_name, "Energia: " .. power .. " RF/t")
end
```

### Rendere un Nodo Compatibile
```lua
-- Capacità: 500 RF, Consumo: 2 RF/tick
solar_panels.api.make_solar_compatible("mio_mod:dispositivo", 500, 2)
```

### Funzioni API Disponibili
- `register_solar_receiver(nodename, callback)`
- `get_solar_power_at(pos)`
- `is_solar_powered(pos)`
- `get_solar_info(pos)`
- `make_solar_compatible(nodename, capacity, usage)`
- `get_stored_energy(pos)`
- `consume_energy(pos, amount)`

## 🔗 Compatibilità

### Mod Supportate
- ✅ **MineClonia** (tutte le versioni recenti)
- ✅ **Mesecons** (compatibilità redstone)  
- ✅ **Technic** (integrazione automatica se presente)
- ✅ **Pipeworks** (supporto futuro)

### Mod Consigliate
- **Mesecons** - Per circuiti redstone avanzati
- **Technic** - Per reti elettriche complesse
- **WorldEdit** - Per costruzioni su larga scala

## 🚀 Comandi

### Per Amministratori
- `/solar_debug` - Informazioni debug sui pannelli solari
  - Mostra posizione, energia, statistiche globali
  - Richiede privilegio `server`

## 🛠️ Risoluzione Problemi

### Pannello Non Si Attiva
- ✅ Verifica che sia giorno (6:00-18:00)
- ✅ Controlla esposizione al cielo (niente blocchi sopra)
- ✅ Assicurati livello luce ≥12
- ✅ Riavvia il server se necessario

### Energia Non Trasmessa
- ✅ Verifica blocchi adiacenti siano ricevitori validi
- ✅ Controlla che il pannello sia attivo (texture luminosa)
- ✅ Usa `/solar_debug` per diagnostica

### Ricette Non Funzionano
- ✅ Verifica di avere tutti i materiali
- ✅ Controlla che MineClonia sia aggiornato
- ✅ Assicurati che la mod sia attivata

### Prestazioni
- ✅ La mod ottimizza automaticamente (aggiornamenti ogni 2-3 secondi)
- ✅ Pannelli inattivi consumano risorse minime
- ✅ Usa `/solar_debug` per monitorare carico

## 📊 Texture Necessarie

Le seguenti texture devono essere create (16x16 pixel, formato PNG):

### Pannello Base
- `solar_panel_top.png` - Vista dall'alto (blu scuro con griglia)
- `solar_panel_top_on.png` - Come sopra con effetto luminoso
- `solar_panel_bottom.png` - Base metallica grigia
- `solar_panel_side.png` - Lati del pannello
- `solar_panel_front.png` - Fronte con celle solari
- `solar_panel_back.png` - Retro con circuiti

### Pannello Avanzato
- `advanced_solar_panel_top.png` - Design più complesso
- `advanced_solar_panel_top_on.png` - Con effetti luminosi
- (altri file seguono stesso pattern)

### Altri Blocchi
- `solar_battery_top.png` - Batteria vista dall'alto
- `solar_battery_side.png` - Lati della batteria
- `solar_battery_bottom.png` - Base della batteria
- `solar_lamp_off.png` - Lampada spenta
- `solar_lamp_on.png` - Lampada accesa

## 🎨 Consigli per le Texture

### Colori Consigliati
- **Blu pannello**: `#1a237e`, `#3949ab`
- **Grigio metallico**: `#424242`, `#616161`  
- **Bianco riflessi**: `#ffffff`, `#f5f5f5`
- **Nero linee**: `#000000`, `#212121`

### Design
- Celle solari con griglia visibile
- Riflessi metallici agli angoli
- Effetti luminosi per versioni attive
- Dettagli circuitali per retro/lati

## 📄 Licenza

Questa mod è rilasciata sotto licenza MIT. Sei libero di:
- ✅ Usare la mod nei tuoi server
- ✅ Modificare il codice
- ✅ Ridistribuire (con attribuzione)
- ✅ Creare mod derivate

## 🤝 Contributi

I contributi sono benvenuti! Per contribuire:
1. Fai un fork del progetto
2. Crea un branch per la tua feature
3. Testa le modifiche
4. Invia una pull request

### Aree di Miglioramento
- 🎨 Texture più dettagliate
- 🔊 Effetti sonori
- ⚡ Nuovi tipi di pannelli
- 🏭 Integrazione con altri mod
- 🌍 Traduzioni

## 📞 Supporto

Per supporto e bug report:
- 📧 Email: [tuo-email]
- 💬 Discord: [tuo-discord]
- 🐛 Issues: [repository-github]

## 📈 Roadmap

### Versione 1.1
- [ ] Pannelli solari seguitori (tracking)
- [ ] Inverter per AC/DC
- [ ] Cavi per trasporto energia a distanza

### Versione 1.2  
- [ ] Pannelli multiblocco
- [ ] Statistiche avanzate
- [ ] Integrazione weather mod

### Versione 2.0
- [ ] Sistema griglia elettrica
- [ ] Pannelli solari orbitali
- [ ] Energia eolica complementare

---

**Grazie per aver usato Solar Panels Mod!** ⚡🌞

*Versione 1.0 - Creata per Luanti MineClonia*