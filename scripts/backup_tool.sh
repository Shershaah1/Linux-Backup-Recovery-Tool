#!/bin/bash

clear

line() {
echo "=========================================="
}

line
echo "🐧  Linux Backup & Recovery Tool v0.1 ♻️"
line
echo ""

echo "👉 What do you want to do? 👨<200d>💻"
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

    DATE=$(date +%F)
    BACKUP_FILE="$DEST/backup_$(basename "$SOURCE")_$DATE.tar.gz"

    if [ ! -e "$SOURCE" ]; then
     echo "❌ Source path does not exist!"
        exit 1
    fi

    echo "📦 Starting Backup..."
    sleep 1

    tar -czpf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

    echo ""
    echo "✅ Backup Completed Successfully!"
    echo "📁 Saved at : $BACKUP_FILE"
    echo ""

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
    fi

# ================= RECOVERY MODE =================
elif [ "$ACTION" == "2" ]; then

    echo "♻️ Recovery Mode"
    echo "------------------------------------------"

    read -p "Backup File Path : " BACKUP_FILE
    read -p "Restore Location : " TARGET_DIR
    echo ""

    # ✅ Check if recovery directory exists
    if [ ! -d "$TARGET_DIR" ]; then
        echo "❌ Target directory does not exist!"
        echo "🚧 Recovery aborted."
        exit 1
    fi

    echo "🔄 Starting Recovery..."
    sleep 1

    sudo tar -xpvf "$BACKUP_FILE" -C "$TARGET_DIR"

    # ✅ Show success ONLY if tar succeeds
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Recovery Completed Successfully!"
        echo "📂 Restored to : $TARGET_DIR"
        echo ""
    else
        echo ""
        echo "❌ Recovery Failed!"
        echo ""
    fi

else
    echo ""
    echo "⚙️ Invalid Input — Exiting Tool 🚧"
    echo ""
    exit 1
fi

                                                
