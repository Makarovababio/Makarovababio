#!/bin/bash
# Makarov Security Toolkit - scan-port.sh
# Petit scanner de ports utilisant netcat

if [ -z "$1" ]; then
  echo "Usage: $0 <IP>"
  exit 1
fi

echo "🔎 Scan de ports sur $1 ..."
for port in {20..1024}; do
  nc -z -w1 $1 $port 2>/dev/null && echo "✅ Port ouvert : $port"
done
echo "🎯 Scan terminé."
