#! /bin/bash
clear

# filling courses.txt
bash Courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r
echo ""

}

# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

displayCoursesofLocation(){

    echo -n "Please Input a location: "
    read locationName

    echo ""
    echo "Courses of $locationName :"
    cat "$courseFile" | grep "$locationName" | cut -d';' -f1,2,5,6,7 | \
    sed 's/;/ | /g'
    echo ""

}

# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

displayCoursesofAvailability(){

echo -n "Please Input a course code "
    read codeName

    echo ""
    echo "Courses of $codeName with availability:"
    cat "$courseFile" | grep "$codeName" | cut -d';' -f1,2,3,4,5,6,7,8,9,10 | \
    sed 's/;/ | /g' | \
    while read -r line;
	do
		local spots=$(echo "$line" | cut -d'|' -f4)
		if [[ "$spots" -ge "0" ]]; then
			echo "$line"
			#echo "$spots"
		fi
	done
echo ""

}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses at location"
	echo "[4] Display courses with availability"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

    elif [[ "$userInput" == "3" ]]; then
		displayCoursesofLocation

    elif [[ "$userInput" == "4" ]]; then
		displayCoursesofAvailability


    else
        echo "Invalid input!"
	fi
done
