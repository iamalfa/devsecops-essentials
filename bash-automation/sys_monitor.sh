#!/bin/bash

# Safe mode: Error aaye toh script wahin ruk jaye
set -e

echo "=========================================="
echo "          SYSTEM HEALTH MONITOR           "
echo "=========================================="

# Current Date & Time
echo -e "\n[+] Current Time: $(date)"

# System Uptime
echo -e "\n[+] System Uptime:"
uptime -p

# Free RAM Check
echo -e "\n[+] Memory Usage:"
free -h | awk 'NR==1 || NR==2'

# Disk Usage (Root partition)
echo -e "\n[+] Disk Space Usage:"
df -h / | awk 'NR==1 || NR==2'

echo "=========================================="
echo "Health check complete!"
