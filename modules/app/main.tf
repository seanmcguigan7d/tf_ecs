resource "aws_instance" "app" {
    ami               = "${var.ami}"
    count             = "${var.count}"
    instance_type     = "${var.instance_type}"
    key_name          = "${var.key_name}"
    vpc_security_group_ids      = ["${var.security_groups}"]
    subnet_id                   = "${element(split(",", var.subnet_id), count.index)}"
    associate_public_ip_address = "${var.associate_public_ip_address}"
    source_dest_check           = "${var.source_dest_check}"
    iam_instance_profile        = "${aws_iam_instance_profile.ecs_inst_profile.id}"
    user_data                   = "${file("cluster_name.sh")}"
    tags {
        Name = "${var.environment}-ecs-node-${count.index}"
    }
}

/* ecs iam role */
resource "aws_iam_role" "ecs_role" {
    name               = "ecs_role"
    assume_role_policy = "${file("policies/ecs-role.json")}"
}

/* ecs service policy */
resource "aws_iam_role_policy" "ecs_service_role_policy" {
    name     = "ecs_service_role_policy"
    policy   = "${file("policies/ecs-service-role-policy.json")}"
    role     = "${aws_iam_role.ecs_role.id}"
}

/* ec2 instance policy */
resource "aws_iam_role_policy" "ecs_instance_role_policy" {
    name     = "ecs_instance_role_policy"
    policy   = "${file("policies/ecs-instance-role-policy.json")}"
    role     = "${aws_iam_role.ecs_role.id}"
}
/* associate with role */
resource "aws_iam_instance_profile" "ecs_inst_profile" {
    name  = "ecs_inst_profile"
    roles = ["${aws_iam_role.ecs_role.name}"]
}