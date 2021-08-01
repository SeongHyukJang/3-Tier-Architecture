resource "aws_db_subnet_group" "db_subnet_group_dev" {
    name = "db-subnet-group-70491_dev"
    subnet_ids = [aws_subnet.db_private_subnet_a_dev.id]
    description = "subnet group for DB DEV"
}

resource "aws_db_instance" "db_master_dev" {
    instance_class = "db.t3.micro"          
    storage_type = "gp2"                    
    allocated_storage = 20                  
    max_allocated_storage = 40              

    engine = "mysql"
    engine_version = "8.0.23"               

    identifier = "db-master"                 
    name = "db"
    username = "admin"
    password = "skcc70491"                  

    port = 3306 
    multi_az = true
    allow_major_version_upgrade = true
    auto_minor_version_upgrade = true
    backup_retention_period = 14            
    copy_tags_to_snapshot = true            
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group_dev.id
    vpc_security_group_ids = [aws_security_group.db_sg_dev.id]

    tags = {
        Name = "70491-DB_dev"
    }
}