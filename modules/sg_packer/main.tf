// Security Group Resource for Module

resource "aws_security_group" "packer_security_group" {
    name = "${var.security_group_name}"
    description = "Security Group to allow Packer access to port 22"
    vpc_id = "${var.vpc_id}"

    // allow traffic for TCP 22
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.inc_source_cidr_block}"]
    }

    // allow node to call out
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.out_source_cidr_block}"]
    }

    tags {
        Name = "Packer builder security group"
    }
}
