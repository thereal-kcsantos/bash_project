#!/bin/bash

###########################################################################
### THIS DOES NOT WORK. KEEPING THIS IN THE REPO FOR HISTORICAL RECORDS ###
###########################################################################



# Define the alias name, the response message, and the installation directory for the response script
TARGET_ALIAS="hey"
ALIAS_RESPONSE="what's up"  # Customize the alias response message here
RESPONSE_INSTALL_DIR="$HOME"  # Customize the installation directory for the response script here

# Define the full path for the response script
RESPONSE_FILE="$RESPONSE_INSTALL_DIR/hey_response.sh"

# Create the response script with the custom response message
cat <<EOF > "$RESPONSE_FILE"
#!/bin/bash
echo "$ALIAS_RESPONSE"
EOF

# Make the response script executable
chmod +x "$RESPONSE_FILE"
echo "Response script '$RESPONSE_FILE' created and made executable in $RESPONSE_INSTALL_DIR."

# Track which files were updated or created
files_changed=()
files_to_create=()

# Check if configuration files exist and note which ones to create if none exist
if [ ! -e ~/.zshrc ] && [ ! -e ~/.bashrc ] && [ ! -e ~/.bash_profile ]; then
    echo "None of the configuration files exist. Creating ~/.zshrc and ~/.bashrc."
    touch ~/.zshrc
    touch ~/.bashrc
    files_to_create+=("~/.zshrc" "~/.bashrc")
fi

# Function to add the alias directly to a file if it doesn't already exist
add_alias_if_not_exists() {
    local file=$1
    # Check if the alias already exists in the file
    if ! grep -q "alias $TARGET_ALIAS=" "$file"; then
        echo "alias $TARGET_ALIAS='/bin/bash \"$RESPONSE_FILE\"'" >> "$file"
        echo "The '$TARGET_ALIAS' alias has been added to $file."
        files_changed+=("$file")  # Track the modified file
    else
        echo "The '$TARGET_ALIAS' alias already exists in $file."
    fi
}

# Add alias to each configuration file if it exists
for config_file in ~/.zshrc ~/.bashrc ~/.bash_profile; do
    if [ -e "$config_file" ]; then
        add_alias_if_not_exists "$config_file"
    fi
done

# Output which files were changed and source each one that was modified
if [ ${#files_changed[@]} -gt 0 ]; then
    echo "Files updated: ${files_changed[@]}"
    for file in "${files_changed[@]}"; do
        source "$file"
        echo "Configuration reloaded from $file."
    done
else
    echo "No files were modified."
fi

# Output which files were created
if [ ${#files_to_create[@]} -gt 0 ]; then
    echo "Files created: ${files_to_create[@]}"
fi

exit 0