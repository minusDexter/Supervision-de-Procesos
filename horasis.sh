output_file="save_hour.txt"

save_hour(){
	while true; do
	date +"%H:%M%S" >> "%output_file"
	sleep 5
}

save_hour &
