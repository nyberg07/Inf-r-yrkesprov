# Relästyrning med BeagleBone Green

Detta projekt visar hur man styr ett 1-kanals relä via en GPIO på BeagleBone Green med ett enkelt Bash-skript. Du kan använda det för att styra enheter som lampor, fläktar eller andra lågspänningslaster.

---

## 🛠️ Hårdvarukrav

- ✅ BeagleBone Green
- ✅ 1-kanals relämodul (5V, med optokopplare – t.ex. SRD-05VDC-SL-C)
- ✅ 4 x jumperkablar (han till hona)  
  - 🔴 Röd – VCC  
  - ⚫ Svart – GND  
  - 🟡 Gul – GPIO-signal  
  - ⚪ Vit – Reserv (kan användas för extra funktion)

---

## 📦 Materiallista

| Komponent         | Antal |
|-------------------|-------|
| BeagleBone Green  | 1     |
| Relämodul (5V)    | 1     |
| Jumperkablar      | 4     |
| Strömkälla (5V)   | 1 (via BBB) |

---

## 🔌 Kopplingar

| BeagleBone Pin | Funktion       | Relämodul Pin | Kabelfärg |
|----------------|----------------|----------------|-----------|
| P9_15 (GPIO 48) | Styrsignal     | IN             | 🟡 Gul    |
| P9_01           | Jord           | GND            | ⚫ Svart  |
| P9_05           | 5V-ström       | VCC            | 🔴 Röd    |
| (Reserv)        | -              | -              | ⚪ Vit    |

> 💡 Notera: Reläet triggas oftast vid LOW-signal (0 V). Det kan innebära att `echo 0 > value` **aktiverar** reläet. Testa båda lägen.

---

## 💻 Bash-skript för att styra relä

Skapa en fil t.ex. `relay_control.sh` och lägg in följande innehåll:

```bash
#!/bin/bash

# Använd GPIO 48 (P9_15)
GPIO=48
GPIO_PATH=/sys/class/gpio/gpio$GPIO

# Exportera GPIO om det inte redan är gjort
if [ ! -e $GPIO_PATH ]; then
    echo "$GPIO" > /sys/class/gpio/export
    sleep 0.5
fi

# Sätt som utgång
echo "out" > $GPIO_PATH/direction

# Styr reläet
if [ "$1" == "on" ]; then
    echo "1" > $GPIO_PATH/value
    echo "Relä är PÅ (ON)"
elif [ "$1" == "off" ]; then
    echo "0" > $GPIO_PATH/value
    echo "Relä är AV (OFF)"
else
    echo "Användning: $0 on|off"
fi
```

### 🔧 Gör skriptet körbart:
```bash
chmod +x relay_control.sh
```

### ▶️ Kör kommandon:

```bash
./relay_control.sh on    # Slår PÅ reläet
./relay_control.sh off   # Slår AV reläet
```
![Optocoupler](https://github.com/user-attachments/assets/99d8077d-35a7-40f7-b9b0-bc482d4e7919)



