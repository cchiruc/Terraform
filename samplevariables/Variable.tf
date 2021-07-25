output "out_sample" {
  value = "This is for testing statement"
}

variable "fruits" {
  default = "banana"
}
output "output1" {
  value = var.fruits
}

variable "vegitables" {
  default = [ "TOMOTTO" , "CARROT" ]
}

output "output2" {
  value = "My Favorite Vegi is - ${var.vegitables[0]}"
}

output "output3" {
  value = var.vegitables[1]
}