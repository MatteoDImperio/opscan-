# OpScan

![Bash](https://img.shields.io/badge/Language-Bash-informational?style=flat&logo=gnu-bash)
![License](https://img.shields.io/badge/License-MIT-blue)
![Nmap](https://img.shields.io/badge/Tool-Nmap-lightgrey)
![Metasploit](https://img.shields.io/badge/Tool-Metasploit-red)
![Searchsploit](https://img.shields.io/badge/Tool-Searchsploit-yellow)

**OpScan** è uno script Bash avanzato per la scansione di porte e servizi di host singoli o intere reti, con suggerimenti automatici di exploit Metasploit e integrazione opzionale con Searchsploit. Ideale per penetration test educativi, laboratori di sicurezza e analisi preliminari di vulnerabilità.

---

## Caratteristiche principali

- Scansione di singoli host o intere reti (CIDR) tramite Nmap.
- Identificazione di porte aperte, servizi e versioni.
- Suggerimenti di exploit Metasploit predefiniti per servizi comuni:
  - FTP, SSH, Telnet, SMTP, HTTP, MySQL, PostgreSQL, VNC.
- Ricerca di vulnerabilità tramite Searchsploit (se installato).
- Preparazione di comandi Metasploit pronti all’uso.
- Output chiaro e leggibile con dettagli di target, porta, servizio, versione e suggerimenti exploit.
- Gestione automatica errori e notifiche se strumenti opzionali non sono presenti.

---

## Requisiti

- Bash (Linux, macOS, WSL)
- Nmap (`sudo apt install nmap`)
- Metasploit Framework opzionale (`msfconsole`)
- Searchsploit opzionale (`sudo apt install exploitdb`)

> Lo script funziona anche se Metasploit o Searchsploit non sono assenti, ma alcune funzionalità saranno limitate.

---

## Installazione

```bash
git clone https://github.com/tuo-username/OpScan.git
cd OpScan
chmod +x opscan.sh
./opscan.sh


Uso:

All’avvio, OpScan chiederà se vuoi scansionare un singolo IP o una rete:

Vuoi scansionare un singolo IP o una rete? (IP/rete)


IP → scansiona un host specifico.

rete → scansiona una rete (es. 192.168.1.0/24).


Lo script procede così:

Scansione completa Nmap (nmap -p- -sV --open $TARGET)

Elenco porte, servizi e versioni.

Suggerimenti exploit Metasploit predefiniti.

Ricerca exploit tramite Searchsploit (se installato).

Comandi Metasploit pronti all’uso per ricerche dinamiche.

esempio di output :

[*] Scansione in corso su 192.168.1.10...
==== Risultati Scansione ====
Target: 192.168.1.10
Porta: 21/tcp | Servizio: ftp
Versione: vsftpd 2.3.4

Suggerimento exploit predefinito:
 msfconsole -x 'use exploit/unix/ftp/vsftpd_234_backdoor; set RHOST $TARGET; exploit'

[*] Ricerca con Searchsploit per: ftp vsftpd 2.3.4
[+]  Exploit 1: vsftpd 2.3.4 backdoor
[+]  Exploit 2: vsftpd 2.3.4 other vulnerability
...
[*] Comando Metasploit pronto:
 msfconsole -x 'search type:exploit ftp vsftpd 2.3.4'
---------------------------

Servizi supportati per exploit predefiniti
Servizio	Exploit/Comando Metasploit
FTP	exploit/unix/ftp/vsftpd_234_backdoor
SSH	auxiliary/scanner/ssh/ssh_login
Telnet	auxiliary/scanner/telnet/telnet_login
SMTP	auxiliary/scanner/smtp/smtp_version
HTTP	exploit/multi/http/apache_mod_cgi_bash_env_exec
MySQL	auxiliary/scanner/mysql/mysql_version
PostgreSQL	auxiliary/scanner/postgres/postgres_version
VNC	auxiliary/scanner/vnc/vnc_login







Note di sicurezza

Uso educativo: testare solo su reti di tua proprietà o autorizzate.

L’uso su reti altrui senza permesso è illegale.

Lo script genera informazioni sensibili: usarlo responsabilmente.





Licenza

Rilasciato sotto MIT License: libera redistribuzione e modifica con citazione autore.



Risorse utili

Nmap Documentation

Metasploit Framework

Searchsploit / Exploit-DB


