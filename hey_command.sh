#!/bin/bash

# Define the target command and response message
TARGET_COMMAND="hey"
COMMAND_RESPONSE="what's up"

# Define the path where the command will be created
TARGET_FILE="/usr/local/bin/$TARGET_COMMAND"

# Create the command script with the response and make it executable
echo "#!/bin/bash" > "$TARGET_FILE"
echo "echo \"$COMMAND_RESPONSE\"" >> "$TARGET_FILE"
chmod +x "$TARGET_FILE"

echo "Command '$TARGET_COMMAND' created at '$TARGET_FILE' with response '$COMMAND_RESPONSE'."