output "out_sample" {
  value = "This is for testing statement"
}

variable "fruits" {
  default = "banana"
}
output "output1" {
  value = var.fruits
}

