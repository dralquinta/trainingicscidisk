/* variables.tf
Author: DALQUINT – denny.alquinta@oracle.com
Purpose: Defines all variables used in project
Copyright (c) 2017, 2020, Oracle and/or its affiliates. All rights reserved. */

/************* Initial Provider Variables *************/
variable "user_ocid" {
  description = "IaaS User OCID"
}
variable "fingerprint" {
  description = "IaaS User FingerPrint HASH address"
}
variable "private_key_path" {
  description = "Private Key Absolute path location "
}

/************* Initial Provider Variables *************/


/************* Regional and Compartment Variables *************/
variable "region" {
  description = "Target region where artifacts are going to be created"
}
/************* Regional and Compartment Variables *************/


/************* Datasource Script Variables *************/
variable "tenancy_ocid" {
  description = "Defines the OCID for Tenancy"
}
variable "availability_domain_number" {
  description = "Defines the availability domain where OCI artifact will be created. This is a numeric value greater than 0"
}
variable "iscsi_disk_instance_compartment_name" {
  description = "Defines the compartment name where the infrastructure will be created"
}
/************* Datasource Script Variables *************/


/************* Host Variables *************/
variable "amount_of_disks" {
  description = "Amount of equally sized disks"
}

variable "disk_size_in_gb" {
  description = "Size in GB for Product Disk"
}

variable "volume_display_name" {
  description = "Disk display name."
}

variable "attachment_type" {
  description = "Atacchment type can be iscsi or paravirtualized"
  default     = "iscsi"
}

variable "linux_compute_id" {
  description = "OCI Id for instance to attach the disk"
  default     = null
}

variable "attach_disks" {
  description = "Atach disk to a Linux instance"
  default     = true
}

variable "backup_policy_level" {
  description = "Backup policy level for ISCSI disks"
}

variable "vpus_per_gb" {
  default = 10
}

/************* Host Variables *************/


