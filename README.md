<p align="center">
  <img src="https://github.com/Makarovababio/Makarovababio/blob/main/logo.png" alt="Makarov Security" width="200"/>
</p>
# Makarov Security Toolkit
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Made for Termux](https://img.shields.io/badge/Platform-Termux-blue.svg)](https://termux.dev/)
[![GitHub Repo](https://img.shields.io/badge/GitHub-Makarovababio%2FMakarovababio-black.svg?logo=github)](https://github.com/Makarovababio/Makarovababio)
[![Build Status](https://img.shields.io/badge/Build-passing-success.svg)]()
[![Version](https://img.shields.io/badge/Version-1.0.0-orange.svg)]()
[![Maintained](https://img.shields.io/badge/Maintained-yes-brightgreen.svg)]()
[![Makarov Security](https://img.shields.io/badge/Makarov-Security-critical.svg)]()

> ⚔️ Pack d'outils **Termux / scripts d'audit** — collection personnelle de **Makarov**  
> Léger, portable et conçu pour les tests légaux, la cybersécurité et l'apprentissage.

---

## ⚡ Présentation

**Makarov Security Toolkit** regroupe une série de scripts et utilitaires destinés à faciliter des opérations :
- d’audit et de test de pénétration (pentesting),
- d’anonymisation réseau,
- d’automatisation sous Termux (Android).

Ce dépôt contient uniquement des **scripts et instructions** — il **n’inclut pas** de fichiers lourds ou sensibles.

---

## 📦 Contenu principal

| Dossier / Script | Description |
|------------------|-------------|
| `scripts/install-nethunter-termux` | Installe Kali NetHunter (version légère pour Termux) |
| `scripts/metasploit.sh` | Script d’installation et wrapper pour Metasploit |
| `scripts/start-tor-firefox.sh` | Lance Tor, vérifie l’adresse IP et ouvre le navigateur sécurisé |

> **Note :** Les outils contenus ici sont fournis **à des fins éducatives et légales uniquement**.

---

## ▶️ Installation rapide (Termux)

1. Cloner le dépôt :
   ```bash
   git clone git@github.com:Makarovababio/Makarovababio.git
   cd Makarovababio
   chmod +x scripts/*.sh
   bash scripts/start-tor-firefox.sh
