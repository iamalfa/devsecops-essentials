#!/bin/bash

LOG_FILE="auth_sample.log"
THRESHOLD=3

if [ ! -f "$LOG_FILE" ]; then
    echo "[!] Error: Target log file '$LOG_FILE' not found."
    exit 1
fi

echo "=========================================="
echo "       SSH THREAT & BRUTE-FORCE DETECTOR  "
echo "=========================================="

TOTAL_FAILED=$(grep -c "Failed password" "$LOG_FILE" || true)
echo "[*] Total Failed Attempts: $TOTAL_FAILED"

echo -e "\n[*] Attackers breakdown (Count | Attacker IP):"

# Parse failed authentication attempts and aggregate source IPs
grep "Failed password" "$LOG_FILE" | awk '{
    for(i=1;i<=NF;i++) {
        if($i=="from") { print $(i+1) }
    }
}' | sort | uniq -c | while read -r COUNT IP; do
    if [ "$COUNT" -ge "$THRESHOLD" ]; then
        echo -e " [ \e[31mBLOCKED\e[0m ] $IP -> $COUNT attempts (Threshold Exceeded)"
    else
        echo -e " [ \e[33mSUSPICIOUS\e[0m ] $IP -> $COUNT attempts"
    fi
done

echo "=========================================="
echo "Scan complete."
