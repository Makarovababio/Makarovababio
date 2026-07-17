from scapy.all import sniff, DNS, IP, TCP

print("==================================================")
print("     LANCEMENT DU DÉTECTEUR D'INTRUSION PYTHON    ")
print("        Surveillance du réseau en cours...        ")
print("==================================================")

def analyser_paquet(paquet):
    # On s'assure que le paquet possède bien une couche IP pour éviter les bugs
    if not paquet.haslayer(IP):
        return

    # 1. Détecter les requêtes de recherche de sites (DNS)
    if paquet.haslayer(DNS) and paquet[DNS].opcode == 0:
        ip_source = paquet[IP].src
        if paquet[DNS].qd:
            site_demande = paquet[DNS].qd.qname.decode('utf-8', errors='ignore')
            print(f"[🚨 ALERTE DNS] L'appareil {ip_source} cherche à visiter : {site_demande}")

    # 2. Détecter les tentatives de connexion suspectes (TCP)
    elif paquet.haslayer(TCP):
        ip_source = paquet[IP].src
        ip_destination = paquet[IP].dst
        port_destination = paquet[TCP].dport
        # On surveille les ports sensibles : 21 (FTP), 22 (SSH), 23 (Telnet), 80 (HTTP), 443 (HTTPS)
        if port_destination in:
            print(f"[🔍 FLUX TCP] Connexion de {ip_source} vers {ip_destination} sur le port {port_destination}")

# Lancement de l'écoute en direct sur la carte réseau eth0
sniff(iface="eth0", prn=analyser_paquet, store=0)
