output "ecs_autoscaling_group" {
  value = "${aws_autoscaling_group.ecs.name}"
}