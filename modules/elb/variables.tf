  variable "name" {}
  variable "security_groups" {}
  variable "instance_port" {}
  variable "instance_protocol" {}
  variable "lb_port" {}
  variable "lb_protocol" {}
  variable "healthy_threshold" {}
  variable "unhealthy_threshold" {}
  variable "timeout" {}
  variable "target" {}
  variable "interval" {}
  variable "instances" {}
  variable "subnets" {}
  variable "ssl_certificate_id" {}
  variable "cross_zone_load_balancing" {}
  variable "idle_timeout" {}
  variable "connection_draining" {}
  variable "connection_draining_timeout" {}
  variable "tag_name" {}