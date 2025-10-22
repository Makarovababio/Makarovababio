#!/bin/bash
# Makarov Security Toolkit - extract-ip.sh
# Récupère IP publique et info géolocalisation (via ipinfo.io ou ifconfig.me)
# Usage: ./extract-ip.sh [--json] [--raw]

JSON_OUTPUT=0
RAW=0
if [ "$1" = "--json" ]; then JSON_OUTPUT=1; fi
if [ "$1" = "--raw" ]; then RAW=1; fi

echo "=== Makarov extract-ip ==="

# IP publique brute
IP=""
if command -v curl >/dev/null 2>&1; then
  IP=$(curl -s https://ifconfig.me)
fi

if [ -z "$IP" ]; then
  echo "Impossible de récupérer l'IP publique (curl manquant ou réseau)."
  exit 1
fi

if [ "$RAW" -eq 1 ]; then
  echo "$IP"
  exit 0
fi

echo "IP publique : $IP"

# info détaillée
if [ "$JSON_OUTPUT" -eq 1 ]; then
  if command -v curl >/dev/null 2>&1; then
    curl -s https://ipinfo.io/$IP/json
  else
    echo "curl manquant, impossible d'afficher JSON."
  fi
  exit 0
fi

# résumé lisible (ipinfo)
if command -v curl >/dev/null 2>&1; then
  echo
  echo "-> Info géolocalisation (ipinfo.io) :"
  curl -s https://ipinfo.io/$IP/json | \
    python -c "import sys, json as j; d=j.load(sys.stdin); print('IP: %(ip)s\\nPays: %(country)s\\nRegion: %(region)s\\nVille: %(city)s\\nOrg: %(org)s\\nLoc: %(loc)s' % d)"
fi

echo "=== Fin ==="
