# 🔨 Guida Crafting - Solar Panels Mod

## 📋 Sistema di Energia

### 🌞 **Pannelli Solari**
- Funzionano **solo di giorno** (6:00-18:00)
- Ricaricano **batterie** entro **5 blocchi** di distanza
- Possono alimentare **tappeti solari** per conduzione

### 🔋 **Batterie Solari** 
- Capacità: **10.000 RF**
- Alimentano **dispositivi** entro **10 blocchi** di distanza
- Funzionano **24/7** se hanno energia immagazzinata

### 🟨 **Tappeti Solari**
- Conducono energia solare attraverso **catene adiacenti**
- Di giorno: da **pannelli** a **batterie**
- Di notte: da **batterie** a **dispositivi**

### 💡 **Lampade Solari**
- Si accendono automaticamente **di notte**
- Ricaricate da **batterie** vicine
- Consumo: **2 RF ogni 3 secondi**

---

## 🔨 Ricette di Crafting

### 🌞 Pannello Solare Base
**Output:** 1x Pannello Solare  
**Produzione:** 15 RF/t di giorno

```
[Vetro] [Vetro] [Vetro]
[Vetro] [Diamante] [Vetro]
[Ferro] [Ferro] [Ferro]
```

**Materiali necessari:**
- 5x Vetro (`mcl_core:glass`)
- 1x Diamante (`mcl_core:diamond`)  
- 3x Lingotto di Ferro (`mcl_core:iron_ingot`)

---

### ⚡ Pannello Solare Avanzato
**Output:** 1x Pannello Solare Avanzato  
**Produzione:** 30 RF/t di giorno (doppia efficienza)

```
[Pannello Base] [Diamante] [Pannello Base]
[Oro] [Smeraldo] [Oro]
[Ferro] [Redstone] [Ferro]
```

**Materiali necessari:**
- 2x Pannello Solare Base (`solar_panels:solar_panel_off`)
- 1x Diamante (`mcl_core:diamond`)
- 2x Lingotto d'Oro (`mcl_core:gold_ingot`)
- 1x Smeraldo (`mcl_core:emerald`)
- 1x Lingotto di Ferro (`mcl_core:iron_ingot`)
- 1x Polvere di Redstone (`mcl_core:redstone`)

---

### 🔋 Batteria Solare
**Output:** 1x Batteria Solare  
**Capacità:** 10.000 RF

```
[Ferro] [Redstone] [Ferro]
[Redstone] [Oro] [Redstone]
[Ferro] [Redstone] [Ferro]
```

**Materiali necessari:**
- 4x Lingotto di Ferro (`mcl_core:iron_ingot`)
- 4x Polvere di Redstone (`mcl_core:redstone`)
- 1x Lingotto d'Oro (`mcl_core:gold_ingot`)

---

### 🟨 Tappeto Solare
**Output:** 4x Tappeto Solare  
**Funzione:** Conduce energia solare

```
[Vetro] [Vetro] [Vetro]
[Redstone] [Ferro] [Redstone]
[Vuoto] [Vuoto] [Vuoto]
```

**Materiali necessari:**
- 3x Vetro (`mcl_core:glass`)
- 2x Polvere di Redstone (`mcl_core:redstone`)
- 1x Lingotto di Ferro (`mcl_core:iron_ingot`)

---

### 💡 Lampada Solare
**Output:** 1x Lampada Solare  
**Illuminazione:** 14 livelli di luce

```
[Vuoto] [Vetro] [Vuoto]
[Vetro] [Torcia] [Vetro]
[Vetro] [Redstone] [Vetro]
```

**Materiali necessari:**
- 4x Vetro (`mcl_core:glass`)
- 1x Torcia (`mcl_torches:torch`)
- 1x Polvere di Redstone (`mcl_core:redstone`)

---

## ⚙️ Come Funziona il Sistema

### 🔄 Flusso di Energia

```
☀️ GIORNO:
Pannelli Solari → Batterie (5 blocchi)
Pannelli Solari → Tappeti Solari → Batterie

🌙 NOTTE:
Batterie → Lampade/Dispositivi (10 blocchi)
Batterie → Tappeti Solari → Dispositivi
```

### 🟨 Sistema Tappeti a Catena

1. **Tappeto alimentato** da batteria o pannello
2. **Tutti i tappeti adiacenti** diventano alimentati
3. **Catena si propaga** attraverso tappeti connessi
4. Ogni tappeto alimentato può **dare energia** ai dispositivi adiacenti

### 📐 Range di Funzionamento

- **Pannelli → Batterie:** 5 blocchi di raggio
- **Batterie → Dispositivi:** 10 blocchi di raggio  
- **Tappeti:** Solo blocchi direttamente adiacenti

---

## 💡 Consigli di Utilizzo

### 🏗️ **Setup Base**
1. Piazza **pannelli solari esposti al cielo**
2. Posiziona **batterie** entro 5 blocchi dai pannelli
3. Colloca **lampade** entro 10 blocchi dalle batterie

### 🔌 **Setup Avanzato con Tappeti**
1. Usa **tappeti solari** per collegare aree distanti
2. Crea **catene di tappeti** per trasportare energia
3. Posiziona dispositivi **adiacenti ai tappeti** alimentati

### ⚡ **Ottimizzazione Energia**
- **1 Pannello Base** ricarica fino a **500 RF/minuto** di giorno
- **1 Pannello Avanzato** ricarica fino a **1.000 RF/minuto** di giorno
- **1 Batteria** può alimentare **multiple lampade** per ore

### 🌙 **Autonomia Notturna**
- **Batteria piena (10.000 RF)** = ~8 ore di autonomia per 1 lampada
- **Multiple batterie** = autonomia estesa
- **Tappeti** = distribuzione efficiente senza perdite

---

## 🛠️ Risoluzione Problemi

### ❌ **Pannello non ricarica batterie**
- ✅ Verifica sia **giorno** (6:00-18:00)
- ✅ Controlla **esposizione al cielo** (luce ≥12)
- ✅ Batteria deve essere entro **5 blocchi**

### ❌ **Batteria non alimenta dispositivi**
- ✅ Dispositivi devono essere entro **10 blocchi**
- ✅ Verifica che la batteria abbia **energia stored**
- ✅ Usa `/solar_debug` per diagnostica

### ❌ **Tappeti non conducono energia**
- ✅ Almeno un tappeto deve essere **vicino a fonte energia**
- ✅ Tappeti devono essere **direttamente adiacenti**
- ✅ Controlla con **click destro** su tappeto per stato

### ❌ **Lampade non si accendono**
- ✅ Deve essere **notte** (18:00-6:00)
- ✅ Lampada deve avere **energia stored**
- ✅ Batterie vicine devono essere **entro 10 blocchi**

---

## 📊 Statistiche Tecniche

| Dispositivo | Produzione/Consumo | Range | Capacità |
|-------------|-------------------|-------|----------|
| Pannello Base | 15 RF/t (giorno) | 5 blocchi | - |
| Pannello Avanzato | 30 RF/t (giorno) | 5 blocchi | - |
| Batteria | - | 10 blocchi | 10.000 RF |
| Tappeto | Conduzione | 1 blocco | - |
| Lampada | 2 RF/3s (notte) | - | 500 RF |

---

## 🎮 Comandi Utili

- `/solar_debug` - Informazioni complete sistema
- `/solar_cleanup` - Pulizia pannelli orfani  
- `/solar_update` - Forza aggiornamento dispositivi

---

**La tua rete di energia solare è pronta! ☀️⚡**

*Costruisci smart, risparmia energia, illumina la notte!*