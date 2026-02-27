#!/bin/sh
# wrapper that injects default user-agent if not provided explicitly
# default string reflects requested UA for Windows/Chrome
DEFAULT_USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
UA_FLAG="--user-agent=${USER_AGENT:-$DEFAULT_USER_AGENT}"

# if the user already passed a --user-agent argument, skip injecting
for arg in "$@"; do
    case $arg in
        --user-agent=*)
            UA_FLAG=""
            break
            ;;
    esac
done

exec "$@" $UA_FLAG
