resource "aws_db_subnet_group" "db_subnet_group" {
    name = "db-subnet-group"
    subnet_ids = [aws_subnet.db_private_subnet_a.id, aws_subnet.db_private_subnet_c.id]

    tags = {
        Name = "70491_db_subnet_group"
    }
}

resource "aws_db_instance" "db" {
    instance_class = "db.t3.micro"          
    storage_type = "gp2"                    
    allocated_storage = 20                  
    max_allocated_storage = 40              

    engine = "mysql"
    engine_version = "8.0.23"               

    identifier = "db"                 
    name = "70491_db"
    username = "admin"                      
    password = "skcc70491"                  

    port = 3306                             
    multi_az = true                         
    availability_zone = var.az_a            
    publicly_accessible = false             
    allow_major_version_upgrade = true
    auto_minor_version_upgrade = true
    backup_retention_period = 14            
    copy_tags_to_snapshot = true            
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
    vpc_security_group_ids = [aws_security_group.db_sg.id]
}