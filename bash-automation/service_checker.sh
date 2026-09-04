#!/bin/bash

# $1 ka matlab hai pehla argument jo script ko terminal se milega
SERVICE_NAME=$1

# Validation: Agar user ne service name provide hi nahi kiya
if [ -z "$SERVICE_NAME" ]; then
    echo "[!] Error: Service ka naam pass karna lazmi hai!"
    echo "Usage: $0 <service_name>"
    exit 1
fi

echo "[*] Checking status for service: $SERVICE_NAME..."

# systemctl se service check karein (output ko hide karne ke liye /dev/null bheja hai)
if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "[+] SUCCESS: Service '$SERVICE_NAME' active aur running hai!"
    exit 0
else
    echo "[-] WARNING: Service '$SERVICE_NAME' band (inactive) hai ya exist nahi karti!"
    exit 2
fi
