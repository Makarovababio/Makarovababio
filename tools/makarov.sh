#!/bin/bash
# ===============================
# Makarov Security Toolkit - Launcher
# ===============================
VERSION="1.1"
TOOLS_DIR="$HOME/MonGitHub/tools"
REPO_DIR="$HOME/MonGitHub"
LOG_DIR="$HOME/MonGitHub/logs"

mkdir -p "$LOG_DIR"

main_menu() {
  clear
  echo "===================================="
  echo "   🔰 Makarov Security Toolkit v$VERSION"
  echo "===================================="
  echo
  echo "1) Scan Wi-Fi (complet, API + fallback)"
  echo "2) Infos Wi-Fi (lite, sans root)"
  echo "3) Voir logs"
  echo "4) Ouvrir dossier tools"
  echo "5) Mise à jour / Push Git (pull/add/commit/push)"
  echo "6) Quitter"
  echo
  read -rp "👉 Choisis une option (1-6): " choix
  case "$choix" in
    1) bash "$TOOLS_DIR/wifi-info.sh" ;;
    2) bash "$TOOLS_DIR/wifi-info-lite.sh" ;;
    3)
       echo
       echo "=== Derniers logs disponibles ==="
       ls -lh "$LOG_DIR" || echo "Aucun log."
       ;;
    4)
       echo
       echo "Opening tools folder:"
       ls -la "$TOOLS_DIR"
       ;;
    5) git_help_menu ;;
    6)
       echo "👋 Au revoir — Makarov Toolkit fermé."
       exit 0
       ;;
    *)
       echo "❌ Choix invalide."
       ;;
  esac

  echo
  read -rp "Appuie sur Entrée pour revenir au menu..." _
  main_menu
}

git_help_menu() {
  clear
  echo "=== GIT : Pull / Commit / Push depuis $REPO_DIR ==="
  echo
  cd "$REPO_DIR" || { echo "Repo introuvable: $REPO_DIR"; return; }
  echo "Etat actuel (git status) :"
  git status --short
  echo
  echo "1) git pull (récupérer les changements distants)"
  echo "2) git add + commit (fichiers modifiés locaux)"
  echo "3) git push (envoyer vers origin)"
  echo "4) Tout faire (pull -> add -> commit -> push)"
  echo "5) Annuler / retour"
  read -rp "Choix Git (1-5) : " g
  case "$g" in
    1)
      echo "[git pull] Récupération..."
      git pull --rebase
      ;;
    2)
      echo "Fichiers modifiés (git status --short) :"
      git status --short
      read -rp "Entrer le message de commit (ou vide pour annuler): " msg
      if [ -z "$msg" ]; then
        echo "Commit annulé."
      else
        git add -A
        git commit -m "$msg" || echo "Rien à committer ou échec."
      fi
      ;;
    3)
      echo "[git push] Pushing..."
      git push
      ;;
    4)
      echo "[AUTO] pull -> add -> commit -> push"
      git pull --rebase
      git add -A
      read -rp "Message de commit automatique (ou Enter pour utiliser 'Auto update'): " amsg
      amsg=${amsg:-"Auto update"}
      git commit -m "$amsg" || echo "Rien à committer."
      git push
      ;;
    5) echo "Retour au menu." ;;
    *) echo "Choix invalide." ;;
  esac
  echo
  read -rp "Terminé. Appuie Entrée pour revenir..." _
  cd "$REPO_DIR" || true
}

# démarrage
main_menu
