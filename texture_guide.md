# 🎨 Guida alla Creazione delle Texture

Questa guida ti aiuterà a creare le texture per la mod Solar Panels con un aspetto professionale e realistico.

## 📋 Lista Texture Necessarie

### Pannello Solare Base (6 texture)
- `solar_panel_top.png` - Vista dall'alto (principale)
- `solar_panel_top_on.png` - Vista dall'alto quando attivo
- `solar_panel_bottom.png` - Base/supporto inferiore
- `solar_panel_side.png` - Lati del pannello
- `solar_panel_front.png` - Fronte con celle solari dettagliate
- `solar_panel_back.png` - Retro con circuiti elettronici

### Pannello Solare Avanzato (6 texture)
- `advanced_solar_panel_top.png` - Versione più complessa
- `advanced_solar_panel_top_on.png` - Con effetti luminosi intensi
- `advanced_solar_panel_bottom.png` - Base rinforzata
- `advanced_solar_panel_side.png` - Lati con dettagli extra
- `advanced_solar_panel_front.png` - Celle multiple e avanzate
- `advanced_solar_panel_back.png` - Circuiti avanzati

### Batteria Solare (3 texture)
- `solar_battery_top.png` - Coperchio con indicatori
- `solar_battery_bottom.png` - Base della batteria
- `solar_battery_side.png` - Lati con dettagli tecnici

### Lampada Solare (2 texture)
- `solar_lamp_off.png` - Lampada spenta
- `solar_lamp_on.png` - Lampada accesa con bagliore

## 🎨 Specifiche Tecniche

### Formato
- **Dimensioni**: 16×16 pixel (standard Luanti)
- **Formato**: PNG con trasparenza
- **Profondità colore**: 32-bit RGBA
- **Compressione**: PNG ottimizzata

### Palette Colori

#### Pannelli Solari
```
Blu Principale:    #1a237e (26, 35, 126)
Blu Secondario:    #3949ab (57, 73, 171)
Blu Chiaro:        #5c6bc0 (92, 107, 192)
Azzurro Riflessi:  #81c784 (129, 199, 132)
```

#### Metalli
```
Grigio Scuro:      #424242 (66, 66, 66)
Grigio Medio:      #616161 (97, 97, 97)  
Grigio Chiaro:     #9e9e9e (158, 158, 158)
Argento:           #c0c0c0 (192, 192, 192)
```

#### Effetti Luminosi
```
Bianco Puro:       #ffffff (255, 255, 255)
Bianco Caldo:      #f5f5f5 (245, 245, 245)
Giallo Energia:    #ffeb3b (255, 235, 59)
Ciano Elettrico:   #00bcd4 (0, 188, 212)
```

#### Circuiti
```
Verde Circuito:    #4caf50 (76, 175, 80)
Rosso Circuito:    #f44336 (244, 67, 54)
Oro Connettori:    #ffc107 (255, 193, 7)
Nero Linee:        #000000 (0, 0, 0)
```

## 🖌️ Design Guidelines

### Pannello Solare Base

#### `solar_panel_top.png`
```
Design Elements:
┌─────────────────┐
│ ████████████████ │ <- Griglia celle solari (3×3 o 4×4)
│ █▓▓█▓▓█▓▓█▓▓█▓▓ │ <- Alternanza blu scuro/chiaro
│ ▓▓█▓▓█▓▓█▓▓█▓▓█ │ <- Pattern a scacchiera
│ █▓▓█▓▓█▓▓█▓▓█▓▓ │
│ ▓▓█▓▓█▓▓█▓▓█▓▓█ │
│ █▓▓█▓▓█▓▓█▓▓█▓▓ │
│ ████████████████ │ <- Bordo metallico
└─────────────────┘

Colori:
█ = #1a237e (blu scuro)
▓ = #3949ab (blu medio)
Bordo = #616161 (grigio)
```

#### `solar_panel_top_on.png`
- Stesso design di base
- Aggiungi pixel bianchi sparsi (#ffffff) per simulare riflessi
- Bordo luminoso ciano (#00bcd4) di 1 pixel
- Piccoli bagliori negli angoli

#### `solar_panel_bottom.png`
```
┌─────────────────┐
│■■■■■■■■■■■■■■■■│ <- Struttura metallica
│■▓▓▓▓▓▓▓▓▓▓▓▓▓■│ <- Base di supporto
│■▓░░░░░░░░░░░░▓■│ <- Area interna
│■▓░▓▓▓▓▓▓▓▓░▓■│ <- Rinforzi strutturali
│■▓░▓░░░░░░▓░▓■│
│■▓░▓░░░░░░▓░▓■│
│■▓░▓▓▓▓▓▓▓▓░▓■│
│■▓░░░░░░░░░░░░▓■│
│■▓▓▓▓▓▓▓▓▓▓▓▓▓■│
│■■■■■■■■■■■■■■■■│

Colori:
■ = #424242 (grigio scuro)
▓ = #616161 (grigio medio)
░ = #9e9e9e (grigio chiaro)
```

### Pannello Avanzato

#### `advanced_solar_panel_top.png`
- Design più complesso con 4 sezioni
- Celle solari più piccole e dettagliate
- Connettori oro tra le sezioni
- Bordi più spessi

#### `advanced_solar_panel_top_on.png`
- Effetti luminosi più intensi
- Bagliore multi-colore (bianco + ciano + giallo)
- Animazione pixel simulata con variazioni

### Batteria Solare

#### `solar_battery_top.png`
```
┌─────────────────┐
│■■■■■■■■■■■■■■■■│
│■▓▓▓▓▓▓▓▓▓▓▓▓▓■│
│■▓░██████████░▓■│ <- Indicatori livello
│■▓░█▓▓▓▓▓▓▓█░▓■│
│■▓░█▓████▓█░▓■│ <- Display energia
│■▓░█▓████▓█░▓■│
│■▓░█▓▓▓▓▓▓▓█░▓■│
│■▓░██████████░▓■│
│■▓▓▓▓▓▓▓▓▓▓▓▓▓■│
│■■■■■■■■■■■■■■■■│
└─────────────────┘

Colori:
■ = #424242 (grigio scuro)
▓ = #616161 (grigio medio)
░ = #9e9e9e (grigio chiaro)
█ = #000000 (nero display)
```

### Lampada Solare

#### `solar_lamp_off.png`
```
┌─────────────────┐
│    ░░░░░░░░    │ <- Vetro trasparente
│  ░░▓▓▓▓▓▓▓░░  │
│ ░▓▓▓████▓▓▓░ │ <- Elemento luminoso spento
│░▓▓███▓▓███▓▓░│
│░▓██▓▓▓▓▓▓██▓░│
│░▓██▓▓▓▓▓▓██▓░│
│░▓▓███▓▓███▓▓░│
│ ░▓▓▓████▓▓▓░ │
│  ░░▓▓▓▓▓▓▓░░  │
│    ░░░░░░░░    │
│■■■■■■■■■■■■■■■■│ <- Base metallica
└─────────────────┘

Colori:
░ = #f5f5f5 (vetro)
▓ = #9e9e9e (struttura)
█ = #424242 (elemento spento)
■ = #616161 (base)
```

#### `solar_lamp_on.png`
- Stesso design base
- Elemento centrale giallo brillante (#ffeb3b)
- Bagliore bianco attorno (#ffffff)
- Effetto alone sui bordi del vetro

## 🛠️ Tools Consigliati

### Software Gratuiti
- **GIMP** - Completo e potente
- **Paint.NET** - Semplice per Windows
- **Krita** - Ottimo per arte digitale
- **Pixelorama** - Specializzato in pixel art

### Software a Pagamento
- **Aseprite** - Il migliore per pixel art
- **Photoshop** - Professionale
- **Pixelmator Pro** - Ottimo per Mac

### Risorse Online
- **Lospec Palette List** - Palette di colori
- **Piskel** - Editor online gratuito
- **Pixel Art Tutorials** - Guide e tutorial

## 📐 Processo di Creazione

### 1. Setup Iniziale
- Crea nuovo documento 16×16 pixel
- Imposta griglia 1×1 pixel visibile
- Usa zoom 400-800% per dettagli
- Salva in formato PNG

### 2. Base Colors
- Inizia con colori base solidi
- Crea forme principali
- Non aggiungere dettagli subito

### 3. Dettagli
- Aggiungi pattern e texture
- Usa dithering per gradienti
- Aggiungi highlights e ombre

### 4. Rifinitura
- Controlla coerenza colori
- Verifica contrasto
- Testa in-game se possibile

### 5. Ottimizzazione
- Riduci palette se necessario
- Ottimizza compressione PNG
- Verifica dimensioni file

## ✅ Checklist Qualità

### Prima del rilascio:
- [ ] Tutte le texture sono 16×16 pixel
- [ ] Formato PNG con trasparenza corretta
- [ ] Nomi file corrispondono al codice
- [ ] Colori coerenti tra texture correlate
- [ ] Contrasto sufficiente per visibilità
- [ ] Dettagli visibili anche a distanza
- [ ] Stile uniforme con MineClonia
- [ ] Test in-game completato

### Test Visivi:
- [ ] Texture caricano correttamente
- [ ] Nessun artifatto o glitch
- [ ] Transizioni on/off funzionano
- [ ] Orientamento corretto su tutti i lati
- [ ] Effetti luminosi visibili
- [ ] Compatibilità con shader pack

## 🎯 Tips Avanzati

### Coerenza Stilistica
- Mantieni stesso spessore linee (1 pixel)
- Usa stessa intensità ombre/highlights
- Rispetta palette colori definita
- Considera lighting di MineClonia

### Ottimizzazione Performance  
- Evita troppi colori unici
- Usa pattern ripetitivi quando possibile
- Minima complessità per texture laterali
- Focus dettagli su facce principali

### Accessibilità
- Contrasto minimo 3:1 per elementi importanti
- Evita solo differenze di colore per informazioni
- Test con filtri daltonismo
- Usa forme distintive oltre ai colori

---

**Buona creazione!** 🎨✨

*Con queste texture la tua mod avrà un aspetto professionale e si integrerà perfettamente con MineClonia.*