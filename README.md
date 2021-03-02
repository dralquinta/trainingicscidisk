# trainingiscsidisk

The following repo decouples the provisioning of ISCSI disks to later be presented and mounted to an IaaS Compute

## Sample tfvars file

```shell 
####################################### COMMON VARIABLES ######################################
region           = "us-ashburn-1"
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaabc4esylkbw3jkbquuluuq4iftuuwnfc2yg2fguo4s7j43exv6pq"
user_ocid        = "ocid1.user.oc1..aaaaaaaazwzvytqwy23ojocvnmaqqn4u2hf3zylpefj5ur3cqmus5cmiso6q"
fingerprint      = "81:0e:bb:e1:75:b4:b7:2c:04:c2:97:e9:a0:aa:4d:36"
private_key_path = "/home/opc/.ssh/OCI_KEYS/API/auto_api_key.pem"
######################################## COMMON VARIABLES ######################################


######################################## ARTIFACT SPECIFIC VARIABLES ######################################

availability_domain_number           = "1"
amount_of_disks                      = "3"
disk_size_in_gb                      = "50"
iscsi_disk_instance_compartment_name = "OCI-LAB-04"
volume_display_name                  = "ol7_iscsi"
backup_policy_level                  = "gold"
linux_compute_id                     = "Enter_Here_the_Obtained_OCID_where_Disk_will_be_attached"
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| oci | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [oci_core_volume](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_volume) |
| [oci_core_volume_attachment](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_volume_attachment) |
| [oci_core_volume_backup_policies](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_volume_backup_policies) |
| [oci_core_volume_backup_policy_assignment](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_volume_backup_policy_assignment) |
| [oci_identity_availability_domain](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domain) |
| [oci_identity_compartments](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_compartments) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amount\_of\_disks | Amount of equally sized disks | `any` | n/a | yes |
| attach\_disks | Atach disk to a Linux instance | `bool` | `true` | no |
| attachment\_type | Atacchment type can be iscsi or paravirtualized | `string` | `"iscsi"` | no |
| availability\_domain\_number | Defines the availability domain where OCI artifact will be created. This is a numeric value greater than 0 | `any` | n/a | yes |
| backup\_policy\_level | Backup policy level for ISCSI disks | `any` | n/a | yes |
| disk\_size\_in\_gb | Size in GB for Product Disk | `any` | n/a | yes |
| fingerprint | IaaS User FingerPrint HASH address | `any` | n/a | yes |
| iscsi\_disk\_instance\_compartment\_name | Defines the compartment name where the infrastructure will be created | `any` | n/a | yes |
| linux\_compute\_id | OCI Id for instance to attach the disk | `any` | `null` | no |
| private\_key\_path | Private Key Absolute path location | `any` | n/a | yes |
| region | Target region where artifacts are going to be created | `any` | n/a | yes |
| tenancy\_ocid | Defines the OCID for Tenancy | `any` | n/a | yes |
| user\_ocid | IaaS User OCID | `any` | n/a | yes |
| volume\_display\_name | Disk display name. | `any` | n/a | yes |
| vpus\_per\_gb | n/a | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| core\_volumens | n/a |
| core\_volumens\_attachment | n/a |
| volumen\_ids | n/a |
