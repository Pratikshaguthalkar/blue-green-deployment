# Blue-Green-Deployment

### Create Security Group

![1731052796586](image/README/1731052796586.png)

### Create 4 EC2 instances

1. Jenkins
2. SonarQube
3. Nexus
4. Server

#### Setup Server Instance

1. Update Server

   ```
   sudo apt update -y
   ```
2. Install AWS cli

   ```
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```
3. Configure AWS Credentials
