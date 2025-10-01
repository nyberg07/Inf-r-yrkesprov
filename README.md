# Grove-Moisture-Sensor
Moisture sensor

Grove Moisture Sensor + BeagleBone Green (Analog via AIN0)

Anslutning: (Högra vita porten)
- Signal → P9_39 (AIN0)
- VCC → 3.3V
- GND → GND

Aktivera ADC:
1. Öppna uEnv.txt:
   sudo nano /boot/uEnv.txt

2. Avkommentera och ändra:
   enable_uboot_overlays=1
   uboot_overlay_addr4=/lib/firmware/BB-ADC-00A0.dtbo

3. Spara och starta om:
   sudo reboot

Verifiera ADC:
1. Kolla ADC-enhet:
   ls /sys/bus/iio/devices/

2. Lista kanaler:
   ls /sys/bus/iio/devices/iio:device0/

3. Läs från AIN0 (P9_39):
   cat /sys/bus/iio/devices/iio:device0/in_voltage0_raw

Python-skript:
Skapa:
   nano read_moisture.py

Innehåll:
-----------------------------------
#!/usr/bin/env python3
import time

def read_adc(channel=0):
    with open(f"/sys/bus/iio/devices/iio:device0/in_voltage{channel}_raw") as f:
        return int(f.read().strip())

while True:
    value = read_adc(0)
    if value < 1300:
        state = "Torr"
    elif value < 2700:
        state = "Fuktig"
    else:
        state = "Våt"
    print(f"Fuktvärde: {value} ({state})")
    time.sleep(1)

-----------------------------------

Kör:
   python3 read_moisture.py

Tolkning av värden:
- 0–1300   = Torr
- 1300–2700 = Fuktig
- 2700–4095 = Våt
________________________________________________________________________________
https://wiki.seeedstudio.com/Grove-Moisture_Sensor/ 
![Grove Moisture Sensor kopplings schema](https://github.com/user-attachments/assets/373ecf7c-c524-4c70-a028-56902ea9bd4e)

