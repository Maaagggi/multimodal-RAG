#!/bin/bash

# This script installs the required Python packages and system dependencies

# Function to install poppler-utils based on the operating system
install_poppler() {
    echo "Installing poppler-utils..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # For Ubuntu/Debian
        sudo apt-get update
        sudo apt-get install -y poppler-utils
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # For macOS
        brew install poppler
    else
        echo "Poppler installation is not supported for this OS."
        echo "Please install poppler-utils manually."
    fi
}

# Install Python requirements
echo "Installing Python packages from requirements.txt..."
pip install -r requirements.txt

# Install poppler-utils
install_poppler

echo "Installation completed!"
