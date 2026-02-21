# Real Time Output of Commands

---

## Process Commands

- `ps aux | tail -20`  
  List running processes (last 20 lines)

![ps aux output](screenshots/Screenshot%20from%202026-02-21%2015-39-49.png)

---

- `pgrep -l brave`  
  Display PID and name of the Brave browser process

![pgrep brave](screenshots/image.png)

---

## Service Commands

- `systemctl status | head -20`  
  Display status of system services

![systemctl status](screenshots/image-1.png)

---

- `systemctl list-units --type=service --state=running`  
  Display system services which are in running state

![running services](screenshots/image-2.png)

---

## Logs Commands

- `journalctl -u nginx`  
  Display logs of nginx (respective service)

![nginx logs](screenshots/image-3.png)

---

- `journalctl -u docker | tail -15`  
  Display last 15 lines of Docker logs

![docker logs](screenshots/image-4.png)

---

- `journalctl -k | head -10`  
  Display kernel logs

![kernel logs](screenshots/image-5.png)

---

## Inspecting a Service (Docker)

- `systemctl status docker`  
  Get status of Docker service

![docker status](screenshots/image-9.png)

---

- `journalctl -u docker | tail -10`  
  Get logs of Docker service

![docker log tail](screenshots/image-10.png)

---

- `systemctl stop docker`  
  Stop Docker service

![docker stop](screenshots/image-11.png)

---

- `journalctl -u docker | tail -15`  
  Verify logs after stopping Docker

![docker logs after stop](screenshots/image-12.png)

---

## Notes

- Docker may restart automatically due to `docker.socket`
- Logs are managed by `journald` on systemd-based systems