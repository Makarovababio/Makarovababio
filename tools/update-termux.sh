#!/bin/bash
# Makarov Security Toolkit - update-termux.sh
# Met à jour Termux et ses paquets proprement

echo "🚀 Mise à jour du système..."
pkg update -y && pkg upgrade -y
echo "📦 Nettoyage..."
pkg autoclean
echo "✅ Terminé !"
