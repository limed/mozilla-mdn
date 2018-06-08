module "mdn_shared" {
  source      = "github.com/limed/infra//apps/mdn/mdn-aws/infra/shared?ref=mdn-refactor"
  enabled     = "${lookup(var.features, "shared-infra")}"
  region      = "${var.region}"
  environment = "${var.environment}"
}

module "mdn_cdn" {
  source      = "github.com/limed/infra//apps/mdn/mdn-aws/infra/mdn-cdn?ref=mdn-refactor"
  enabled     = "${lookup(var.features, "cdn")}"
  region      = "${var.region}"
  environment = "${var.environment}"

  # Primary CDN
  cloudfront_primary_enabled           = "${lookup(var.cloudfront_primary, "enabled")}"
  acm_primary_cert_arn                 = "${lookup(var.cloudfront_primary, "acm_arn.${var.environment}")}"
  cloudfront_primary_distribution_name = "${lookup(var.cloudfront_primary, "distribution_name")}"
  cloudfront_primary_aliases           = "${split(",", lookup(var.cloudfront_primary, "aliases.${var.environment}"))}"
  cloudfront_primary_domain_name       = "${lookup(var.cloudfront_primary, "domain.${var.environment}")}"

  # attachment CDN
  cloudfront_attachments_enabled           = "${(lookup(var.cloudfront_attachments, "enabled")) * (var.environment == "stage" ? 0 : 1)}"
  acm_attachments_cert_arn                 = "${lookup(var.cloudfront_attachments, "acm_arn.${var.environment}")}"
  cloudfront_attachments_distribution_name = "${lookup(var.cloudfront_attachments, "distribution_name")}"
  cloudfront_attachments_aliases           = "${split(",", lookup(var.cloudfront_attachments, "aliases.${var.environment}"))}"
  cloudfront_attachments_domain_name       = "${lookup(var.cloudfront_attachments, "domain.${var.environment}")}"
}

module "multi_region" {
  source = "github.com/limed/infra//apps/mdn/mdn-aws/infra/multi_region?ref=mdn-refactor"

  enabled     = "${lookup(var.features, "shared-infra")}"
  account     = "${var.account}"
  environment = "${var.environment}"

  region  = "${var.region}"
  regions = "${var.regions}"

  enable_efs   = "${lookup(var.features, "efs")}"
  enable_rds   = "${lookup(var.features, "rds")}"
  enable_redis = "${lookup(var.features, "redis")}"

  # memcached
  enable_memcached    = "${lookup(var.features, "memcached")}"
  memcached_node_size = "${lookup(var.memcached, "node_size.${var.environment}")}"
  memcached_num_nodes = "${lookup(var.memcached, "num_nodes.${var.environment}")}"

  # redis
  enable_redis    = "${lookup(var.features, "redis")}"
  redis_node_size = "${lookup(var.redis, "node_size.${var.environment}")}"
  redis_num_nodes = "${lookup(var.redis, "num_nodes.${var.environment}")}"

  # mysql
  enable_rds                  = "${lookup(var.features, "rds")}"
  mysql_db_name               = "${lookup(var.rds, "db_name.${var.environment}")}"
  mysql_username              = "${lookup(var.rds, "username.${var.environment}")}"
  mysql_password              = "${lookup(var.rds, "password.${var.environment}")}"
  mysql_instance_class        = "${lookup(var.rds, "instance_class.${var.environment}")}"
  mysql_backup_retention_days = "${lookup(var.rds, "backup_retention_days.${var.environment}")}"
  mysql_storage_gb            = "${lookup(var.rds, "storage_gb.${var.environment}")}"
}
