# Blue-Green-Deployment

### Create Security Group

![1731052796586](image/README/1731052796586.png)

### Create 4 EC2 instances

1. Jenkins
2. SonarQube
3. Nexus
4. Server

#### Setup Server Instance

* Update Server

  ```
  sudo apt update -y
  ```
* Install AWS cli

  ```
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  ```
* Configure AWS Credentials

  ```
  aws configure
  ```

  1. Access Key
  2. Secret Access Key
  3. Region
* Install Terraform

  ```
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update -y
  sudo apt-get install terraform -y
  ```
* Clone The Repo
* Modify Files

  1. variables.tf (Modify Private Key Name)
  2. main.tf (Modify Region name & Availabilty Zones)
* Apply Terraform Lifecycle

  1. `terraform init`
  2. `terraform plan`
  3. `terraform apply --auto-approve`

#### Setup Jenkins Server

* Run the script

  ```
  sudo bash jenkins.sh
  ```

#### Setup Nexus Server

1. Update the server

   ```
   sudo apt update -y
   ```
2. Install Docker

   ```
   # Add Docker's official GPG key:
   sudo apt-get update
   sudo apt-get install ca-certificates curl
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc

   # Add the repository to Apt sources:
   echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
     $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
     sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update -y
   ```

   ```
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```
3. Give permissions to Ubuntu user to run Docker commands

   ```
   sudo usermond -aG 
   ```
