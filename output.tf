/* output.tf 
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the output for Compute located on private network
Copyright (c) 2017, 2020, Oracle and/or its affiliates. All rights reserved. 
*/

output "volumen_ids" {
  value = oci_core_volume.ISCSIDisk.*.id
}

output "core_volumens" {
  value = oci_core_volume.ISCSIDisk
}

output "core_volumens_attachment" {
  value = oci_core_volume_attachment.ISCSIDiskAttachment
}
