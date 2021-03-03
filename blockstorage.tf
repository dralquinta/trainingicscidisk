/* blockstorage.tf
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the declaration for block volumes following LATAM Airlines standard framework
Copyright (c) 2017, 2020, Oracle and/or its affiliates. All rights reserved. 
*/

# Create Disk
resource "oci_core_volume" "ISCSIDisk" {
  count               = var.amount_of_disks
  availability_domain = var.availability_domain
  compartment_id      = local.compartment_id
  display_name        = "${var.compute_display_name}_${var.volume_display_name}_${count.index}"
  size_in_gbs         = var.disk_size_in_gb
  vpus_per_gb         = var.vpus_per_gb
}

# Create Disk Attachment
resource "oci_core_volume_attachment" "ISCSIDiskAttachment" {
  depends_on = [ oci_core_volume.ISCSIDisk ]
  count           = var.attach_disks ? var.amount_of_disks : 0
  attachment_type = var.attachment_type
  instance_id     = var.linux_compute_id
  volume_id       = oci_core_volume.ISCSIDisk[count.index].id
}
