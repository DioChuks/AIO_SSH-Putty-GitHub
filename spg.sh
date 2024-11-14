#!/bin/bash

# Function to display an error message and exit
error_exit() {
  echo "$1" 1>&2
  exit 1
}

# Check if SSH access is enabled
echo "Please ensure that SSH access is enabled for your hosting account (e.g., cPanel)."
echo "Contact your hosting provider or toggle the remote access permission via cPanel if needed."
echo "Proceeding to the next step..."

# Generate SSH key pair
echo "Generating a new SSH key pair using the Ed25519 algorithm..."
read -p "Enter your email address (e.g., your_email@example.com): " email

# Validate email input
if [[ -z "$email" ]]; then
  error_exit "Email address cannot be empty. Exiting script."
fi

# Generate the SSH key pair
ssh-keygen -t ed25519 -C "$email" || error_exit "Failed to generate SSH key. Exiting script."

# Add a passphrase to the SSH key
echo "You will now be prompted to set a passphrase for your SSH key."
echo "A passphrase is recommended for extra security, but you can press Enter to skip."

# Display instructions to add the public key to GitHub
echo "Now that your SSH key pair is generated, you need to add the public key to your GitHub account."
echo "To do this, follow these steps:"
echo "  1. Display the public key with: cat ~/.ssh/id_ed25519.pub"
echo "  2. Copy the key and go to GitHub: https://github.com/settings/keys"
echo "  3. Click 'New SSH key' and paste your public key there."
echo "Please complete this step on GitHub, then press Enter to continue."
read -p "Press Enter to continue..."

# Handle private key and convert to PuTTY format (manual steps)
echo "Next, you need to handle your private key based on your client setup."

echo "If you want to use the private key with PuTTY, you will need to convert it."
echo "If you are using a standard SSH client, skip this step."
echo "Do you want to convert the key to PuTTY format? (y/n)"
read -p "Enter your choice: " convert_choice

if [[ "$convert_choice" == "y" || "$convert_choice" == "Y" ]]; then
  echo "Please open PuTTYgen, click on 'Conversions' > 'Import key', and select the private key located at ~/.ssh/id_ed25519."
  echo "Once imported, click 'Save private key' and save it as a .ppk file."
  echo "Once that's done, you can use this .ppk file in PuTTY."
  echo "After saving your private key as .ppk, press Enter to continue."
  read -p "Press Enter to continue..."
fi

# PuTTY Configuration (manual steps)
echo "Now, open PuTTY and configure your connection."
echo "In PuTTY, go to the 'Session' section and enter the host address (e.g., your server's IP)."
echo "Then, go to 'SSH' > 'Auth' and browse to select your saved private key (either the .ppk file or the standard private key)."
echo "Make sure you save the session configuration and connect using PuTTY."
echo "If prompted for a password, enter the password and proceed."

# Configure SSH agent and add public key
echo "Now let's configure the SSH agent to use your key."

echo "Please ensure your SSH client is running, and your session is open."
echo "Run the following command to start the SSH agent:"

echo "  eval \"\$(ssh-agent -s)\""

echo "Then, add the SSH private key to the agent by running this command (replace with your key's name):"

echo "  ssh-add ~/.ssh/id_ed25519"

echo "Note: If you're using a different private key, replace id_ed25519 with your actual key name."

# Test the SSH connection with GitHub
echo "Now let's test your connection to GitHub to ensure everything is working."

echo "Run the following command to test the connection:"

echo "  ssh -vT git@github.com"

echo "If your connection is successful, you should see a message like this:"
echo "  Hi USERNAME! You've successfully authenticated, but GitHub does not provide shell access."
echo "This confirms your SSH key is working correctly."

# Check SSH Key Algorithms
echo "Finally, make sure that the key algorithms you use are SHA-2, RSA, or ECDSA."
echo "Older algorithms like SHA-1 are not allowed by GitHub."

# Final message
echo "SSH setup for GitHub is complete!"
echo "You can now use your SSH key to push, pull, and interact with GitHub repositories securely."
