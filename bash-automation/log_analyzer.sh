#!/bin/bash

LOG_FILE="auth_sample.log"
THRESHOLD=3

if [ ! -f "$LOG_FILE" ]; then
    echo "[!] Error: Log file '$LOG_FILE' nahi mili!"
    exit 1
fi

echo "=========================================="
echo "       SSH THREAT & BRUTE-FORCE DETECTOR  "
echo "=========================================="

# 1. Total failed attempts count
TOTAL_FAILED=$(grep -c "Failed password" "$LOG_FILE" || true)
echo "[*] Total Failed Attempts: $TOTAL_FAILED"

echo -e "\n[*] Attackers breakdown (Count | Attacker IP):"

# grep se failed lines nikalenge
# awk se 'from' ke baad wala field (IP address) capture karenge
# sort aur uniq -c se count karenge
ALERT=0

grep "Failed password" "$LOG_FILE" | awk '{
    for(i=1;i<=NF;i++) {
        if($i=="from") { print $(i+1) }
    }
}' | sort | uniq -c | while read -r COUNT IP; do
    if [ "$COUNT" -ge "$THRESHOLD" ]; then
        echo -e " [ \e[31mBLOCKED\e[0m ] $IP -> $COUNT attempts (THRESHOLD EXCEEDED!)"
        ALERT=1
    else
        echo -e " [ \e[33mSUSPICIOUS\e[0m ] $IP -> $COUNT attempts"
    fi
done

echo "=========================================="
echo "Scan complete."
