resource "aws_db_subnet_group" "pitched" {
    name = "${var.name}"
    subnet_ids = ["${split(",", var.subnet_ids)}"]
    tags {
        Name = "Pitched DB subnet group"
    }
}