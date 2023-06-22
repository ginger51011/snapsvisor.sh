#!/bin/bash

# Check requirements
# List of required commands
commands=("pandoc" "pdfbook2")

# Check if each command is available
for cmd in "${commands[@]}"; do
    # The 'command -v' will return success if the command is found
    if ! command -v $cmd &> /dev/null; then
        echo "$cmd is required but it's not installed. Please install it and run the script again."
        exit 1
    fi
done

# Count the number of markdown files in the songs/ directory
num_songs=$(find songs/ -name '*.md' | wc -l)

# Count the number of lines in songorder.txt
num_order=$(wc -l < songorder.txt)

# Check if the number of songs is less than the number of lines in songorder.txt
if (( num_songs < num_order )); then
    echo "Warning: There are less markdown files in the songs/ directory than lines in songorder.txt. A song might be missing."
fi

OUTPUT_PATH=${1:-"sanghafte.pdf"}

# read each line from songorder.txt
while IFS= read -r line
do
    # check if the line starts with "songs/"
    if [[ $line != songs/* ]]; then
        echo "Warning: '$line' does not start with 'songs/'. Prepending 'songs/' to it."
        line="songs/$line"
    fi

    # check if the file exists
    if [[ ! -f $line ]]; then
        echo "Warning: '$line' does not exist."
    else
        # add to array of songs
        songs+=("$line")
    fi
done < songorder.txt

# Create PDF
echo "Creating PDF..."
pandoc settings.yaml "${songs[@]}" -o $OUTPUT_PATH

# Make it a booklet
echo "Creating booklet..."
pdfbook2 $OUTPUT_PATH && echo "Booklet available at $OUTPUT_PATH"

# Open the PDF if we have XDG
if xdg-open --version &> /dev/null; then
  xdg-open $OUTPUT_PATH
fi
