#!/bin/bash
echo "============================================="
echo "   SCANNER DE SÉCURITÉ AUTOMATIQUE (NMAP)    "
echo "============================================="
echo "[*] Analyse du réseau local en cours..."

# Scan rapide des ports standards avec détection de version
nmap -sV -F 192.168.1.0/24 > rapport_securite.txt

echo "[+] Scan terminé avec succès !"
echo "[+] Le rapport de sécurité est enregistré dans : rapport_securite.txt"
echo "============================================="
