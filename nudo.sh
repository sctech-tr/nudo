#!/bin/bash

# Function to get the name of the user who invoked sudo
get_sudo_user() {
    if [ -n "$SUDO_USER" ]; then
        echo "$SUDO_USER"
    elif [ -n "$LOGNAME" ]; then
        echo "$LOGNAME"
    else
        echo "$USER"
    fi
}

# Function to execute command as normal user
run_as_normal_user() {
    local normal_user
    normal_user=$(get_sudo_user)
    if [ "$normal_user" = "root" ]; then
        echo "Error: Unable to determine non-root user." >&2
        exit 1
    fi
    su - "$normal_user" -c "$*"
}

# Main script logic
if [ "$EUID" -eq 0 ]; then
    # If root, run command as normal user
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <command>" >&2
        exit 1
    fi
    run_as_normal_user "$*"
else
    # If normal user, just execute the command
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <command>" >&2
        exit 1
    fi
    eval "$@"
fi
