# Linux troubleshooting runbook for Docker service

## Environment Basics

- cmd - `uname -a`
    ```
    Linux ubuntu 6.17.0-14-generic #14~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Jan 15 15:52:10 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
    ```
    Observation:
    Kernel and architecture look standard for Ubuntu VM
---
- cmd - `lsb_release -a`
    ```
    No LSB modules are available.
    Distributor ID:	Ubuntu
    Description:	Ubuntu 24.04.4 LTS
    Release:	24.04
    Codename:	noble
    ```
    Running a supported LTS release


## Filesystem sanity check

- cmd `mkdir /tmp/runbook-demo`
- cmd `cp /etc/hosts temp/runbook-demo/hosts-copy`
- cmd `ls -l /tmp/runbook-demo`
    ```
    akash@ubuntu ~ $ mkdir /tmp/runbook-demo
    akash@ubuntu ~ $ cp /etc/hosts /tmp/runbook-demo/hosts-copy
    akash@ubuntu ~ $ ls -l /tmp/runbook-demo/
    total 4
    -rw-r--r-- 1 nothing nothing 221 Feb 21 22:14 hosts-copy
    ```
    Observation:
    Filesystem is writable and permissions looks normal

## Snapshot: CPU & Memory
- cmd - `ps -o pid,pcpu,pmem,comm -C dockerd`
    ```
        PID %CPU %MEM COMMAND
    1866  0.0  1.2 dockerd
    ```
    Observation:
    Docker daemon CPU and memory usage are within normal usage.
---

-cmd - `free -h`
```
               total        used        free      shared  buff/cache   available
Mem:           5.6Gi       3.5Gi       565Mi       126Mi       1.9Gi       2.1Gi
Swap:          4.0Gi       355Mi       3.7Gi
```
Observation:
Memory Usabel seems ok


## Snapshot : Disk & IO
- cmd - `df -h`
```
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           574M  2.2M  572M   1% /run
/dev/sda2        98G   26G   68G  28% /
tmpfs           2.9G   91M  2.8G   4% /dev/shm
tmpfs           5.0M  8.0K  5.0M   1% /run/lock
tmpfs           574M  128K  574M   1% /run/user/1000
/dev/sr0        6.0G  6.0G     0 100% /media/nothing/Ubuntu 24.04.3 LTS amd641
```
Observation:
Disk usage is healthy

---

- cmd - `du -sh /var/log`
```
1.3G	/var/log
```
Observation:
Log directory size is moderate

## Snapshot: Network

- cmd - `ssh -tulpn | grep docker`
- No output 

**Observation:**  
No Docker TCP/UDP ports are listening; Docker is correctly using a local UNIX socket (`/run/docker.sock`) for client communication.
```
akash@ubuntu ~ $ ls -l /run/docker.sock 
srw-rw---- 1 root docker 0 Feb 21 21:33 /run/docker.sock
```
---
- cmd - `curl -I http://localhost`
```
curl: (7) Failed to connect to localhost port 80 after 0 ms: Couldn't connect to server
```
**Observation:**  
HTTP request to localhost failed with connection refused, indicating no service is currently listening on port 80.


## Logs Reviewed

- cmd - `journalctl -u docker -n -50`
```
akash@ubuntu ~ $ journalctl -u docker | tail -30
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.477128717+05:30" level=warning msg="error locating sandbox id 66bc76456c2ca8c24b9256ecd5a9a0263149b2e32507be839f0a865cc2cdd4a2: sandbox 66bc76456c2ca8c24b9256ecd5a9a0263149b2e32507be839f0a865cc2cdd4a2 not found"
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.477178923+05:30" level=warning msg="error locating sandbox id f33de78b2013c3acb739f59a0e25ad0e207406b13f4088b0e1f67563e7112c90: sandbox f33de78b2013c3acb739f59a0e25ad0e207406b13f4088b0e1f67563e7112c90 not found"
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.477814300+05:30" level=info msg="Loading containers: done."
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.515002311+05:30" level=info msg="Docker daemon" commit="28.2.2-0ubuntu1~24.04.1" containerd-snapshotter=false storage-driver=overlay2 version=28.2.2
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.515647056+05:30" level=info msg="Initializing buildkit"
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.517326604+05:30" level=warning msg="CDI setup error /etc/cdi: failed to monitor for changes: no such file or directory"
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.517364125+05:30" level=warning msg="CDI setup error /var/run/cdi: failed to monitor for changes: no such file or directory"
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.530491052+05:30" level=info msg="Completed buildkit initialization"
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.539379534+05:30" level=info msg="Daemon has completed initialization"
Feb 21 21:33:34 ubuntu dockerd[1866]: time="2026-02-21T21:33:34.539671348+05:30" level=info msg="API listen on /run/docker.sock"
Feb 21 21:33:34 ubuntu systemd[1]: Started docker.service - Docker Application Container Engine.
```
No errors in recent docker logs

- cmd - `tail -n 50 var/log/syslog`

```

2026-02-21T23:09:48.827338+05:30 ubuntu dockerd[28075]: time="2026-02-21T23:09:48.827166460+05:30" level=warning msg="CDI setup error /etc/cdi: failed to monitor for changes: no such file or directory"
2026-02-21T23:09:48.831102+05:30 ubuntu systemd[1]: var-lib-docker-overlay2-opaque\x2dbug\x2dcheck1264807873-merged.mount: Deactivated successfully.
2026-02-21T23:09:48.834876+05:30 ubuntu dockerd[28075]: time="2026-02-21T23:09:48.834747943+05:30" level=info msg="Completed buildkit initialization"
2026-02-21T23:09:48.841761+05:30 ubuntu dockerd[28075]: time="2026-02-21T23:09:48.841627846+05:30" level=info msg="Daemon has completed initialization"
2026-02-21T23:09:48.841834+05:30 ubuntu dockerd[28075]: time="2026-02-21T23:09:48.841737412+05:30" level=info msg="API listen on /run/docker.sock"
2026-02-21T23:09:48.842137+05:30 ubuntu systemd[1]: Started docker.service - Docker Application Container Engine.
2026-02-21T23:10:12.138886+05:30 ubuntu systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
2026-02-21T23:10:12.149487+05:30 ubuntu systemd[1]: sysstat-collect.service: Deactivated successfully.
2026-02-21T23:10:12.149863+05:30 ubuntu systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
```
No system-level error related to docker



## Quick Findings

- Docker service is running normally
- CPU, memory, disk, and logs show no abnormal behavior
- Docker socket is active (systemd socket activation enabled)


## If This Worsens (Next Steps)

- Restart Docker using a safe restart strategy (systemctl restart docker)
- Increase log verbosity (dockerd --debug) and recheck logs
- Collect deeper diagnostics (enable strace on dockerd or inspect containerd logs)