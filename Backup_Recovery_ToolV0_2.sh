#!/bin/bash

clear

# -------------------------------
# v0.2 UPDATE
# Added logging system
# Added automatic backup directory creation
# Improved validation checks
# -------------------------------

LOG_FILE="./logs/backup_log.txt"
mkdir -p ./logs

line() {
echo "=========================================="
}

line
echo "🐧 Linux Backup & Recovery Tool v0.2 ♻️"
line
echo ""

echo "👉 What do you want to do? 👨‍💻"
echo ""
echo "   1️⃣  BACKUP"
echo "   2️⃣  RECOVERY"
echo ""

read -p "Enter your choice : " ACTION
echo ""

# ================= BACKUP MODE =================
if [ "$ACTION" == "1" ]; then

    echo "📂 Backup Configuration"
    echo "------------------------------------------"

    read -p "Source Path        : " SOURCE
    read -p "Backup Destination : " DEST
    read -p "Backup Type (Daily/Once) : " FREQUENCY
    echo ""

   # Validate source path
if [ ! -e "$SOURCE" ]; then
    echo "❌ Source path does not exist!"
    exit 1
fi

# Check destination
if [ ! -d "$DEST" ]; then

    echo "⚠️ Destination path does not exist!"
    echo ""
    read -p "Backup to default location ($HOME/backups)? (yes/no): " CHOICE

    if [ "$CHOICE" == "yes" ]; then

        DEST="$HOME/backups"
        mkdir -p "$DEST"

        echo ""
        echo "📁 Using default backup location: $DEST"
        echo ""

    else
        echo ""
        echo "❌ Backup aborted due to invalid destination."
        exit 1
    fi
fi

    DATE=$(date +%F_%H-%M-%S)
    BACKUP_FILE="$DEST/backup_$(basename "$SOURCE")_$DATE.tar.gz"

    echo "📦 Starting Backup..."
    sleep 1

    tar -czpf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

    # Check if backup succeeded
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Backup Completed Successfully!"
        echo "📁 Saved at : $BACKUP_FILE"
        echo ""

        echo "$(date) - Backup successful for $SOURCE -> $BACKUP_FILE" >> "$LOG_FILE"

    else
        echo "❌ Backup Failed!"
        echo "$(date) - Backup FAILED for $SOURCE" >> "$LOG_FILE"
        exit 1
    fi

    # ---------- DAILY BACKUP ----------
    if [ "$FREQUENCY" == "Daily" ]; then

        echo "⏰ Schedule Daily Backup"
        echo "------------------------------------------"

        read -p "Hour (0-23)   : " HOUR
        read -p "Minute (0-59) : " MIN

        CRON_JOB="$MIN $HOUR * * * /bin/bash $(realpath $0)"

        (crontab -l 2>/dev/null; echo "$CRON_JOB") | sudo crontab -

        echo ""
        echo "😎 Daily Backup Scheduled at 👉 $HOUR:$MIN"
        echo ""

        echo "$(date) - Daily backup scheduled at $HOUR:$MIN for $SOURCE" >> "$LOG_FILE"
    fi


# ================= RECOVERY MODE =================
elif [ "$ACTION" == "2" ]; then

    echo "♻️ Recovery Mode"
    echo "------------------------------------------"

    read -p "Backup File Path : " BACKUP_FILE
    read -p "Restore Location : " TARGET_DIR
    echo ""

    # Validate backup file
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "❌ Backup file not found!"
        exit 1
    fi

    # Validate restore location
    if [ ! -d "$TARGET_DIR" ]; then
        echo "❌ Target directory does not exist!"
        echo "🚧 Recovery aborted."
        exit 1
    fi

    echo "🔄 Starting Recovery..."
    sleep 1

    tar -xpvf "$BACKUP_FILE" -C "$TARGET_DIR"

    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Recovery Completed Successfully!"
        echo "📂 Restored to : $TARGET_DIR"
        echo ""

        echo "$(date) - Recovery successful from $BACKUP_FILE to $TARGET_DIR" >> "$LOG_FILE"

    else
        echo ""
        echo "❌ Recovery Failed!"
        echo ""
        echo "$(date) - Recovery FAILED from $BACKUP_FILE" >> "$LOG_FILE"
    fi

else
    echo ""
    echo "⚙️ Invalid Input — Exiting Tool 🚧"
    echo ""
    exit 1
fi
