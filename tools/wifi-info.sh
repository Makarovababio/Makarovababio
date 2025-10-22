#!/bin/bash
# Makarov Security Toolkit - wifi-info.sh
# Récupère des informations utiles sur le Wi-Fi et les réseaux à portée.
# Utilise termux-api si disponible, sinon méthode de secours avec ip/iw.

set -e

echo "=== Makarov wifi-info ==="
echo

# Info termux-api si dispo
if command -v termux-wifi-connectioninfo >/dev/null 2>&1; then
  echo "-> Info connexion Wi-Fi (termux-api)"
  termux-wifi-connectioninfo
  echo
fi

# Scan réseaux (termux-api)
if command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "-> Scan Wi-Fi à portée (termux-api) — quelques SSID trouvés :"
  termux-wifi-scaninfo | head -n 20
  echo
else
  echo "termux-wifi-scaninfo non dispo. Utilise iw/ip si présent."
fi

# Info interface (fallback)
if command -v ip >/dev/null 2>&1; then
  echo "-> Info interface réseau (ip addr show)"
  ip addr show wlan0 || ip addr
  echo
fi

if command -v iw >/dev/null 2>&1; then
  echo "-> Capabilités iw (iw dev / iw wlan0 info)"
  iw dev 2>/dev/null || true
  echo
fi

echo "=== Fin ==="
