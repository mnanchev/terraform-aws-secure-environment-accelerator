variable "organization_structure" {
  type = map(any)
  default = {
    networking = {
      email = "martin2754@gmail.com"
      ou    = "Networking"
      cidr  = "10.1.0.0/16"
    }
    security = {
      email = "martin2754@gmail.com"
      ou    = "Security"
      cidr  = ""
    }
    logging = {
      email = "martin2754@gmail.com"
      ou    = "Logging"
      cidr  = ""
    }
    perimeter = {
      email = "martin2754@gmail.com"
      ou    = "Perimeter"
      cidr  = "10.0.0.0/16"
    }
    operations = {
      email = "martin2754@gmail.com"
      ou    = "Operations"
      cidr  = ""
    }
    backend = {
      email = "martin2754@gmail.com"
      ou    = "Backend"
      cidr  = ""

    }

    frontend = {
      email = "martin2754@gmail.com"
      ou    = "Frontend"
      cidr  = ""

    }
    database = {
      email = "martin2754@gmail.com"
      ou    = "Database"
      cidr  = ""

    }
    ai = {
      email = "martin2754@gmail.com"
      ou    = "AI"
      cidr  = ""

    }


  }

}

variable "customer" {
  default = "probkoTestov"
}

variable "profile" {
  default = "profile"
}

variable "region" {
  default = "us-east-1"
}