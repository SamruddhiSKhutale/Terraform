provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "main" {
  identifier           = "sam-rds-main"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp3"

  db_name              = "appdb"
  username             = "admin"
  password             = "Samrudddhi123"

  publicly_accessible  = false
  skip_final_snapshot  = true

  backup_retention_period = 7

  tags = {
    Name = "sam-rds-main"
  }
}

resource "aws_db_instance" "read_replica" {
  identifier          = "sam-rds-read-replica"
  replicate_source_db = aws_db_instance.main.identifier

  instance_class      = "db.t3.micro"
  publicly_accessible = false

  tags = {
    Name = "sam-rds-read-replica"
  }
}

resource "aws_elasticache_subnet_group" "redis" {
  name = "sam-redis-subnet-group"

  subnet_ids = [
    "subnet-06caacd9ecb269043",
    "subnet-091ef1b0997095276"
  ]
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = "sam-redis"
  description          = "Redis cache for application"

  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_clusters   = 1

  port                 = 6379

  subnet_group_name    = aws_elasticache_subnet_group.redis.name

  tags = {
    Name = "sam-redis"
  }
}
