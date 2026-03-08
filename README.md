![Linux](https://img.shields.io/badge/Linux-Bash-blue)
![Version](https://img.shields.io/badge/version-v0.1-green)
# 🐧 Linux Backup & Recovery Tool

A Bash-based Linux Backup & Recovery Automation Tool designed for system administrators and DevOps beginners to automate backup and restore operations using shell scripting and cron scheduling.

---

## 🚀 Project Overview

This tool allows users to:

✅ Take backup of files or directories  
✅ Restore backups easily  
✅ Automate daily backups using Cron Jobs  
✅ Maintain system recovery readiness  
✅ Practice real-world Linux Administration tasks  

This project is created as part of hands-on Linux & DevOps skill development.

---

## ⚙️ Features
 
- 📂 Directory & File Backup
- ♻️ Recovery Mode
- ⏰ Cron-based Automated Backup
- ✅ Input Validation
- 🖥️ Interactive CLI Interface
- 🐧 Works on Linux Systems

---

## 🛠️ Technologies Used

- Bash Shell Scripting
- Linux Administration
- Cron Scheduler
- TAR Compression Utility

---

## 📦 Project Structure
```
linux-backup-recovery-tool/
│
├── scripts/
│   └── backup_tool.sh
│
├── screenshots/
│
├── README.md
├── LICENSE
├── .gitignore
│
└── Releases (v0.1)
```


---

## ▶️ How to Use

### 1️⃣ Give Execute Permission
```bash
chmod +x backup_tool.sh
```
### 2️⃣ Run Tool
```
./scripts/backup_tool.sh
```
📸 Sample Output
### Main Interface
![Main Menu](screenshots/main_menu.png)

### Backup Execution
![Backup](screenshots/backup_execution.png)

### Recovery Execution
![Recovery](screenshots/recovery_execution.png)

### Error Handling
![Error](screenshots/invalid_directory_error.png)
---

🔄 Version

v0.1 – Initial Backup & Recovery Tool Release

---


🎯 Future Improvements

Automatic directory creation

Backup verification system

Logging mechanism

Email notification support

Incremental backups

---
## 📌 Use Case

This tool simulates real-world Linux system administration tasks such as automated backups and disaster recovery used in production environments.

---
## 🚀 Version v0.2 Updates

- Added logging system
- Improved validation for source and destination paths
- Automatic fallback backup location
- Timestamp-based backup naming
- Support for backing up both files and directories

 ## Screenshots

### Tool Interface
![Tool Interface](screenshots/tool_interface_v02.png)

### Invalid Destination/Path Alert
![Handling Invalid Path](screenshots/invalid_destination_alert_v02.png)

### Default Backup Location
![Default Path Selection](screenshots/default_backup_location_v02.png)



---

👨‍💻 Author

Siddharth Bhatt

Linux | DevOps Enthusiast

---

⭐ If you like this project, consider giving it a star!
