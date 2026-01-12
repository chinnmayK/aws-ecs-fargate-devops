# DevTrack – End-to-End Deployment on AWS ECS Fargate

This document is the **final consolidated README** for the DevTrack project. It explains **everything that was done**, from local development to containerization, AWS infrastructure provisioning, deployment, debugging, cleanup, and redeployment — explained **phase-wise** in a clean, production-oriented manner.

---

## 🧠 Project Overview

**DevTrack** is a Node.js web application deployed using:

* Docker (containerization)
* Amazon ECR (image registry)
* Amazon ECS with Fargate (serverless containers)
* Application Load Balancer (public access)
* AWS CloudFormation (Infrastructure as Code)

The goal of this project was to **build, deploy, break, debug, clean, and redeploy** a real-world ECS Fargate application — gaining hands-on experience with AWS DevOps workflows.

---

## 🧩 PHASE 0 – Prerequisites & Setup

### What was done

* Created an AWS account
* Installed and configured AWS CLI
* Created IAM user with programmatic access
* Configured AWS credentials locally
* Selected **us-east-1** as the working region

### Outcome

A ready-to-use AWS environment for CLI-driven DevOps work.

---

## 🧩 PHASE 1 – Application Development (Local)

### What was done

* Built a simple **Node.js + Express** application
* Created a root (`/`) endpoint for UI
* Added a `/health` endpoint for load balancer health checks
* Configured the app to run on port **3000** internally
* Verified the app works locally

### Outcome

A working backend application suitable for container deployment.

---

## 🧩 PHASE 2 – Containerization with Docker

### What was done

* Created a **Dockerfile** using `node:18-alpine`
* Installed **PM2** for process management
* Installed **Nginx** as a reverse proxy
* Configured Nginx to listen on **port 80**
* Proxied traffic from Nginx → Node app (port 3000)
* Exposed only port **80** from the container
* Tested the container locally

### Outcome

A production-ready Docker image with proper port handling.

---

## 🧩 PHASE 3 – Amazon ECR (Elastic Container Registry)

### What was done

* Created an ECR repository for DevTrack
* Authenticated Docker to AWS ECR
* Built the Docker image locally
* Tagged the image for ECR
* Pushed the image to ECR

### Outcome

Docker images securely stored and accessible by ECS.

---

## 🧩 PHASE 4 – Infrastructure as Code (CloudFormation)

### What was done

* Chose CloudFormation as the **single source of truth**
* Created a CloudFormation template to define:

  * ECS Cluster
  * Task Definition (Fargate)
  * ECS Service
  * IAM Execution Role
  * Security Groups
  * Networking configuration (VPC + Subnet)
* Parameterized the ECR image URI

### Outcome

Repeatable, version-controlled infrastructure creation.

---

## 🧩 PHASE 5 – ECS Fargate Deployment

### What was done

* Deployed CloudFormation stack via AWS CLI
* Created ECS cluster automatically
* Launched ECS service using Fargate
* Ran container in **awsvpc** network mode
* Assigned public IP to the task

### Outcome

Application successfully running inside ECS Fargate.

---

## 🧩 PHASE 6 – Application Load Balancer (ALB)

### What was done

* Created an Application Load Balancer
* Attached ALB to public subnet
* Created a Target Group (IP-based)
* Configured health checks (`/health`)
* Connected ECS Service to Target Group
* Configured security groups:

  * ALB allows inbound HTTP (80)
  * ECS allows inbound traffic from ALB

### Outcome

Public access enabled using ALB DNS name.

---

## 🧩 PHASE 7 – Debugging & Failure Analysis

### Issues encountered

* 503 Service Unavailable errors
* ECS tasks constantly draining
* Target group showing unhealthy tasks
* Duplicate security groups created
* CloudFormation stack stuck in UPDATE_IN_PROGRESS

### Root causes identified

* Port mismatch (3000 vs 80)
* Missing `/health` endpoint
* Incorrect containerPort in ECS service
* Security group dependency conflicts
* Resources created outside CloudFormation

### Outcome

Deep understanding of ECS + ALB failure modes.

---

## 🧩 PHASE 8 – Forced Cleanup & Reset

### What was done

* Stopped running ECS services
* Deleted ECS cluster
* Deleted ALB listeners and load balancer
* Deleted target groups
* Removed orphaned security groups
* Verified no ECS, ALB, SG resources remained

### Outcome

Clean AWS account state with no dangling resources.

---

## 🧩 PHASE 9 – Fresh Redeployment (Correct Way)

### What was done

* Redeployed CloudFormation stack from scratch
* Ensured unique logical names
* Verified task definition port = 80
* Verified Nginx listens on 80
* Verified Node app proxied internally
* Ensured ALB health checks passed

### Outcome

Stable ECS service with healthy targets.

---

## 🧩 PHASE 10 – Validation & Testing

### What was done

* Verified ECS task state = RUNNING
* Verified target group = HEALTHY
* Tested ALB DNS in browser
* Tested `/health` endpoint
* Verified no manual AWS resource drift

### Outcome

Fully functional production-grade deployment.

---

## 🏁 Final Architecture Summary

* **Application**: Node.js + Express
* **Container**: Docker + PM2 + Nginx
* **Registry**: Amazon ECR
* **Compute**: ECS Fargate
* **Networking**: VPC + Public Subnet + ALB
* **IaC**: AWS CloudFormation

---

## 🎯 Key Learnings

* ECS health checks must match container behavior
* ALB + ECS requires strict port alignment
* CloudFormation must own all resources
* Improper cleanup causes cascading failures
* Debugging AWS infra is a critical DevOps skill

---

## ✅ Project Status

✔ Successfully deployed
✔ Fully cleaned and redeployed
✔ Production-ready
✔ Infrastructure reproducible

---

**Author:** Chinmay K
