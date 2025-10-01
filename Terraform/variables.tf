variable "region" {
  type    = string
  default = "us-east-1"
}
 
variable "cluster_name" {
  type    = string
  default = "secure-node-cluster"
}
 
variable "vpc_id" { type = string }
variable "private_subnets" { type = list(string) }
