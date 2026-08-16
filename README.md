# SecondChance Marketplace

SecondChance is a full-stack marketplace application for listing, searching, and sharing second-hand items. The project includes a Node.js/Express backend, a React frontend, a static frontend server, MongoDB integration, Docker packaging, and Terraform-managed AWS infrastructure for running the application on ECS Fargate.

## Project Overview

The application is split into three main runtime components:

- `secondChance-backend/`: Express API service for items, search, authentication, image hosting, health checks, and MongoDB access.
- `secondChance-frontend/`: React client application for users to browse, search, view, register, log in, and manage SecondChance items.
- `secondchancewebsite/`: Express static server used to serve the production React build on port `9000`.

The infrastructure code in `infra/` provisions the AWS resources needed to run the backend and frontend containers behind an Application Load Balancer.

## Architecture

```text
Users
  |
  v
Application Load Balancer :80
  |-- /, frontend routes ---------------> ECS Fargate frontend service :9000
  |-- /api/* and /images/* -------------> ECS Fargate backend service :3060
                                             |
                                             v
                                      MongoDB Atlas
```

AWS resources managed by Terraform:

- VPC with two public subnets
- Internet gateway and public route table
- Application Load Balancer
- Backend and frontend target groups
- ECS cluster
- ECS Fargate task definitions and services
- ECR repositories for backend and frontend images
- IAM task execution role
- SSM parameters for MongoDB URL and JWT secret
- CloudWatch log groups
- CloudWatch alarms and dashboard

## Repository Structure

```text
.
├── infra/                    # Terraform root module for AWS infrastructure
├── secondChance-backend/      # Node.js/Express API service
├── secondChance-frontend/     # React frontend source
├── secondchancewebsite/       # Static server for the built frontend
├── sentiment/                 # Sentiment-related Node.js service/code
├── deploymongo.yml            # MongoDB-related deployment manifest
├── package.json               # Root-level dependencies
└── README.md
```

## Backend API

The backend runs on port `3060`.

Main routes:

- `GET /health`: service health check used by the load balancer
- `GET /api/secondchance/Items`: list all marketplace items
- `POST /api/secondchance/Items`: create a new item
- `GET /api/secondchance/Items/:id`: get one item
- `PUT /api/secondchance/Items/:id`: update an item
- `DELETE /api/secondchance/Items/:id`: delete an item
- `GET /api/secondchance/search`: search items by query filters
- `POST /api/auth/register`: register a user
- `POST /api/auth/login`: log in and receive a JWT
- `PUT /api/auth/update`: update user profile information

## Environment Variables

Create a `.env` file for local backend development in `secondChance-backend/`.

```env
MONGO_URL=mongodb+srv://<user>:<password>@<cluster-url>/
MONGO_DB=secondChance
MONGO_COLLECTION=secondChanceItems
JWT_SECRET=<replace-with-a-long-random-secret>
```

For AWS deployment, Terraform stores `MONGO_URL` and `JWT_SECRET` in AWS Systems Manager Parameter Store and injects them into the ECS backend task definition as secrets.

## Local Development

Install dependencies:

```bash
cd secondChance-backend
npm install
```

Run the backend:

```bash
npm run dev
```

In a second terminal, run the React frontend:

```bash
cd secondChance-frontend
npm install
npm start
```

The backend listens on `http://localhost:3060`.

## Build the Frontend for Production

```bash
cd secondChance-frontend
npm install
npm run build
```

The frontend `postbuild` script copies the React build output into `secondchancewebsite/build`.

Run the static frontend server:

```bash
cd secondchancewebsite
npm install
node index.js
```

The static frontend server listens on `http://localhost:9000`.

## Docker

Build the backend image:

```bash
docker build -t secondchance-backend ./secondChance-backend
```

Build the frontend static server image:

```bash
docker build -t secondchance-frontend ./secondchancewebsite
```

## Terraform Infrastructure

The Terraform code lives in `infra/`. This directory is the Terraform root module.

Copy the example variables file:

```bash
cd infra
cp terraform.tfvars.example terraform.tfvars
```

Add the sensitive values locally:

```hcl
mongodb_url = "mongodb+srv://<user>:<password>@<cluster-url>/"
jwt_secret  = "<replace-with-a-long-random-secret>"
```

Initialize and validate Terraform:

```bash
terraform init
terraform validate
```

Review and apply the plan:

```bash
terraform plan
terraform apply
```

Useful outputs:

- `backend_ecr_repository_url`
- `frontend_ecr_repository_url`
- `backend_alb_dns_name`
- `backend_url`

## AWS Deployment Flow

1. Provision the base infrastructure from `infra/`.
2. Build Docker images for the backend and frontend static server.
3. Push images to the ECR repositories created by Terraform.
4. Set `backend_image_tag` and `frontend_image_tag` in Terraform variables.
5. Run `terraform apply` to update the ECS task definitions and services.
6. Open the ALB URL from the Terraform output.

The Application Load Balancer routes frontend traffic to the frontend ECS service and routes `/api/*` plus `/images/*` traffic to the backend ECS service.

## Monitoring

CloudWatch is configured for:

- Backend ECS logs
- Frontend ECS logs
- ALB 5xx alarms
- ALB response time alarms
- Target group healthy host alarms
- ECS CPU and memory alarms
- A CloudWatch dashboard for service visibility

## Security Notes

- Do not commit `.env`, `.tfvars`, Terraform state files, or AWS credentials.
- Keep `JWT_SECRET` and `MONGO_URL` in SSM Parameter Store for ECS.
- Rotate MongoDB credentials if they were ever exposed locally or in screenshots.

## License

This project includes the original course project license in `LICENSE`.
