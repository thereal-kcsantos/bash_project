# hey_command
Some random tasks.... Maybe application/practice stuff? :wink::wink:

# Purpose
I'm trying some things out here. I want to use this repo to track my changes (and maybe my thought process) as I try to accomplish "the thing".

# Task (aka "The Thing)

An employee runs the command “hey” in their terminal, and we want it to respond with “what’s up." Please write a shell-script that we can deploy through MDM (which runs as root) to implement this.


# Thought Process

## Attempt 1:
Configure the `~/.zshrc`, `~/.bashrc`, and/or `~/.bash_profile` aliases to output the "What's Up" response.
### Result
Not so great, can't escape the apostrophe in What's up. Getting response of "'whats up\"

## Attempt 1.1
While still using the zsh/bash profile aliases, try to have the "hey" command run a script that creates another script so I can use something like "alias=hey "/bin/bash hey_response.sh""
### Result
Testing doesn’t seem to work. Regardless of how I try to comment out the apostrophe in the statement, it seems that it is not translating well when outputting it to the terminal, and in return, not giving the output of “What’s up”. Also, code looks messy and ugle with all the "escapes"

Need to think more... this feels like I am going about it in a very complicated way, more complicated than it needs to be.


## Attempt 2
Aliases didn't work, so the other way I'll try is by creating a executable in `/usr/local/bin/`
I found this to work:
```
echo '#!/bin/bash' > /usr/local/bin/hey
echo 'echo "what'\''s up"' >> /usr/local/bin/hey
```
### Result
First iteration worked. Was able to get the response we wanted
**Note**: For full disclosure:
due to the sake of saving time, I used ChatGPT to help me piece this together.

### Refinement
Refined script to be reusable. 
Added functions:
- Check to see if "hey" execuable is present in /usr/local/bin/
- Identify logged-in user, chmod 750 so that only the logged in user and root are allowed to use executable
- Added echos to track progress of script
- added exit codes
- added comments for Jamf Config
