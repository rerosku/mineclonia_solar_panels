# 🧪 Guida Test Completa - Solar Panels Mod

## 🔧 **CORREZIONI APPLICATE**

### **File da Sostituire (2 file principali):**
1. ✅ **`energy_system.lua`** → Versione finale con dialog aggiornati
2. ✅ **`nodes.lua`** → Versione finale con callback corretti

## 📋 **Test Immediati Post-Installazione**

### **1. Verifica Caricamento Mod**
```bash
# Nel log di Luanti, cerca questi messaggi:
[Solar Panels] 🌞 Sistema energetico FINALE inizializzato correttamente
[Solar Panels] 🏗️ Definizioni nodi caricate con dialog aggiornati in tempo reale
[Solar Panels] ✅ MOD COMPLETAMENTE FUNZIONANTE!
```

### **2. Test Comando Debug**
```bash
/solar_debug
```
**Risultato atteso:**
```
🌞 === DEBUG PANNELLI SOLARI === 🌞
📍 Posizione: (123, 65, 456)
🕐 Ora: 0.50 (12.0:00)
☀️ È giorno: ✅ SÌ
💡 Luce naturale: 15/15
📊 === STATISTICHE PANNELLI ===
🔢 Pannelli registrati: 0 (normale all'inizio)
✅ Sistema attivo: SÌ
✅ API disponibile: SÌ
✅ Funzioni caricate: SÌ
```

## 🧪 **Test Funzionalità Step-by-Step**

### **Test 1: Pannello Solare Base**
1. **Piazza pannello** esposto al cielo
2. **Clicca destro** immediatamente - dovrebbe mostrare:
   ```
   🌞 Pannello Solare
   Stato: 🔄 Inizializzazione...
   ```
3. **Aspetta 2-3 secondi** poi clicca di nuovo:
   - Di giorno: `Stato: 🟢 ATTIVO` + `Produzione: 15 RF/t`
   - Di notte: `Stato: 🔴 INATTIVO` + `Produzione: 0 RF/t`

### **Test 2: Batteria Solare + Ricarica**
1. **Piazza batteria** accanto al pannello attivo
2. **Clicca destro sulla batteria**:
   ```
   🔋 Batteria Solare
   Stato: 🔋 RICARICA IN CORSO (se vicino a pannello attivo)
   Energia: 0/1000 RF (0%) ← dovrebbe aumentare!
   Ricarica: 15 RF/t ← deve essere > 0
   ```
3. **Aspetta 10 secondi** e riclicca:
   - Energia dovrebbe essere aumentata (~150 RF)

### **Test 3: Lampada Solare**
1. **Piazza lampada** accanto al pannello attivo (giorno)
2. **Verifica ricarica** (clicca destro):
   ```
   💡 Lampada Solare Sferica
   Stato: ⚡ STANDBY o 🔋 RICARICA IN CORSO
   Energia: [aumenta progressivamente]/500 RF
   Ricarica: 15 RF/t ← deve essere > 0
   ```
3. **Cambia in modalità notte** (`/time 23000`)
4. **Aspetta 5 secondi** - la lampada dovrebbe:
   - ✅ Cambiare texture (più luminosa)
   - ✅ Emettere luce (livello 14)
   - ✅ Dialog mostra: `Stato: 💡 ACCESA`

### **Test 4: Pannello Avanzato**
1. **Piazza pannello avanzato**
2. **Verifica produzione doppia**:
   ```
   ⚡ Pannello Solare Avanzato
   Stato: 🟢 ATTIVO
   Produzione: 30 RF/t ← doppia!
   ```

## 📊 **Test di Integrazione Completa**

### **Setup Completo:**
```
   [P] = Pannello Solare
   [B] = Batteria 
   [L] = Lampada
   
   Layout consigliato:
   
     [L]
   [B][P][B]  
     [L]
```

### **Comportamento Atteso:**

#### **Durante il Giorno (6:00-18:00):**
- ✅ Pannello: `🟢 ATTIVO` + texture luminosa
- ✅ Batterie: `🔋 RICARICA IN CORSO` + energia aumenta
- ✅ Lampade: `⚡ STANDBY` + si ricaricano + spente

#### **Durante la Notte (18:00-6:00):**
- ❌ Pannello: `🔴 INATTIVO` + texture normale
- ⚡ Batterie: `⚡ STANDBY` + energia ferma
- ✅ Lampade: `💡 ACCESA` + luminose + consumano energia

## 🔍 **Troubleshooting**

### **Problema: "Dialog non si aggiornano"**
**Soluzione:**
```bash
/solar_update  # Forza aggiornamento tutto
```

### **Problema: "Batteria non si ricarica"**
**Verifica:**
1. Batteria è adiacente al pannello? ✅
2. Pannello è attivo? ✅ (texture luminosa)
3. È giorno? ✅ (`/time 12000`)
4. Clicca destro su batteria → `Ricarica: 15 RF/t` deve essere > 0

### **Problema: "Lampada non si accende"**
**Verifica:**
1. Lampada ha energia? ✅ (>0 RF)
2. È notte? ✅ (`/time 23000`)  
3. Aspetta 5-10 secondi per il ciclo automatico

### **Problema: "Pannello dice sempre inattivo"**
**Soluzione:**
1. Verifica esposizione al cielo (niente blocchi sopra)
2. Usa `/solar_update` per forzare
3. Clicca destro per aggiornare dialog

## 📋 **Checklist Funzionamento Completo**

### **Pannelli Solari:**
- [ ] Si attivano di giorno (texture cambia)
- [ ] Dialog mostra stato corretto in tempo reale
- [ ] Producono energia corretta (15/30 RF/t)
- [ ] Livello luce e ora mostrati correttamente

### **Batterie:**
- [ ] Ricevono energia dai pannelli adiacenti
- [ ] Dialog mostra ricarica in corso
- [ ] Energia aumenta progressivamente
- [ ] Percentuale calcolata correttamente

### **Lampade:**
- [ ] Si ricaricano di giorno dai pannelli
- [ ] Si accendono automaticamente di notte
- [ ] Texture e luce cambiano quando accese
- [ ] Consumano energia quando accese
- [ ] Dialog mostra stato corretto

### **Sistema Globale:**
- [ ] Comandi debug funzionano
- [ ] Log mostra operazioni
- [ ] Nessun errore nel log
- [ ] Prestazioni buone (no lag)

## 🎯 **Test di Stress**

### **Test Performance:**
1. Piazza 20+ pannelli solari
2. Aggiungi 10+ batterie e lampade
3. Controlla che non ci sia lag
4. Usa `/solar_debug` per statistiche

### **Test Persistenza:**
1. Salva e ricarica il mondo
2. Verifica che tutto funzioni ancora
3. Controlla che i dati siano conservati

### **Test Edge Cases:**
1. Pannello sotto terra (non dovrebbe funzionare)
2. Dispositivi non adiacenti (no energia)
3. Distruzione pannello → energia si ferma

## 📝 **Report Risultati**

Dopo aver completato i test, riporta:

```markdown
✅ FUNZIONANTE:
- [x] Pannelli si attivano/disattivano
- [x] Dialog si aggiornano in tempo reale  
- [x] Batterie si ricaricano
- [x] Lampade si accendono di notte
- [x] Sistema energy transfer

❌ PROBLEMI:
- [ ] [Descrivi eventuali problemi]

📊 STATISTICHE:
- Pannelli testati: X
- Batterie testate: X  
- Lampade testate: X
- Tempo di risposta: X secondi
```

## 🚀 **Prossimi Passi se Tutto Funziona**

1. **Crea texture personalizzate** usando i prompt AI
2. **Testa in multiplayer** 
3. **Espandi con nuovi dispositivi**
4. **Ottimizza performance** per grandi installazioni
5. **Integra con altri mod**

---

**Se tutti i test passano, la mod è completamente funzionante! 🌞⚡**