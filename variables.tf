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

variable "iscsi_disk_instance_compartment_name" {
  description = "Defines the compartment name where the infrastructure will be created"
}
/************* Datasource Script Variables *************/


/************* Disk Variables *************/
variable "ssh_private_is_path" {
  description = "Determines if key is supposed to be on file or in text"
  default = true  
}

variable "ssh_private_key" {
  description = "Determines what is the private key to connect to machine"
}

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

variable "compute_display_name" {
  description = "Name of the compute where the disk will be attached to"
  
}

variable "availability_domain" {
  description = "Availability Domain where the block storage will be created at"
  
}

variable "linux_compute_private_ip" {
  description = "Compute private IP to logon into machine"
}

/************* Disk Variables *************/


