resource "aws_sns_topic" "ecs" {
  name         = "${var.name}"
  display_name = "${var.display_name}"
}