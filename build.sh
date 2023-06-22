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
TMPFILE=${mktmp "/tmp/sanghafte-XXXXX.pdf"}

# Create PDF
echo "Creating PDF..."
pandoc settings.yaml $(cat songorder.txt) -o $TMPFILE

# Make it a booklet
echo "Creating booklet..."
pdfbook2 $TMPFILE
cp $TMPFILE $OUTPUT_PATH
rm $TMPFILE
