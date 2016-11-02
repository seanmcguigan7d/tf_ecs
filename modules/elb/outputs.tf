output "elb_dns" {
  value = "${aws_elb.ecs.dns_name}"
}

output "elb_id" {
  value = "${aws_elb.ecs.id}"
}