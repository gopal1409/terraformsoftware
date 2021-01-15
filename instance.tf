resource "aws_key_pair" "mykey" {
    key_name = "mykey"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}
resource "aws_instance" "example" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    key_name = aws_key_pair.mykey.key_name

    provisioner "file" { #this will copy and shell script in the provisioning machine
        source = "script.sh" #source of the shell script
        destination = "/tmp/script.sh" #inside the virtual machine it is launching in tmp directory it will store your shell script
    }
    provisioner "remote-exec" { #once the instance is being launch we need to run the shell script
        inline = [ #inline will read your shell script line by line
            "chmod +x /tmp/script.sh" #we will make the shell script executable
            "sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
              "sudo /tmp/script.sh",
        ]
    }
   connection {
       host = coalesce(self.public_ip,self.private.ip)
       type = "ssh"
       user = var.INSTANCE_USERNAME
       private_key = file(var.PATH_TO_PRIVATE_KEY)
   }
}