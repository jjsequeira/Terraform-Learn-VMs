# Azure Virtual Machine

This module handles Azure Virtual Machines for testing purposes.

## Support

To receive support and learn more about the IaC platform, contact sfallas@artech-consulting.com

## Usage
  
   The usage is as follows:
  
  ```
  module "app-service" {
  source = "module-path"
  subscription_id = "00000000-0000-0000-0000-000000000000"
  resource_group = "AZ-RG-Resource-Group"
  resource_name = "resource1"
  access_groups = ["ITS-Group1","ITS-Group2"]
  resource_tags = { 
    "key1": "value1"
     "key2": "value2"
    }
   app_service_plan_name = "resource2"
    }
  ```