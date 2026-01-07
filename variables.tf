variable "aws_cluster_name" {
  description = "O nome do cluster EKS na AWS."
  type        = string
  default     = "fiap-soat-eks-cluster" 
}

variable "aws_region" {
  description = "A região da AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-2" 
}

variable "instance_type" {
  description = "O tipo da instância EC2 para os worker nodes do EKS."
  type        = string
  default     = "t3.micro" 
}

variable "desired_size" {
  description = "Número desejado de worker nodes no grupo de nós."
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Número mínimo de worker nodes no grupo de nós."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Número máximo de worker nodes no grupo de nós."
  type        = number
  default     = 5
}
