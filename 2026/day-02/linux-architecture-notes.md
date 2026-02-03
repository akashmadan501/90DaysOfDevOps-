
### Kernel
The heart of the Linux operating system. It manages all hardware resources like CPU, memory, and storage. The kernel runs in a special protected area called "kernel space" where it has direct access to hardware.

### User Space
Where your everyday applications, programs, and shell run. These programs cannot directly access hardware - they're sandboxed for safety. When a program needs to use the CPU, RAM, or disk, it must ask the kernel for permission through "system calls."

### Init/Systemd
The first process started by the kernel (Process ID 1). It launches and manages all other processes on your system, like starting services when you boot up.



### Process States
- **Running**: Currently using the CPU
- **Sleeping**: Waiting for something (I/O to finish, user input, etc.)
- **Zombie**: Finished but parent process hasn't cleaned it up yet
- **Stopped**: Paused by a signal

## Systemd
The modern system that manages Linux services and processes. It replaced older systems and allows services to start in parallel, making your system boot faster.

### Daemons
Background processes that run continuously without user interaction. They provide services to the system and other applications (like web servers, database servers, or logging services). Daemons typically have names ending in 'd' (e.g., `sshd`, `httpd`) and are managed by systemd.


## Common Commands for Beginners
- `mkdir` - create a directory
- `vim` - create and edit files
- `ping` - test if a website is reachable
- `cp` - copy files or folders
- `mv` - move or rename files
- `ifconfig` or `ip addr` - view your network and IP address

## What is I/O?

**I/O** stands for Input/Output. It's any communication between your program and external devices:
- **Input**: Reading data from disk, keyboard, network, sensors
- **Output**: Writing data to disk, screen, network, printer

I/O operations are slow compared to CPU speed, so processes often "sleep" while waiting for I/O to complete.

## Linux System Architecture

```
┌──────────────────────────────────┐
│   Your Apps & Programs           │
│   (Firefox, VS Code, Terminal)   │
├──────────────────────────────────┤
│   Shell (bash, zsh)              │
├──────────────────────────────────┤
│   KERNEL                         │
│   (Controls everything)          │
├──────────────────────────────────┤
│   Hardware                       │
│   (CPU, RAM, Disk, Network)      │
└──────────────────────────────────┘
```

#### Process Management
1. **Shell Running**: Terminal is active.
2. **Command Input**: Shell reads command.
3. **Process Creation**: `fork()` creates a child process.
4. **Exec**: Child process replaces code with `mkdir`.
5. **Job Execution**: `mkdir` creates the directory.
6. **Exit**: `mkdir` exits after completion.
7. **Cleanup**: Shell collects exit status and frees resources.

#### Summary
Process creation = `fork` + `exec`; Process management = start, schedule, monitor, terminate.

🔧 **How Linux Manages Many Processes**

While this happens:

- CPU switches between processes
- Kernel scheduler decides who runs
- Each process gets time slices

We feel it as instant ⚡  
Linux is just extremely fast.
