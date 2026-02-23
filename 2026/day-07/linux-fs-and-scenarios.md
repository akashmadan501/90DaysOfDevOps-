# Part 1: Linux File System Hierarchy

## Core Directories (Must Know):

- `/ `    - The top-level directory of linux. Every file, directory starts from here. Mosty used while troubleshooting boot issues.

- `/home`    -  Contains personal directory for users.I use this to store my(user) application files, scripts, SSH keys and projects.

- `/root` -   Home directory of root(admin) user. Different form `/` . Mosty used for administrative  scripts and emergency access when normal users fail.

- `/etc`   -  Stores system-wide configuration files. I use this dir to edit configs services like `nginx, ssh, etc`, networking also.

- `/var`   -  Variable data that changes frequently. Important subdirectory in this dir is `/var/log`. I use this to analysis log during incidents, failures and debugging .

- `/tmp`  -  Stores  temporary files. Cleared on reboot. I will user this dir to store any file which i not gonna use after reboot.

- `/bin`  -   This stores all the essential system binaries. symbolic link to `/usr/bin`. work even in rescue  mode. ex- `ls, mv, cp `

- `/usr/bin`  -   Works when system is fully up. User-level binaries and application. ex- `git, curl , python, docker, etc` .


- `/opt`   -   Optional or third-party software are stored here which are not part of core system. I will use this for custom installations like enterprise software.

```
akash@ubuntu ~ $ du -sh /var/log/* 2>/dev/null | sort -h | tail -5
2.5M	/var/log/sysstat
2.8M	/var/log/syslog
3.6M	/var/log/kern.log.1
8.9M	/var/log/syslog.1
1.4G	/var/log/journal
```
Purpose finding whihc logs are consuming most of disk space.

--- 


# Part 2: Scenario-Based Practice (40 minutes)

## Scenario 1: Service Not Starting After Reboot

**Step 1**    
``systemctl status nginx``
- Why - To check service state 

**Step 2**              
``systemctl list-units --type=service``
- Why  - To see service present on system or not.

**Step 3**
``systemctl is-enabled nginx``
- Why - to see is this service set to start when system boot on default.


---

##  Scenario 2: High CPU Usage

Your manager reports that the application server is slow.
You SSH into the server. What commands would you run to identify
which process is using high CPU?

**Step 1**    
``htop/top``
- Why - to see all the process running with their cpu usage.

**Step 2**              
``ps aux --sort=-%cpu | head -10``
- Why  - Sort processes and get PID of process having higher cpu usage. 

**Step 3**
``kill Pid``
- Why - to kill the process if necessary .

--- 



## Scenario 3: Finding Service Logs
A developer asks: "Where are the logs for the 'docker' service?"
The service is managed by systemd.
What commands would you use?


**Step 1**    
``systemctl status docker``
- Why - Check status first.

**Step 2**              
``journalctl -u docker -n 50``
- Why  - To get last 50 lines of respective service logs.

**Step 3**
``journalctl -u docker -f``
- Why - `-f` flag to get real-time logs.


--- 


## Scenario 4: File Permissions Issue

A script at /home/user/backup.sh is not executing.
When you run it: ./backup.sh
You get: "Permission denied"

What commands would you use to fix this?


**Step 1**    
``ls -l /home/user/hackup.sh``
- Why - Check is file having exectable permission.

**Step 2**              
`` chmod +x /home/user/backup.sh``
- Why  - if not, give executable permission to file.

**Step 3**
``ls -l /home/user/backup.sh``
- Why - verfiy once

**Step 4**
``./home/user/backup.sh``
- Why - run script

