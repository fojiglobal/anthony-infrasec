# Variable for the VPC CIDR block
variable "vpc_cidr" {
  type = string
}

# Variable for the environment (e.g., dev, staging, prod)
variable "env" {
  type = string
}

################## Subnet Variables ####################

# Variable for public subnets configuration
variable "public_subnets" {
  type = map(object({
    cidr = string
    azs = string
    tags = map(string) 
  }))
}

# Variable for private subnets configuration
variable "private_subnets" {
  type = map(object({
    cidr = string
    azs = string
    tags = map(string) 
  }))
}

# Variable to determine if public IPs should be mapped
variable "map_public_ip" {
  type = bool
}

# Variable for the public subnet name
variable "pub-sub-name" {
  type = string
}

# Variable for the IPv4 CIDR block for all traffic
variable "all_ipv4_cidr" {
  type = string
}

# Variable for the AMI ID
variable "ami_id" {
  type = string
}

# Variable for the instance type
variable "instance_type" {
  type = string
}

# Variable for the SSH key to use for instances
variable "instance_key" {
  type = string
}

# Variable for user data script
variable "user_data" {
  type = string
}

# Variable for the minimum size of the auto-scaling group
variable "min_size"  {
  type = string
}

# Variable for the maximum size of the auto-scaling group
variable "max_size" {
  type = string
}

# Variable for the desired number of instances in the auto-scaling group
variable "desired" {
  type = number
}

# Variable for public security group ingress rules
variable "public_sg_ingress" {
  type = map(object({
    src = string
    from_port = number
    to_port = number
    ip_protocol = string
    description = string 
  }))
}

# Variable for public security group egress rules
variable "public_sg_egress" {
  type = map(object({
    dest = string
    ip_protocol = string
    description = string
  }))
}

# Variable for private security group ingress rules
variable "private_sg_ingress" {
  type = map(object({
    src = string
    from_port = number
    to_port = number
    ip_protocol = string
    description = string 
  }))
}

# Variable for private security group egress rules
variable "private_sg_egress" {
  type = map(object({
    dest = string
    ip_protocol = string
    description = string 
  }))
}

# Variable for bastion security group ingress rules
variable "bastion_sg_ingress" {
  type = map(object({
    src = string
    from_port = number
    to_port = number
    ip_protocol = string
    description = string 
  }))
}

# Variable for bastion security group egress rules
variable "bastion_sg_egress" {
  type = map(object({
    dest = string
    ip_protocol = string
    description = string
  }))
}

# Variable for the port for the HTTPS listener on the ALB
variable "alb_port_https" {
  description = "The port for the HTTPS listener"
  type        = number
}

# Variable for the protocol for the HTTPS listener on the ALB
variable "alb_proto_https" {
  description = "The protocol for the HTTPS listener on the ALB"
  type        = string
}

# Variable for the SSL policy for the HTTPS listener on the ALB
variable "alb_sss_profile" {
  description = "The SSL policy for the HTTPS listener on the ALB"
  type        = string
}

# Variable for the port for the HTTP listener on the ALB
variable "alb_port_http" {
  description = "The port for the HTTP listener on the ALB"
  type        = number
}

# Variable for the protocol for the HTTP listener on the ALB
variable "alb_proto_http" {
  description = "The protocol for the HTTP listener on the ALB"
  type        = string
}

# Variable for the Route 53 hosted zone ID
variable "zone_id" {
  type = string
}

# Variable for the ARN of the SSL certificate
variable "certificate_arn" {
  type = string
}