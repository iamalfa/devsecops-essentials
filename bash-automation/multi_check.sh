#!/bin/bash

# Array of services jo hum check karna chahte hain
SERVICES=("NetworkManager" "ssh" "docker" "cron" "apache2")

echo "=========================================="
echo "      MULTI-SERVICE STATUS AUDIT          "
echo "=========================================="

FAILED_COUNT=0

for SVC in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SVC"; then
        echo -e "[ \e[32mPASS\e[0m ] Service '$SVC' running hai."
    else
        echo -e "[ \e[31mFAIL\e[0m ] Service '$SVC' band ya missing hai!"
        # Har failure par counter ko 1 barhao
        ((FAILED_COUNT++))
    fi
done

echo "=========================================="
echo "Total failed services: $FAILED_COUNT"

# Agar ek bhi service fail hui, pipeline ko block karne ke liye exit 1 do
if [ "$FAILED_COUNT" -gt 0 ]; then
    echo "[!] Action required: Kuch critical services down hain!"
    exit 1
else
    echo "[+] System fully functional hai!"
    exit 0
fi
