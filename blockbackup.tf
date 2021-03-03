/* blockbackup.tf 
Author: CGUEVARA - cristian.g.guevara@oracle.com
        DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the backup for volumes
Copyright (c) 2017, 2021, Oracle and/or its affiliates. All rights reserved. 
*/

# Assignament of backup policy for ProdDisk
resource "oci_core_volume_backup_policy_assignment" "backup_policy_assignment_ISCSI_Disk" {
  count     = var.amount_of_disks
  asset_id  = oci_core_volume.ISCSIDisk[count.index].id
  policy_id = local.backup_policy_iscsi_disk_id
}
