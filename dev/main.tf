/* define the provider */

provider "aws" {
  region                   = "eu-west-1"
  profile                  = "klassik"
}

module "vpc" {
  source          = "../modules/vpc"
  name            = "dev-ecs-vpc"
  cidr            = "10.7.0.0/16"
  private_subnets = "10.7.1.0/24,10.7.2.0/24,10.7.3.0/24"
  public_subnets  = "10.7.4.0/24,10.7.5.0/24,10.7.7.0/24"
  azs             = "eu-west-1a,eu-west-1b,eu-west-1c"
}

module "sg_app" {
  source                 = "../modules/sg_app"
  security_group_name    = "sg_app"
  vpc_id                 = "${module.vpc.vpc_id}"
  source_cidr_block      = "0.0.0.0/0"
  bastion_security_group = ""
  elb_security_group     = "${module.sg_elb.security_group_id}"
}

module "sg_elb" {
  source              = "../modules/sg_elb"
  security_group_name = "sg_elb"
  vpc_id              = "${module.vpc.vpc_id}"
  source_cidr_block   = "0.0.0.0/0"
}

module "app" {
  source                      = "../modules/app"
  ami                         = "ami-309ad443" /* ecs agent instance */
  count                       = "3"
  environment                 = "dev"
  instance_type               = "t2.medium"
  key_name                    = "ops"
  security_groups             = "${module.sg_app.security_group_id}"
  subnet_id                   = "${module.vpc.private_subnets}"
  associate_public_ip_address = "false"
  source_dest_check           = "false"
}

module "elb" {
  source              = "../modules/elb"
  name                = "dev-ecs-elb"
  security_groups     = "${module.sg_elb.security_group_id}"
  instance_port       = "80"
  instance_protocol   = "http"
  lb_port             = 80
  lb_protocol         = "http"
  ssl_certificate_id  = ""
  healthy_threshold   = 2
  unhealthy_threshold = 2
  timeout             = 3
  target              = "HTTP:80/"
  interval            = 30
  instances           = "${module.app.aws_instance}"
  subnets                     = "${module.vpc.public_subnets}"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tag_name                    = "dev ecs elb"
}

module "autoscaling_groups" {
  source = "../modules/autoscaling_groups"
}

module "launch_congiuration" {
  source = "../modules/launch_congiuration"
}