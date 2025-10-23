#!/usr/bin/env python3
"""
generate_report.py — transforme les fichiers XML Nmap en rapport Markdown
Usage:
  python3 generate_report.py ~/MonGitHub/logs rapport.md
"""
import os, sys, glob, xml.etree.ElementTree as ET
from datetime import datetime

def parse_xml(f):
    try:
        tree = ET.parse(f)
    except Exception as e:
        return None
    root = tree.getroot()
    hosts = []
    for host in root.findall("host"):
        ip = host.find("address").get("addr", "inconnu")
        ports = []
        for port in host.findall(".//port"):
            state = port.find("state").get("state")
            service = port.find("service")
            svc_name = service.get("name") if service is not None else "-"
            ports.append((port.get("portid"), port.get("protocol"), state, svc_name))
        hosts.append((ip, ports))
    return hosts

def main():
    if len(sys.argv) < 3:
        print("Usage: generate_report.py <dossier_logs> <fichier_sortie>")
        sys.exit(1)
    src, out = sys.argv[1:3]
    files = sorted(glob.glob(os.path.join(src, "*.xml")))
    if not files:
        print("Aucun XML trouvé dans", src)
        sys.exit(1)
    lines = [f"# Rapport Nmap ({datetime.now().isoformat()})", ""]
    for f in files:
        lines.append(f"## {os.path.basename(f)}")
        hosts = parse_xml(f)
        if not hosts:
            lines.append("Erreur de parsing.\n")
            continue
        for ip, ports in hosts:
            lines.append(f"### Hôte: {ip}")
            if not ports:
                lines.append("- Aucun port ouvert.")
            else:
                lines.append("| Port | Proto | État | Service |")
                lines.append("|------|:------:|:------:|:---------|")
                for p in ports:
                    lines.append(f"| {p[0]} | {p[1]} | {p[2]} | {p[3]} |")
            lines.append("")
    with open(out, "w") as fh:
        fh.write("\n".join(lines))
    print("[+] Rapport créé :", out)

if __name__ == "__main__":
    main()
