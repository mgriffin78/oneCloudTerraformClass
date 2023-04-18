# Terraform Block
terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

/*
Additonal operators of interest

      # Remember to use the "terraform init -upgrade" command if a provider pre-exist and 
      # version is to be either upgraded or downgraded.  An execution of only "terraform init" would fail if a version
      # upgrade/downgrade is introduced.

      # Ensure that the "terraform init -upgrade" command is run within the same directory as "terraform init" was initially
      # executed

      # Specifies the version must be greater than or equal 3.0.0 and less than 3.1.0.  In this case the command will execute
      # properly but no upgrade will occur as there is no available random version between 3.0.1 and 3.1.0 (not including)
      # 3.1.0 which not allow via the < operator. 
      version = ">= 3.0.0, < 3.1.0"
      # Specifies the version must be greater than or equal 3.0.0 and less than or equal 3.1.0. This should result in an upgrade to
      available version 3.1.0.
      version = ">= 3.0.0, <= 3.1.0"         
*/
