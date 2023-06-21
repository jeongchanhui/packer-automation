variable "vpc_id" {
  description = "ami가 생성될 vpc id"
  type        = string
  default     = "vpc-025cd5db9ce467298"
}

variable "vpc_subnet_id" {
  description = "ami가 생성될 subnet id"
  type        = string
  default     = "subnet-0e5dc312d5f5fc8d2"
}

variable "aws_region" {
  description = ""
  type        = string
  default     = "ap-northeast-2"

}
