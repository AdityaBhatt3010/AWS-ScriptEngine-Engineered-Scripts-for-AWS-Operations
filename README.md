# AWS-ScriptEngine: Engineered Scripts for AWS Operations

This repository contains a collection of Bash and PowerShell scripts for automating AWS services, including **AWS CLI setup, S3, EC2, and DynamoDB operations**. These scripts are designed for **Linux** and **Windows** environments to streamline AWS management tasks.

## 📌 Installation Instructions

### **For Linux (Ubuntu/Debian-based distros)**
1. Clone this repository:
   ```bash
   git clone https://github.com/AdityaBhatt3010/AWS-ScriptEngine.git
   cd AWS-ScriptEngine
   ```
2. Make scripts executable:
   ```bash
   chmod +x *.sh
   ```
3. Run the desired script:
   ```bash
   ./AWS_CLI_Set_Up_Linux.sh
   ```

### **For Windows**
1. Clone this repository:
   ```powershell
   git clone https://github.com/AdityaBhatt3010/AWS-ScriptEngine.git
   cd AWS-ScriptEngine
   ```
2. Run the desired script:
   ```powershell
   ./AWS_CLI_Set_Up_Windows.ps1
   ```
   If the script doesn't run, try:
   ```powershell
   Get-ExecutionPolicy -List
   ```
   If the policy is Undefined or Restricted, run the following command:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

---

## 📜 Available Scripts & Options

### **1️⃣ AWS CLI Setup**
- **Linux:** `AWS_CLI_Set_Up_Linux.sh`
- **Windows:** `AWS_CLI_Set_Up_Windows.ps1`
- **Functionality:**
  - Installs AWS CLI
  - Configures AWS credentials (Access Key, Secret Key, and Region)
  - Verifies installation

### **2️⃣ AWS S3 Management**
- **Linux:** `AWS_S3_Linux.sh`
- **Windows:** `AWS_S3_Windows.ps1`
- **Options Available:**
  - Get S3 bucket region
  - Upload and download files
  - Remove files
  - Create a new bucket
  - List all buckets
  - Check and enable bucket versioning
  - Retrieve object metadata

### **3️⃣ AWS EC2 Management**
- **Linux:** `AWS_EC2_Linux.sh`
- **Windows:** `AWS_EC2_Windows.ps1`
- **Options Available:**
  - Start/Stop/Terminate an EC2 instance
  - Create a new EC2 instance
  - List all key pairs and security groups
  - List running and stopped instances

### **4️⃣ AWS DynamoDB Management**
- **Linux:** `AWS_DynamoDB_Linux.sh`
- **Windows:** `AWS_DynamoDB_Windows.ps1`
- **Options Available:**
  - List tables
  - Create a table
  - Insert and retrieve items
  - Query and scan data
  - Delete an item

---

## 🚀 Contributing
Feel free to fork this repository and submit **pull requests** with improvements or additional AWS automation scripts!

