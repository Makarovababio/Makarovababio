#!/bin/bash
# wifi-info.sh (fallback auto) - Makarov Security Toolkit

echo "=== Makarov wifi-info (auto fallback) ==="
echo

# 1. Test connexion via termux-api
if command -v termux-wifi-connectioninfo >/dev/null 2>&1; then
  echo "-> Connexion Wi-Fi (termux-api):"
  timeout 8s termux-wifi-connectioninfo 2>/dev/null || echo "[!] Pas de réponse (timeout / pas de permission)"
else
  echo "[!] termux-wifi-connectioninfo non disponible."
fi

echo
echo "-> Scan Wi-Fi (termux-api, 12s max):"
if command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  timeout 12s termux-wifi-scaninfo 2>/dev/null | head -n 200 || echo "[!] Pas de réponse (timeout / pas de permission)"
else
  echo "[!] termux-wifi-scaninfo non disponible."
fi

# 2. Fallback via dumpsys (si API bloquée)
echo
echo "-> Lecture via dumpsys wifi (fallback):"
if command -v dumpsys >/dev/null 2>&1; then
  dumpsys wifi | egrep -i 'ssid|bssid|mWifiInfo|ipaddress' | head -n 20
else
  echo "dumpsys non disponible."
fi

# 3. Infos réseau locale
echo
echo "-> Interface réseau:"
ip addr show wlan0 2>/dev/null | head -n 15

echo
echo "=== Fin ==="
