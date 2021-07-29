resource "aws_cloudtrail" "cloudtrail" {
    name = "70491-cloudtrail"
    s3_bucket_name = aws_s3_bucket.cloudtrail_bucket.id
    
    include_global_service_events = false
    is_multi_region_trail = false

    event_selector {
        read_write_type = "All"
        include_management_events = true
    }
}