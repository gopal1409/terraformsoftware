resource "aws_key_pair" "mykey" { #this resource will attach and existing key pair to your instance
    key_name = "mykey" #this is the name of the key
    public_key = file(var.PATH_TO_PUBLIC_KEY) #it will look for the key in your current directory
}
resource "aws_instance" "example" { #will launch an instance
    ami = var.AMIS[var.AWS_REGION] #this ami field will come from var file
    instance_type = "t2.micro"
    key_name = aws_key_pair.mykey.key_name #once the instance it has launch it will attach the key pair

    provisioner "file" { #this will copy and shell script in the provisioning machine
        source = "script.sh" #source of the shell script
        destination = "/tmp/script.sh" #inside the virtual machine it is launching in tmp directory it will store your shell script
    }
    provisioner "remote-exec" { #once the instance is being launch we need to run the shell script
        inline = [
            "chmod +x /tmp/script.sh", #we will make the shell script executable
            "sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
              "sudo /tmp/script.sh",
        ]
    }
   connection {
       host = coalesce(self.public_ip, self.private_ip)
       type = "ssh"
       user = var.INSTANCE_USERNAME #this will be user name of your instance
       private_key = file(var.PATH_TO_PRIVATE_KEY)
   }
}