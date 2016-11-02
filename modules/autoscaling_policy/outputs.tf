 output "agents_scale_up" {
   value = "${aws_autoscaling_policy.agents-scale-up.arn}"
 }

 output "agents_scale_down" {
   value = "${aws_autoscaling_policy.agents-scale-down.arn}"
 }