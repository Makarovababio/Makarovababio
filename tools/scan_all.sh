#!/usr/bin/env bash
# scan_all.sh — automatisation nmap découverte + scans
# Usage:
#   ./scan_all.sh <CIDR-ou-IP> [quick|full]

set -euo pipefail
TARGET="${1:-}"
MODE="${2:-quick}"

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <CIDR-or-IP> [quick|full]"
  exit 1
fi

WORKDIR="$HOME/MonGitHub/logs"
mkdir -p "$WORKDIR"

TS=$(date +"%F_%H%M%S")
DISCOVERY_OUT="$WORKDIR/discovery_${TS}.nmap"
DISCOVERY_XML="$WORKDIR/discovery_${TS}.xml"

echo "[+] Découverte des hôtes sur $TARGET..."
nmap -sn -T4 "$TARGET" -oN "$DISCOVERY_OUT" -oX "$DISCOVERY_XML"

HOSTS=$(xmllint --xpath '//host[state/@state="up"]/address/@addr' "$DISCOVERY_XML" 2>/dev/null \
  | sed -E 's/addr="([^"]+)"/\1\n/g' | sed '/^$/d' || true)

if [ -z "$HOSTS" ]; then
  HOSTS=$(grep -Eo 'for [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' "$DISCOVERY_OUT" | awk '{print $2}')
fi

if [ -z "$HOSTS" ]; then
  echo "[!] Aucun hôte détecté."
  exit 0
fi

echo "[+] Hôtes détectés :"
echo "$HOSTS"

for H in $HOSTS; do
  SAFE=$(echo "$H" | tr '.' '-')
  if [ "$MODE" = "full" ]; then
    echo "[*] Scan complet de $H..."
    nmap -sT -Pn -T4 -sV --script=safe -p- "$H" -oN "$WORKDIR/full_${SAFE}_${TS}.nmap" -oX "$WORKDIR/full_${SAFE}_${TS}.xml"
  else
    echo "[*] Scan rapide de $H..."
    nmap -sT -Pn -T4 --top-ports 200 -sV "$H" -oN "$WORKDIR/quick_${SAFE}_${TS}.nmap" -oX "$WORKDIR/quick_${SAFE}_${TS}.xml"
  fi
done

echo "[+] Scans terminés — résultats sauvegardés dans $WORKDIR"
