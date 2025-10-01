#!/bin/bash

# Ange GPIO-nummer direkt
GPIO=48
GPIO_PATH=/sys/class/gpio/gpio$GPIO

# Aktivera GPIO om den inte redan är aktiverad
if [ ! -e $GPIO_PATH ]; then
    echo "$GPIO" > /sys/class/gpio/export
    sleep 0.5
fi

# Sätt GPIO som utgång
echo "out" > $GPIO_PATH/direction

# Slå på eller av reläet beroende på argument
if [ "$1" == "on" ]; then
    echo "1" > $GPIO_PATH/value
    echo "Relä är PÅ (ON)"
elif [ "$1" == "off" ]; then
    echo "0" > $GPIO_PATH/value
    echo "Relä är AV (OFF)"
else
    echo "Användning: $0 on|off"
fi

