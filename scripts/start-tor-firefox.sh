#!/data/data/com.termux/files/usr/bin/bash
echo "[+] Vérification du service Tor..."

# Vérifie si le processus Tor est déjà actif
if pgrep tor > /dev/null 2>&1; then
    echo "[+] Tor est déjà actif."
else
    echo "[+] Démarrage du service Tor..."
    tor > ~/tor.log 2>&1 &
    sleep 8
fi

# Vérifie si Tor répond sur le port 9050
if (echo > /dev/tcp/127.0.0.1/9050) >/dev/null 2>&1; then
    echo "[+] Tor écoute bien sur le port 9050."
else
    echo "[!] Erreur : Tor ne semble pas actif ou port 9050 inaccessible."
    exit 1
fi

# Vérifie l’adresse IP publique via Tor
echo "[+] Vérification de l’adresse IP via Tor..."
IP=$(torsocks curl -s https://ifconfig.me 2>/dev/null)
if [ -n "$IP" ]; then
    echo "[✓] Adresse IP Tor : $IP"
else
    echo "[!] Impossible de récupérer l’adresse IP via Tor."
fi

# Instructions Firefox
echo
echo "[✓] Tor est prêt ! Configure Firefox ainsi :"
echo "    → Proxy SOCKS5 : 127.0.0.1"
echo "    → Port : 9050"
echo "    → Coche 'Proxy DNS via SOCKS v5'"
echo "    Puis visite : https://check.torproject.org"

