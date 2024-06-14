variable "project" {}
variable "credentials_files" {}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "zone" {
  default = "us-central1-a"
  type    = string
}

variable "os_image" {
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
  description = "Using Ubuntu Image"
  type        = string
}

variable "vm_params" {
  type = object({
    name                      = string
    machine_type              = string
    zone                      = string
    allow_stopping_for_update = bool
  })

  description = "Vm Parameters"

  default = {
    name                      = "appserver"
    machine_type              = "f1-micro"
    zone                      = "us-central1-a"
    allow_stopping_for_update = true
  }

  validation {
    condition     = length(var.vm_params.name) > 3
    error_message = "VM Name must be atleast 4 characters."
  }
}
