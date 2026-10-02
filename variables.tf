variable "project_name" {
  description = "Name used to identify Project 1 AWS resources"
  type        = string
  default     = "project1"
}

variable "aws_region" {
  description = "AWS region where Project 1 is deployed"
  type        = string
  default     = "us-east-1"
}

variable "app_port" {
  description = "Port used by the Node.js application"
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Port used by PostgreSQL"
  type        = number
  default     = 5432
}

variable "instance_type" {
  description = "EC2 instance type used by the application servers"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Normal desired number of EC2 application servers"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 4
}

variable "db_instance_class" {
  description = "RDS PostgreSQL instance class"
  type        = string
  default     = "db.t4g.micro"
}