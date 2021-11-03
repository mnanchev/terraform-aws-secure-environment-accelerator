variable "organization_structure" {
  type = map(any)
  default = {
    networking = {
      email = "martin2754@gmail.com"
      ou    = "Networking"
    }
    security = {
      email = "martin2754@gmail.com"
      ou    = "Security"
    }
    logging = {
      email = "martin2754@gmail.com"
      ou    = "Logging"
    }
    perimeter = {
      email = "martin2754@gmail.com"
      ou    = "Perimeter"
    }
    operations = {
      email = "martin2754@gmail.com"
      ou    = "Operations"
    }
    backend = {
      email = "martin2754@gmail.com"
      ou    = "Backend"
    }

    frontend = {
      email = "martin2754@gmail.com"
      ou    = "Frontend"
    }
    database = {
      email = "martin2754@gmail.com"
      ou    = "Database"
    }
    ai = {
      email = "martin2754@gmail.com"
      ou    = "AI"
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