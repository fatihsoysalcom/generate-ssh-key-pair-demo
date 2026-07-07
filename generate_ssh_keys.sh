#!/bin/bash

# This script demonstrates how to generate an SSH key pair using ssh-keygen.
# It creates a temporary directory for the keys to avoid cluttering your ~/.ssh folder.

# --- Configuration ---
KEY_NAME="my_example_ssh_key"
TEMP_DIR="temp_ssh_keys_demo"
# ---------------------

echo "--- SSH Key Pair Generation Demo ---"
echo "This script will generate an SSH key pair in a temporary directory."
echo "No passphrase will be set for demonstration purposes, but it's recommended in real use."
echo ""

# Create a temporary directory for the keys
mkdir -p "$TEMP_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Could not create temporary directory '$TEMP_DIR'."
    exit 1
fi
echo "Created temporary directory: $TEMP_DIR"
echo ""

# Generate the SSH key pair
# -t rsa: Specifies the type of key to create (RSA is common and secure)
# -b 4096: Specifies the number of bits in the key (4096 is a strong size)
# -f: Specifies the filename of the generated key file
# -N "": Provides an empty passphrase (for demonstration, usually you'd use a strong passphrase)
# -q: Quiet mode, suppresses progress meter
echo "Generating SSH key pair '$KEY_NAME' (RSA, 4096 bits)..."
ssh-keygen -t rsa -b 4096 -f "$TEMP_DIR/$KEY_NAME" -N "" -q

if [ $? -ne 0 ]; then
    echo "Error: ssh-keygen failed. Do you have ssh-keygen installed and in your PATH?"
    rmdir "$TEMP_DIR" 2>/dev/null # Clean up empty dir if keygen failed early
    exit 1
fi
echo "Key pair generated successfully in '$TEMP_DIR'."
echo ""

echo "--- Generated Files ---"
ls -l "$TEMP_DIR"
echo ""

echo "--- Key Pair Explanation ---"
echo "1. Private Key (DO NOT SHARE!): '$TEMP_DIR/$KEY_NAME'"
echo "   This file contains your secret private key. It must be kept absolutely secure."
echo "   It's used to prove your identity when connecting to a server."
echo ""
echo "2. Public Key (Can be shared): '$TEMP_DIR/$KEY_NAME.pub'"
echo "   This file contains your public key. You place this on servers you want to access."
echo "   The server uses this public key to verify that you are who you claim to be,"
echo "   without ever needing your private key."
echo ""

echo "--- Public Key Content Example ---"
echo "The content of the public key file ($TEMP_DIR/$KEY_NAME.pub) is what you'd typically add to a server's ~/.ssh/authorized_keys file."
echo "Here's what it looks like:"
cat "$TEMP_DIR/$KEY_NAME.pub"
echo ""

echo "--- Cleaning Up ---"
echo "Removing temporary directory '$TEMP_DIR' and generated keys."
rm -rf "$TEMP_DIR"
echo "Cleanup complete."
echo ""
echo "--- Demo Finished ---"
