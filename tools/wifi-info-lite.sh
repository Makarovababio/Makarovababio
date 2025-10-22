#!/bin/bash
# wifi-info-lite.sh — version simplifiée pour Termux non-root
# Auteur : Makarov Security

echo "=== Makarov wifi-info (lite mode) ==="

# IP et interface
echo
echo "-> Interface réseau :"
ip addr show wlan0 | sed 's/^/   /'

# Route / passerelle
echo
echo "-> Table de routage :"
ip route show | sed 's/^/   /'

# Routeur détecté
router=$(ip neigh | grep -i "router" | awk '{print $1, $5}' | head -n 1)
if [ -n "$router" ]; then
    echo
    echo "-> Routeur détecté :"
    echo "   $router"
else
    echo
    echo "-> Aucun routeur détecté via ARP"
fi

# Scan rapide du réseau (ping des 10 premières IP)
echo
echo "-> Scan rapide du réseau local (ping):"
myip=$(ip -4 addr show wlan0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
base=$(echo "$myip" | cut -d. -f1-3)
for i in $(seq 1 10); do
    target="$base.$i"
    ping -c 1 -W 1 $target &>/dev/null && echo "   [+] $target actif"
done

echo
echo "=== Fin du scan ==="
