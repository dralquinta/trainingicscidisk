/* diskprovision.tf 
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the logic to format and present a disk to a machine idempotently 
Copyright (c) 2017, 2020, Oracle and/or its affiliates. All rights reserved. 
*/

#Create Disk Attachment
resource "null_resource" "provisioning_disk" {
 depends_on = [ oci_core_volume_attachment.ISCSIDiskAttachment ]
  count = length(oci_core_volume_attachment.ISCSIDiskAttachment)

  connection {
    type        = "ssh"
    host        = var.linux_compute_private_ip
    user        = "opc"
    private_key = var.ssh_private_is_path ? file(var.ssh_private_key) : var.ssh_private_key
  }

  # register and connect the iSCSI block volume
  
  provisioner "remote-exec" {
    
    inline = [
      "set +x",
      /*       "echo ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].id}",
      "echo ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].iqn}",
      "echo ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].ipv4}",
      "echo ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].port}",
      "echo ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].device}",
      "echo ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].state}",
      "echo ${var.provisioning_display_name}_${count.index}", */


      "${local.iscsiadm} -m node -o new -T ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].iqn} -p ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].ipv4}:${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].port}",
      "${local.iscsiadm} -m node -o update -T ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].iqn} -n node.startup -v automatic",
      "${local.iscsiadm} -m node -T ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].iqn} -p ${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].ipv4}:${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].port} -l",
    ]
  }
}


resource "null_resource" "partition_disk" {
  depends_on = [null_resource.provisioning_disk]
  count      = length(oci_core_volume_attachment.ISCSIDiskAttachment)
  connection {
    type        = "ssh"
    host        = var.linux_compute_private_ip
    user        = "opc"
    private_key = var.ssh_private_is_path ? file(var.ssh_private_key) : var.ssh_private_key
  }

  # With provisioned disk, trigger fdisk, then pvcreate and vgcreate to tag the disk
  provisioner "remote-exec" {
   inline = [
      "set +x",
      "export DEVICE_ID=/dev/disk/by-path/ip-${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].ipv4}:${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].port}-iscsi-${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].iqn}-lun-1",
      "${local.fdisk} $${DEVICE_ID}",
    ]
  }
}


resource "null_resource" "pvcreate_exec" {
  depends_on = [null_resource.partition_disk]
  count      = length(oci_core_volume_attachment.ISCSIDiskAttachment)
  connection {
    type        = "ssh"
    host        = var.linux_compute_private_ip
    user        = "opc"
    private_key = var.ssh_private_is_path ? file(var.ssh_private_key) : var.ssh_private_key
  }

  # With provisioned disk, trigger fdisk, then pvcreate and vgcreate to tag the disk
  provisioner "remote-exec" {
    inline = [
      "set +x",
      "export DEVICE_ID=/dev/disk/by-path/ip-${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].ipv4}:${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].port}-iscsi-${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].iqn}-lun-1",
      "${local.pvcreate} $${DEVICE_ID}-part1",
    ]
  }
}


resource "null_resource" "vgcreate_exec" {
  depends_on = [null_resource.pvcreate_exec]
  count      = length(oci_core_volume_attachment.ISCSIDiskAttachment)
  connection {
    type        = "ssh"
    host        = var.linux_compute_private_ip
    user        = "opc"
    private_key = var.ssh_private_is_path ? file(var.ssh_private_key) : var.ssh_private_key
  }

  # With provisioned disk, trigger fdisk, then pvcreate and vgcreate to tag the disk
  provisioner "remote-exec" {
    inline = [
      "set +x",
      "export DEVICE_ID=/dev/disk/by-path/ip-${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].ipv4}:${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].port}-iscsi-${oci_core_volume_attachment.ISCSIDiskAttachment[count.index].iqn}-lun-1",
      "${local.vgcreate} ${var.provisioning_display_name}_${count.index} $${DEVICE_ID}-part1",
    ]
  }
}

