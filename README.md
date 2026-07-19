# 🚀 GCP N-Tier Infrastructure using Terraform

This project demonstrates the design and deployment of a scalable N-tier architecture on Google Cloud Platform using Terraform. It includes networking, compute, and load balancing components following cloud best practices.

---

## 📌 Architecture Overview

User → Load Balancer → Managed Instance Group → VM Instances → Subnet → VPC

- **VPC**: Custom isolated network
- **Subnet**: Web layer hosting application instances
- **Managed Instance Group (MIG)**: Automatically manages VM instances
- **Load Balancer**: Distributes incoming traffic
- **Startup Script**: Installs and configures Nginx dynamically

---

## 🛠️ Technologies Used

- Google Cloud Platform (GCP)
- Terraform
- Compute Engine
- Managed Instance Groups (MIG)
- HTTP Load Balancer
- Ubuntu 22.04
- Nginx

---

## 🧱 Infrastructure Components

### 🔹 Networking
- Custom VPC
- Web Subnet
- Firewall rules for HTTP (80) and SSH (22)

### 🔹 Compute
- Instance Template
- Managed Instance Group (MIG)

### 🔹 Load Balancing
- Global HTTP Load Balancer
- Backend Service
- Health Check
- URL Map & Target Proxy

---

## ⚙️ How It Works

1. Terraform provisions VPC and subnet
2. Instance Template defines VM configuration
3. MIG creates and manages VM instances
4. Startup script installs Nginx on each VM
5. Load Balancer routes traffic to healthy instances

---

## 🚀 Deployment Steps


terraform init

terraform plan

terraform apply

🌐 Access the Application

After deployment:

Access via Load Balancer IP:

http://<LOAD_BALANCER_IP>

Or directly via VM:

http://<VM_EXTERNAL_IP>

🧪 Validation

Check backend health:

gcloud compute backend-services get-health web-backend --global

SSH into VM:

gcloud compute ssh <instance-name> --zone=asia-south1-a

🔐 Key Learnings

Designing multi-tier architecture in GCP

Using Terraform for Infrastructure as Code

Configuring Load Balancers and health checks

Debugging unhealthy backends

Working with Managed Instance Groups

📈 Future Improvements

Add HTTPS with SSL certificates

Enable autoscaling policies

Use private subnets with Cloud NAT

Integrate Cloud SQL (DB layer)

Implement CI/CD pipeline

👨‍💻 Author

Sai Kumar Thumma

LinkedIn: www.linkedin.com/in/saikumarthumma

GitHub: https://github.com/Sai2932000
