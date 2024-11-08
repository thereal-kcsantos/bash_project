#!/bin/bash

# This script was intended to be flexible. If you want to re-use this script to define any other
# command + response, you can do so by changing the $TARGET_COMMAND and $COMMAND_RESPONSE variables
#
# If using Jamf Pro, you can change the $TARGET_COMMAND variable below to $4, 
# and $COMMAND_RESPONSE to $5, then define the command you want to create with the indended response
# in the Jamf Policy > Script > Parameter 4 + Parameter 5 sections
# 
# ie: 
# TARGET_COMMAND="$4" 
# COMMAND_RESPONSE="$5"

# Define the target command and response message
TARGET_COMMAND="hey"
COMMAND_RESPONSE="what's up"

# Define the path where the command will be created
TARGET_FILE="/usr/local/bin/$TARGET_COMMAND"

# Display the configured variables
echo "Configured variables:"
echo "TARGET_COMMAND: $TARGET_COMMAND"
echo "COMMAND_RESPONSE: $COMMAND_RESPONSE"
echo "TARGET_FILE: $TARGET_FILE"

# Check if the command already exists
if [ -e "$TARGET_FILE" ]; then
    echo "A '$TARGET_COMMAND' command already exists at '$TARGET_FILE'. Script will stop running."
    exit 0  # Exit with success code since no error occurred
fi

# Identify the currently logged-in user
LOGGED_IN_USER=$(stat -f "%Su" /dev/console)
echo "Logged-in user detected: $LOGGED_IN_USER"

# Attempt to create the command script with the response
if echo "#!/bin/bash" > "$TARGET_FILE" && echo "echo \"$COMMAND_RESPONSE\"" >> "$TARGET_FILE"; then
    # Change ownership to the logged-in user and set permissions
    chown "$LOGGED_IN_USER":staff "$TARGET_FILE"
    chmod 750 "$TARGET_FILE"  # Owner and root can execute, others cannot
    echo "Command '$TARGET_COMMAND' created at '$TARGET_FILE' with response '$COMMAND_RESPONSE'."
    echo "Permissions set for user '$LOGGED_IN_USER' to execute the command."
    exit 0  # Exit with success code
else
    echo "Error: Failed to create command '$TARGET_COMMAND' at '$TARGET_FILE'." >&2
    exit 1  # Exit with failure code
fi