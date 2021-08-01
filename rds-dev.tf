resource "aws_db_instance" "db_master_dev" {
    instance_class = "db.t3.micro"          
    storage_type = "gp2"                    
    allocated_storage = 20                  
    max_allocated_storage = 40              

    engine = "mysql"
    engine_version = "8.0.23"               

    identifier = "db-master-dev"                 
    name = "db"
    username = "admin"
    password = "skcc70491"                  

    port = 3306 
    availability_zone = var.az_a
    allow_major_version_upgrade = true
    auto_minor_version_upgrade = true
    backup_retention_period = 14            
    copy_tags_to_snapshot = true            
    vpc_security_group_ids = [aws_security_group.db_sg_dev.id]

    tags = {
        Name = "70491-DB_dev"
    }
}