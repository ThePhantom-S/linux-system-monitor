echo "User : $USER"
echo "Date : $(date)"
Log_File="./logs/processes.log"

count=$(ps -e --no-headers | wc -l)
echo "Number Of Processes Running Are : $count"

echo "----------------------------------------"
echo "Top 5 processes consuming more cpu are :"
echo "----------------------------------------"

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 |grep -v -E '(ps|head)'

echo "========================================="

{
	echo "User Name : $USER"
	echo "Timestamp : $(date)"

	echo "-----------------------------------------"
	echo "Total Number Of Processes Running : $count"
	echo "-----------------------------------------"

	ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11 |grep -v -E '(ps|head)'
	echo "========================================="
} >> $Log_File
