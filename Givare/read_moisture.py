#!/usr/bin/env python3
import time

def read_adc(channel=0):
    path = f"/sys/bus/iio/devices/iio:device0/in_voltage{channel}_raw"
    try:
        with open(path, 'r') as f:
            value = int(f.read().strip())
        return value
    except FileNotFoundError:
        print(f"ADC-kanal {channel} hittades inte.")
        return None

def main():
    print("Mäter fuktighet på AIN0 (P9_39)...")
    while True:
        value = read_adc(0)
        if value is not None:
            if value < 1300:
                state = "Torr"
            elif value < 2700:
                state = "Fuktig"
            else:
                state = "Våt"
            print(f"Fuktvärde: {value} ({state})")
        else:
            print("Läsfel!")
        time.sleep(1)

if __name__ == "__main__":
    main()

