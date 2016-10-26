## RDS resources

resource "aws_db_instance" "mysql" {
  allocated_storage       = "${var.allocated_storage}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  identifier              = "${var.database_identifier}"
  instance_class          = "${var.instance_type}"
  storage_type            = "${var.storage_type}"
  name                    = "${var.database_name}"
  password                = "${var.database_password}"
  username                = "${var.database_username}"
  backup_retention_period = "${var.backup_retention_period}"
  backup_window           = "${var.backup_window}"
  maintenance_window      = "${var.maintenance_window}"
  multi_az                = "${var.multi_availability_zone}"
  port                    = "${var.database_port}"
  vpc_security_group_ids  = ["${var.db_sec_grp}"]
  db_subnet_group_name    = "${var.subnet_group}"
  parameter_group_name    = "${var.parameter_group}"
  storage_encrypted       = "${var.storage_encrypted}"

  tags {
    Name      = "pitched-db-${var.environment}"
  }
}

# CloudWatch resources

resource "aws_cloudwatch_metric_alarm" "database_cpu" {
  alarm_name          = "alarm-${var.project}-${var.environment}-DatabaseServerCPUUtilization"
  alarm_description   = "Database server CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions = ["${split(",", var.alarm_actions)}"]
}

resource "aws_cloudwatch_metric_alarm" "database_disk_queue" {
  alarm_name          = "alarm-${var.project}-${var.environment}-DatabaseServerDiskQueueDepth"
  alarm_description   = "Database server disk queue depth"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_disk_queue_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions = ["${split(",", var.alarm_actions)}"]
}

resource "aws_cloudwatch_metric_alarm" "database_disk_free" {
  alarm_name          = "alarm-${var.project}-${var.environment}-DatabaseServerFreeStorageSpace"
  alarm_description   = "Database server free storage space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_free_disk_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions = ["${split(",", var.alarm_actions)}"]
}

resource "aws_cloudwatch_metric_alarm" "database_memory_free" {
  alarm_name          = "alarm-${var.project}-${var.environment}-DatabaseServerFreeableMemory"
  alarm_description   = "Database server freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_free_memory_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.mysql.id}"
  }

  alarm_actions = ["${split(",", var.alarm_actions)}"]
}