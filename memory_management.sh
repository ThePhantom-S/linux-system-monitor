
THRESHOLD=${THRESHOLD:-20}

MemAvailable=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
MemTotal=$(awk '/MemTotal/ {print $2}' /proc/meminfo)

available_percent=$(( MemAvailable * 100 / MemTotal ))

echo "MemAvailable (kB): $MemAvailable"
echo "MemTotal (kB): $MemTotal"
echo "Available Percent: $available_percent%"

if [ "$available_percent" -lt "$THRESHOLD" ]; then
	echo "status : WARNING"
	exit 1
else
	echo "Status : OK"
	exit 0
fi
