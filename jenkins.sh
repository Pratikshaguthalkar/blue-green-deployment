#!/bin/bash

# Script to install Jenkins on a Debian-based system

# Step 1: Add the Jenkins GPG key
echo "Adding Jenkins GPG key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
if [ $? -ne 0 ]; then
  echo "Error: Failed to download the Jenkins GPG key." >&2
  exit 1
fi

# Step 2: Add the Jenkins repository to the sources list
echo "Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
if [ $? -ne 0 ]; then
  echo "Error: Failed to add the Jenkins repository." >&2
  exit 1
fi

# Step 3: Update the package list
echo "Updating package list..."
sudo apt-get update
if [ $? -ne 0 ]; then
  echo "Error: Failed to update package list." >&2
  exit 1
fi

# Step 4: Install Jenkins
echo "Installing Jenkins..."
sudo apt-get install jenkins -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Jenkins." >&2
  exit 1
fi

# Step 5: Install necessary dependencies (fontconfig and OpenJDK 11)
echo "Installing required dependencies (fontconfig and OpenJDK 11)..."
sudo apt install fontconfig openjdk-11-jre -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install dependencies (fontconfig or OpenJDK)." >&2
  exit 1
fi

# Step 6: Check if Java is already installed, if not, check the version
echo "Checking Java version..."
if ! java -version &>/dev/null; then
  echo "Java not found, installing OpenJDK 11..."
  sudo apt install openjdk-11-jre -y
  if [ $? -ne 0 ]; then
    echo "Error: Failed to install OpenJDK 11." >&2
    exit 1
  fi
else
  echo "Java is already installed."
fi

# Verify the Java version
java -version
if [ $? -ne 0 ]; then
  echo "Error: Java is not installed correctly." >&2
  exit 1
fi

# Step 7: Start Jenkins service
echo "Starting Jenkins service..."
sudo systemctl start jenkins
if [ $? -ne 0 ]; then
  echo "Error: Failed to start Jenkins service." >&2
  exit 1
fi

# Step 8: Enable Jenkins service to start on boot
echo "Enabling Jenkins to start on boot..."
sudo systemctl enable jenkins
if [ $? -ne 0 ]; then
  echo "Error: Failed to enable Jenkins service on boot." >&2
  exit 1
fi

# Step 9: Provide Jenkins access info
echo "Jenkins installed successfully!"
echo "Access Jenkins by navigating to: http://localhost:8080"
echo "To unlock Jenkins, retrieve the initial admin password using the following command:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"

# Optional: Verify Jenkins version
echo "Verifying Jenkins installation..."
sudo systemctl status jenkins || { echo "Jenkins service is not running!" >&2; exit 1; }
echo "Jenkins version:"
sudo jenkins --version || echo "Error: Unable to retrieve Jenkins version."

# Script ends
exit 0
