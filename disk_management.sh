#!/bin/bash
# disk_management.sh

THRESHOLD=${THRESHOLD=-2O}
LOG_FILE="./logs/disk_management.log"

user="$USER"
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Evaluate state once
risky=$(df -h | awk -v t="$THRESHOLD" 'NR>1 && $5+0 >= t')

echo "User : $user"
echo "Date : $timestamp"
echo "---------------------"
echo "   DISK MANAGEMENT"
echo "---------------------"

if [ -n "$risky" ]; then
    echo "WARNING: Disk usage above ${THRESHOLD}%"
    echo "=================================================="
    df -h | awk -v t="$THRESHOLD" 'NR==1 || $5+0 >= t'
    echo "=================================================="
    status=1
else
    echo "All filesystems healthy (usage < ${THRESHOLD}%)"
    status=0
fi

# Append structured log
{
  echo "========================================"
  echo "Timestamp : $timestamp"
  echo "User      : $user"
  echo "Threshold : ${THRESHOLD}%"
  echo "Status    : $( [ $status -eq 0 ] && echo OK || echo WARNING )"
  if [ -n "$risky" ]; then
      df -h | awk -v t="$THRESHOLD" 'NR==1 || $5+0 >= t'
  else
      echo "All filesystems below threshold"
  fi
} >> "$LOG_FILE"

exit $status
