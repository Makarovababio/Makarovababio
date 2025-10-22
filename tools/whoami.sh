#!/bin/bash
# Makarov Security Toolkit - whoami.sh
# Affiche les infos système et IP publique

echo "=== 🔍 Informations Système ==="
uname -a
echo
echo "=== 🌐 Adresse IP publique ==="
curl -s ifconfig.me || echo "Impossible de récupérer l'IP"
echo
echo "=== 📱 Utilisateur courant ==="
whoami
