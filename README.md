# 🐘 Elephant Ops 🐘 <br>Updated version of OpsSchool cpastone project
This project includes the terraform configuration and ansible playbooks for provisioning and configurting the environment for OpsSchool capstone project. 


## Pre-requisites
1. Local Terrafrom  installation.
2. Use the provided requirements.txt file to install ansible locally. 
`pip install -r requirements.txt`


## Usage
1. Create encrypted s3 bucket with dynamoDB based locking mechanism to hold the state of the TF configuration remotely 
```
cd terrafom/s3
tf init
tf apply --auto-aprove
```