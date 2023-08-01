#!/usr/bin/env bash

# Define the repository and script name
repository='https://github.com/your_username/your_repository.git'
script_name='main_setup.sh'

# Define the install command based on the operating system
case "$OSTYPE" in
  darwin*)   
    install_cmd="brew install"
    ;; 
  linux*)    
    install_cmd="sudo apt install -y"
    ;;
  *)         
    echo "Unsupported OS type, aborting setup..."
    exit 1
    ;;
esac

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git not found, installing..."
    $install_cmd git
fi

# Clone the repository
if git clone "$repository" 2>/dev/null ; then 
    echo "Cloned: $repository"
else
    echo "Failed to clone: $repository"
    exit 1
fi

# Extract repo name from the repository URL
repo_name=$(basename "$repository" ".git")

# Change directory to the cloned repository
cd "$repo_name"

# Check if the script exists and is executable
if [[ -f $script_name && -x $script_name ]]; then
    echo "Running the script: $script_name"
    ./$script_name
else
    echo "The script: $script_name does not exist or is not executable"
    exit 1
fi
