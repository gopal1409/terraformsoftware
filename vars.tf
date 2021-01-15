variable "AWS_REGION" {
    default = "us-east-2"
}

variable "AMIS" {
    type = map(string)
    default = {
        us-east-1 = "ami-0be2609ba883822ec" 
        us-west-1 = "ami-03130878b60947df3"
        us-east-2 = "ami-0a0ad6b70e61be944"
    }
}
variable "PATH_TO_PRIVATE_KEY"{
    default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
    default = "ec2-user"
}