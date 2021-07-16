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
    db_subnet_group_name = var.db_private_subnet_a
    vpc_security_group_ids = [aws_security_group.db_sg.id]


    # 표준 생성
    
    # template : develoment/test
    # Connection    > VPC > main_vpc
    #               > Subnet Group > new subnet group?
    #               > vpc Security Group > make new SG (db_sg)
    # DB Authentication > Password Authentication
    # More Configuration    > DB Option > ?
    #                       > Backup > Allow
    #                       > Backup Time > default
}