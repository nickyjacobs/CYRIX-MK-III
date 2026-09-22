---
title: "[Box-naam]"
created: {{date}}
updated: {{date}}
tags: [cert, cpts, box]
category: 10-projects
status: bezig
machine: 
os: 
platform: 
difficulty: 
ip: 
url: 
---

<!-- Kopieer dit bestand (of voeg het toe als Obsidian-template via Settings >
     Templates) en vul in. Sync: als checklists/enumeratie.md,
     checklists/initial-foothold.md of checklists/linux-privesc.md wijzigt, werk de
     stappen hieronder dan ook bij. -->

# [Box-naam]

**OS:** [Linux/Windows] · **Platform:** [HTB Academy/HTB Main/CTF] · **Moeilijkheid:** [Easy/Medium/Hard] · **Status:** bezig/af

Zie ook: [[enumeratie]] · [[initial-foothold]] · [[linux-privesc]]

## Overzicht

| Veld | Waarde |
|---|---|
| IP | |
| URL | |
| Poorten (open) | |
| Services | |
| Versies | |

<!-- Alleen invullen wat je al weet/verwacht tijdens enumeratie, niet meer dan dat. -->

## 1. Enumeratie

- [ ] Nmap quick + scriptscan
  ```bash
  nmap -sC -sV -p- <ip>
  ```
- [ ] Banner grabbing op interessante poorten
  ```bash
  nc -nv <ip> <poort>
  ```
- [ ] FTP: anonieme login proberen
- [ ] SMB: shares listen, dan met/zonder credentials
  ```bash
  smbclient -N -L \\<ip>
  ```
- [ ] SNMP: community strings
  ```bash
  snmpwalk -v 2c -c public <ip>
  ```
- [ ] Web: whatweb + curl (HTML-comments checken)
  ```bash
  whatweb http://<ip>
  curl http://<ip>
  ```
- [ ] Web: directory-enumeratie
  ```bash
  gobuster dir -u http://<ip>/ --wordlist /usr/share/seclists/Discovery/Web-Content/common.txt
  ```
- [ ] Web: versie-info uit README/config/XML-bestanden
- [ ] Web: wpscan aggressive plugin-enum (indien WordPress)
- [ ] Admin-panel met default/geraden credentials proberen

### Walkthrough

```bash

```

### Bevindingen

- 

## 2. Initial foothold

- [ ] searchsploit
  ```bash
  searchsploit <naam> <versie>
  ```
- [ ] Metasploit search + module configureren
- [ ] Testpayload om code execution te bevestigen, pas daarna reverse shell
- [ ] Listener klaarzetten
  ```bash
  nc -lvnp <poort>
  ```
- [ ] Reverse shell triggeren
- [ ] TTY upgraden
  ```bash
  python3 -c 'import pty; pty.spawn("/bin/bash")'
  ```
- [ ] Bestanden overzetten indien nodig (http.server + wget/curl, scp, base64)

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
- [ ] LinEnum/LinPEAS
- [ ] Schrijfbare bestanden die als root draaien (sudoers/cron)
- [ ] SSH-keys (leesbaar `/root/.ssh/id_rsa`?)
- [ ] SUID-binaries
  ```bash
  find / -perm -4000 -type f 2>/dev/null
  ```
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

## Flags

**User flag**
> [!success]- Flag
> 

**Root flag**
> [!success]- Flag
> 

## Geleerd

- 
