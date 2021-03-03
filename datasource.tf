/* datasources.tf 
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the lookup logic used in code to obtain pre-created resources in tenancy.
Copyright (c) 2017, 2020, Oracle and/or its affiliates. All rights reserved. 
*/

/********** Compartment and CF Accessors **********/
data "oci_identity_compartments" "COMPARTMENTS" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.iscsi_disk_instance_compartment_name]
  }
}

# Backup volume policies accesors


data "oci_core_volume_backup_policies" "BACKUPPOLICYISCSI" {
  filter {
    name = "display_name"

    values = [var.backup_policy_level]
  }
}



locals {
  compartment_id              = data.oci_identity_compartments.COMPARTMENTS.compartments[0].id
  backup_policy_iscsi_disk_id = data.oci_core_volume_backup_policies.BACKUPPOLICYISCSI.volume_backup_policies[0].id

}
