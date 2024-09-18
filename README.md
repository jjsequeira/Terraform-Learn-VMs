# Terraform-Learn-VMs
Automate VMs creation


# Azure Virtual Machine

This module handles Azure Virtual Machine in P&G Cloud environments.

## Support

To receive support and learn more about IaC platform, visit the [IaC Developer Portal](https://developerportal.pg.com/docs/default/Component/iac/support/).

## Usage

There are examples included in the [examples](./examples) folder but simple usage is as follows:

```
module "virtual-machine" {
  source = "../../"

  subscription_id           = "00000000-0000-0000-0000-000000000000"
  resource_name             = "azl-demovm01"
  resource_group            = "AZ-RG-TerraformModules-01"
  resource_tags             = {
    "key1": "value1"
    "key2": "value2"
  }
  sku_name                  = "Standard_D4_v3"
  os_flavor                 = "centos"
  os_version                = "7.7"
  access_groups             = ["ITS-Group1","ITS-Group2"]
  admin_groups              = ["ITS-Group1"]
  user_groups               = ["ITS-Group2"]
  puppet_role               = ""
  os_disk_managed_disk_type = "Standard_LRS"
  os_disk_size_gb           = 50
  data_disk = [
    {
      data_disk_size_gb = "20"
      data_disk_type = "Standard_LRS"
    }
  ]
}
```

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.18.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=2.2 |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_os_flavor"></a> [os\_flavor](#input\_os\_flavor) | The OS Flavor to be used in the instance. Possible values are rhel, ubuntu, ol, windows. | `string` | n/a | yes |
| <a name="input_os_version"></a> [os\_version](#input\_os\_version) | The OS version to be use in the instance. Possible values are rhel (8.6-gen2, 8.6-sap-gen2, 8.8-gen2, 8.8-sap-gen2), ol (8.6sap-gen2, 8.7sap-gen2), sles (15sp4sap-gen2), ubuntu (20.04-gen2), windows (2019-gen2, 2019, 2016-gen2, 2016, blue-prism-win-2016-g2). See os.tf for more details. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Name of the resource group where the resource(s) will be deployed | `string` | n/a | yes |
| <a name="input_resource_name"></a> [resource\_name](#input\_resource\_name) | Name of the resource to be deployed | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | SKU name for virtual machine. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID of the subscription where the resource will be deployed | `string` | n/a | yes |
| <a name="input_access_groups"></a> [access\_groups](#input\_access\_groups) | Groups to be assigned the access to the resource | `list(string)` | `[]` | no |
| <a name="input_add_suffix_index"></a> [add\_suffix\_index](#input\_add\_suffix\_index) | If true, index will be added to resource name suffix even if instance count is 1. Used to avoid issues when scaling down to 1. | `bool` | `false` | no |
| <a name="input_additional_rules"></a> [additional\_rules](#input\_additional\_rules) | List of additional network security firewall rules. | `any` | `[]` | no |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags for the resource | `map(string)` | `{}` | no |
| <a name="input_admin_groups"></a> [admin\_groups](#input\_admin\_groups) | Specifies the administrator group to use virtual machines. | `list(string)` | `[]` | no |
| <a name="input_application_security_group"></a> [application\_security\_group](#input\_application\_security\_group) | The name or id of the Application Security Group | `string` | `""` | no |
| <a name="input_bootstrap_environment"></a> [bootstrap\_environment](#input\_bootstrap\_environment) | Bootstrap environment to use. You can use 'feat\_new\_domain' in case you want to deploy VMs using the new domain (int.pg.com), currently only applies if your VMs are in enterprise subscription and later it will come for other environments | `string` | `"main"` | no |
| <a name="input_context"></a> [context](#input\_context) | Context to query in the table storage, can be primary or secondary | `string` | `"primary"` | no |
| <a name="input_create_network_security_group"></a> [create\_network\_security\_group](#input\_create\_network\_security\_group) | Specifies whether to create dedicated nsg for VM. It only applies if the use\_shared\_network\_security\_group is false. | `bool` | `false` | no |
| <a name="input_data_disk"></a> [data\_disk](#input\_data\_disk) | Specifies the list of data disks information to create disk. Accepted properties are data\_disk\_size\_gb(required), data\_disk\_type(requried), create\_option(required), source\_resource\_id (required when create\_option is Copy, Restore ), image\_reference\_id (required when create\_option is FromImage) | `list(map(string))` | `[]` | no |
| <a name="input_data_disk_caching"></a> [data\_disk\_caching](#input\_data\_disk\_caching) | Specifies default caching for data disk. This caching would be used if disk\_caching is not specified in data disk | `string` | `"ReadWrite"` | no |
| <a name="input_data_disk_write_accelerator_enabled"></a> [data\_disk\_write\_accelerator\_enabled](#input\_data\_disk\_write\_accelerator\_enabled) | Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs | `bool` | `false` | no |
| <a name="input_delete_data_disks_on_termination"></a> [delete\_data\_disks\_on\_termination](#input\_delete\_data\_disks\_on\_termination) | Specifies whether data disk should be removed upon VM termination | `bool` | `true` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | Should Accelerated Networking be enabled? | `bool` | `true` | no |
| <a name="input_enable_ip_forwarding"></a> [enable\_ip\_forwarding](#input\_enable\_ip\_forwarding) | Specify whether to enable IP forwarding for network interface | `bool` | `false` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Specifies if all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host. | `bool` | `true` | no |
| <a name="input_eviction_policy"></a> [eviction\_policy](#input\_eviction\_policy) | (Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance | `string` | `"Deallocate"` | no |
| <a name="input_execute_bootstrap"></a> [execute\_bootstrap](#input\_execute\_bootstrap) | Specifies whether to execute bootstrap | `bool` | `true` | no |
| <a name="input_existing_availability_set_id"></a> [existing\_availability\_set\_id](#input\_existing\_availability\_set\_id) | ID of existing availability set you want to use for vm. If this ID is provided, existing\_availability\_set\_name would be ignored. | `string` | `""` | no |
| <a name="input_existing_availability_set_name"></a> [existing\_availability\_set\_name](#input\_existing\_availability\_set\_name) | Name of existing availability set you want to use for vm. The availability set should be in the same resource group as vm. | `string` | `""` | no |
| <a name="input_existing_data_disk"></a> [existing\_data\_disk](#input\_existing\_data\_disk) | Specifies the list of exsiting data disk ids. | `list(string)` | `[]` | no |
| <a name="input_existing_data_disk_attachment_map"></a> [existing\_data\_disk\_attachment\_map](#input\_existing\_data\_disk\_attachment\_map) | List of map of existing data disk. Keys of map include disk\_id(requried), lun(required), caching(optional, default var.data\_disk\_caching), write\_accelerator\_enabled(optional, default var.data\_disk\_write\_accelerator\_enabled), vm\_index(optional, default 0) | `list(map(string))` | `[]` | no |
| <a name="input_existing_network_security_group_id"></a> [existing\_network\_security\_group\_id](#input\_existing\_network\_security\_group\_id) | ID of existing NSG you want to use for vm. To use an existing nsg other than resource group shared nsg, use\_shared\_network\_security\_group must set to false. | `string` | `""` | no |
| <a name="input_existing_proximity_placement_group"></a> [existing\_proximity\_placement\_group](#input\_existing\_proximity\_placement\_group) | Id of the existing proximity placement group to be used, or name if the group is in the same rg | `string` | `""` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of User Managed Identity ID's which should be assigned to the Windows Virtual Machine. This is required when type is set to UserAssigned | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Specifies the identity type to be assigned to the virtual machine | `string` | `"SystemAssigned"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances of the VM, Default should be 1 in case for non cluster virtual machine | `number` | `1` | no |
| <a name="input_lb_pool_ids"></a> [lb\_pool\_ids](#input\_lb\_pool\_ids) | Id's for the load balancer backend pool for virtual machine. One VM can only be associated with max one backend pool owned by an internal load balancer and also at the same time with max one backend pool owned by a public load balance | `list(string)` | `[]` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL\_BYOS and SLES\_BYOS. | `string` | `null` | no |
| <a name="input_load_balancer_ids"></a> [load\_balancer\_ids](#input\_load\_balancer\_ids) | Id's for the load balancer for virtual machine. This list would be ignored if lb\_pool\_ids is not empty. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Location for the resource, if empty then Resource Group location will be used | `string` | `""` | no |
| <a name="input_max_bid_price"></a> [max\_bid\_price](#input\_max\_bid\_price) | (Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars per hour; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the `eviction_policy`. Defaults to `-1`, which means that the Virtual Machine should not be evicted for price reasons. This can only be configured when `priority` is set to `Spot`. | `number` | `-1` | no |
| <a name="input_new_domain"></a> [new\_domain](#input\_new\_domain) | Define if you deploy VMs using the new domain (int.pg.com/external.pg.com) | `bool` | `true` | no |
| <a name="input_ol_pass"></a> [ol\_pass](#input\_ol\_pass) | The Oracle Linux Subscription password to use to subscribe an Oracle Linux | `string` | `""` | no |
| <a name="input_ol_sub"></a> [ol\_sub](#input\_ol\_sub) | The Oracle Linux Subscription CSI support number to join an Oracle Linux to | `string` | `"25387537"` | no |
| <a name="input_ol_user"></a> [ol\_user](#input\_ol\_user) | The Oracle Linux Subscription username to use to subscribe an Oracle Linux | `string` | `"cloudlinux.im@pg.com"` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | Specifies the caching requirements | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_managed_disk_type"></a> [os\_disk\_managed\_disk\_type](#input\_os\_disk\_managed\_disk\_type) | Specifies the type of managed disk to create | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Specifies the size of the OS Disk in gigabytes. | `number` | `150` | no |
| <a name="input_os_disk_write_accelerator_enabled"></a> [os\_disk\_write\_accelerator\_enabled](#input\_os\_disk\_write\_accelerator\_enabled) | Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium\_LRS managed disks with no caching and M-Series VMs | `bool` | `false` | no |
| <a name="input_os_image_id"></a> [os\_image\_id](#input\_os\_image\_id) | Resource ID of the OS image | `string` | `""` | no |
| <a name="input_os_image_version"></a> [os\_image\_version](#input\_os\_image\_version) | Use specific version of the image, if empty it will default to latest | `string` | `""` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | Permissions should be enabled to the SAS | `string` | `"lpr"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | (Optional) Specifies if the VM capacity should be considerd Spot instance or normal VM. A Spot instance can be termiated by Azure even if process are running | `string` | `"Regular"` | no |
| <a name="input_puppet_role"></a> [puppet\_role](#input\_puppet\_role) | Role for Puppet to install specific software, leave empty for base compliance controls | `string` | `""` | no |
| <a name="input_remove_prefix_hyphen"></a> [remove\_prefix\_hyphen](#input\_remove\_prefix\_hyphen) | Specifies whether hyphen should be removed in case resource name is too long. VM names should be 15 characters max. | `bool` | `false` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags for the resource | `map(string)` | `{}` | no |
| <a name="input_sas_token_expiration_time"></a> [sas\_token\_expiration\_time](#input\_sas\_token\_expiration\_time) | Specifies the amount of time the token used to access storage account used for vm bootstrap should be valid for. For usage details please see terraform-azure-utils/storage-sas-token module. | `string` | `"30m"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | In case you need to use a specific subnet for the VM. You need to provide the resource id. | `string` | `""` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | Should the capacity to enable Data Disks of the UltraSSD\_LRS storage account type be supported on this Virtual Machine? | `bool` | `false` | no |
| <a name="input_use_shared_network_security_group"></a> [use\_shared\_network\_security\_group](#input\_use\_shared\_network\_security\_group) | Specifies whether to use the resource group shared nsg for VM. This could reduce massive provisioning time for multiple VMs. | `bool` | `true` | no |
| <a name="input_user_groups"></a> [user\_groups](#input\_user\_groups) | Specifies the user group to use virtual machines. | `list(string)` | `[]` | no |
| <a name="input_vtpm_enabled"></a> [vtpm\_enabled](#input\_vtpm\_enabled) | Specifies if vTPM (virtual Trusted Plaform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created. GEN2 only. List of supported images https://docs.microsoft.com/en-us/azure/virtual-machines/trusted-launch#limitations | `bool` | `false` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The Zone in which this Virtual Machine should be created. Changing this forces a new resource to be created. | `string` | `""` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the resource created |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The System-Assigned MSI identity principal id set on the vm |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The first private IP address of the network interface. |
