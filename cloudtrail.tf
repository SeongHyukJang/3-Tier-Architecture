resource "aws_cloudtrail" "cloudtrail" {
    name = "70491-cloudtrail"
    s3_bucket_name = aws_s3_bucket.log_bucket.id
    
    include_global_service_events = false
    is_multi_region_trail = false

    kms_key_id = "70491-cloudtrail-kms"

    event_selector {
        read_write_type = "All"
        include_management_events = true
    }
}