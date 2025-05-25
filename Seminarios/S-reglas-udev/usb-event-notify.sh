#!/bin/bash
DEVICE_PATH="$1"
ACTION="$2"
#Registramos el evento con fecha
echo "$(date '+%F %T') - USB $ACTION on $DEVICE_PATH" >> /var/log/usb-monitor.log
