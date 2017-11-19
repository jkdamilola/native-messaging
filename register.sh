#!/bin/sh

set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
if [ "$(uname -s)" = "Darwin" ]; then
  if [ "$(whoami)" = "root" ]; then
    TARGET_DIR="/Library/Google/Chrome/NativeMessagingHosts"
  else
    TARGET_DIR="$HOME/Library/Application Support/Google/Chrome/NativeMessagingHosts"
  fi
else
  if [ "$(whoami)" = "root" ]; then
    TARGET_DIR="/etc/opt/chrome/native-messaging-hosts"
  else
    TARGET_DIR="$HOME/.config/google-chrome/NativeMessagingHosts"
  fi
fi

HOST_NAME=com.timedoctor.desktop

# Create directory to store native messaging host.
mkdir -p "$TARGET_DIR"

# Copy native messaging host manifest.
cp "$DIR/$HOST_NAME.json" "$TARGET_DIR"

# Set permissions for the manifest so that all users can read it.
chmod o+r "$TARGET_DIR/$HOST_NAME.json"

echo "Native messaging host $HOST_NAME has been installed."