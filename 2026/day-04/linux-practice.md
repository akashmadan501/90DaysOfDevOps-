# Real Time Output of commnads

### Process Commands
- `ps -aux | tail -20` 
List running processes (last 20 lines)
![alt text](<Screenshot from 2026-02-21 15-39-49.png>)

- `pgrep -l brave`
![alt text](image.png)

### Service Commands

- `systemctl status | head -20` 
display status of system services
![alt text](image-1.png)

-`systemctl list-units --type=serivce --state=running`
display system services which are in running state
 ![alt text](image-2.png)


### Logs Commands
- `journalctl -u nginx` 
Display logs of nginx(respective service)
![alt text](image-3.png)

- `journalctl -u docker | tail -15` 
Display last 15 lines of docker log
![alt text](image-4.png)

- `sudo cat kern.log | head -10` 
- `journalctl -k | head -10` 
Display kernal logs 
![alt text](image-5.png)

### Inspecting an service (docker)

- `systemctl status docker `
get status of service
![alt text](image-9.png)

- `journalctl -u docker | tail -10` 
get logs of docker service
![alt text](image-10.png)

- `systemctl stop docker` 
lets stop the serice
![alt text](image-11.png)

- `journalctl -u docker | tail -15` 
now let's again get logs
![alt text](image-12.png)
---

## Notes

- Docker may restart automatically due to `docker.socket`
- Logs are managed by `journald` on systemd-based systems