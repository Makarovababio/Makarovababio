# Makarov Security Toolkit

> Pack d'outils Termux / scripts d'audit — collection personnelle de Makarov  
> Léger, portable et conçu pour les tests légaux et l'apprentissage.

---

## ⚡ Présentation
**Makarov Security Toolkit** regroupe une série de scripts et utilitaires destinés à faciliter des opérations d'audit, d'anonymisation et d'automatisation sur Termux.  
Ce dépôt contient uniquement des scripts et instructions — il **n'inclut pas** les grosses images, bases de données ou autres fichiers lourds.

---

## 📦 Contenu principal
- `scripts/install-nethunter-termux` — (script d'installation / helpers)
- `scripts/metasploit.sh` — (script d'installation / wrapper Metasploit)
- `scripts/start-tor-firefox.sh` — lance Tor (Termux), teste l'IP et ouvre le navigateur

(La structure actuelle du dépôt : `scripts/`, `tools/`, `logs/`)

---

## ▶️ Installation rapide (Termux)
1. Cloner le dépôt :
```bash
git clone git@github.com:Makarovababio/Makarovababio.git
cd Makarovababio
chmod +x scripts/*.sh
bash scripts/start-tor-firefox.sh
