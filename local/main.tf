resource "local_file"  "welcome" {
   filename = "data.txt"
   content = "Welcome to Terraform \n"
   }
