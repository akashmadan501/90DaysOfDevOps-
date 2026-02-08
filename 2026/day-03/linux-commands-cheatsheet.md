
# File Management

```bash
mkdir <dirname>
mkdir -p <path>
```

```bash
touch
```

```bash
vim <filename>
```

```bash
cd ..
```

```bash
cd ~
```

```bash
ls
```

# SSH (Secure Shell)

SSH (SSH client) is a program for logging into a remote machine and for executing commands on a remote machine. It is intended to provide secure encrypted communications between two machines (client & host). SSH uses port 22.

## Local to Server
- To create connection client (local) should have private key and host (server) should have public key.

## Server to Server
- If server A wants to access server B shell
- Server A should have private key
- Server B should have public key

```
┌─────────────────────────────────────────────────────────────┐
│                    SSH Connection Flow                      │
└─────────────────────────────────────────────────────────────┘

LOCAL TO SERVER:
┌──────────────┐                    ┌──────────────┐
│   Client     │                    │   Server     │
│  (Local)     │                    │  (Remote)    │
│              │                    │              │
│ Private Key  │◄──────Port 22─────►│ Public Key   │
│              │   Encrypted        │              │
└──────────────┘                    └──────────────┘

SERVER TO SERVER:
┌──────────────┐                    ┌──────────────┐
│  Server A    │                    │  Server B    │
│              │                    │              │
│ Private Key  │◄──────Port 22─────►│ Public Key   │
│              │   Encrypted        │              │
└──────────────┘                    └──────────────┘
```

## How to Generate SSH Keys

**Step 1:** Change path to `.ssh` of client machine
```bash
cd ~/.ssh
```

**Step 2:** Generate key
```bash
ssh-keygen
```
(Enter passphrase or simply press enter)

**Step 3:** List files
```bash
ls
```

**Step 4:** You will see both private and public keys. Copy public key:
```bash
cat id_ed8463.pub
```

**Step 5:** Paste public key into server in `.ssh` dir

**Step 6:** Now connect server machine using this command:
```bash
ssh -i 'private_key_path' user@DNS
ssh -i "/home/user/Desktop/key.pem" ubuntu@ec2-3-129-67-210.us-east-2.compute.amazonaws.com
```

To see SSH configs:
```bash
cat /etc/ssh/sshd_config
```

# Package Installer

apt provides a high-level command-line interface for the package management system.

- Ubuntu: `apt`
- Red Hat: `rpm`, `dnf`
- CentOS: `yum`

- **update**: Download packages
- **upgrade**: Install the downloaded packages

To install packages using apt:
```bash
apt install package_name
```

# Process Management

First system process is systemd (PID 1)

To get status of service we installed:
```bash
systemctl status service_name
systemctl status nginx
```

To stop:
```bash
systemctl stop service_name
```

To start:
```bash
systemctl start service_name
```

# Journalctl

Use to get the logs:
```bash
journalctl -u service_name
journalctl -u nginx
```

# User Management

To add user:
```bash
sudo useradd -m <username>
sudo useradd -m <username> -s 'shell_path'
sudo useradd -m naruto -s /usr/bin/bash
```
- `-m`: Create in home directory
- `-s`: Sets the path to the user's login shell

To set password:
```bash
sudo passwd <username>
```

To switch user:
```bash
su <username>
```

To see current user:
```bash
whoami
```

To add group:
```bash
sudo groupadd <groupname>
```

To see groups in system:
```bash
cat /etc/group
```

To add user to group:
```bash
sudo gpasswd -a <username> <groupname>
sudo gpasswd -a ubuntu docker  # run all docker without using sudo
```

To change ownership of file:
```bash
sudo chown <username> 'file_name'
```

Example:
```
-rw-rw-r--     1     tokyo     ubuntu 0 Feb  4 21:12 josh.txt
    |                  |         |
permission          owner      group
```

# Permission Management

```
drwxrwxr-x                    -rwxrwxr-x   
|                             |
directory                     file

owner      group    other
  |          |        | 
d rwx     rwx        r-x
```

