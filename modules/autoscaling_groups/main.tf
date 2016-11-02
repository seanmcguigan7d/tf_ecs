resource "aws_autoscaling_group" "ecs" {
    vpc_zone_identifier = ["${split(",", var.vpc_zone_identifier)}"]
 #   name = "agents"
    max_size = "5"
    min_size = "1"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 2
    force_delete = true
 #   launch_configuration = "${aws_launch_configuration.agent-lc.name}"
    launch_configuration = "${var.launch_configuration}"
    load_balancers = ["${var.load_balancers}"]
}

