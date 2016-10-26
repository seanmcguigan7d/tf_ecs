// Output ID of app SG 

output "security_group_id" {
  value = "${aws_security_group.packer_security_group.id}"
}
