# DevOps Bash Scripts

This repository contains production-style Bash scripts commonly used in DevOps and Linux system administration.

## Scripts Included

- **backup.sh**  
  Automates compressed backups of application data and removes old backups.

- **disk_monitor.sh**  
  Monitors disk usage and logs warnings or critical alerts.

- **nginx_check.sh**  
  Checks Nginx service status.

- **nginx_autofix.sh**  
  Automatically restarts Nginx if it is down.

- **log_rotation.sh**  
  Manages and rotates log files.

- **cleanup.sh**  
  Cleans up old or unnecessary files.

- **zip_backup.sh**  
  Creates compressed backups using tar and gzip.

## Prerequisites

- Linux (CentOS / RHEL / Ubuntu)
- Bash shell
- Required permissions to run scripts

## Usage

```bash
chmod +x script_name.sh
./script_name.sh

