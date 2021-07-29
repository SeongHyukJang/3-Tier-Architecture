resource "aws_cloudtrail" "cloudtrail" {
    name = "70491-cloudtrail"
    s3_bucket_name = aws_s3_bucket.log_bucket.id
    
    include_global_service_events = false
    is_multi_region_trail = false

    kms_key_id = "arn:aws:kms:ap-northeast-2:533616270150:key/972c3086-0ae7-4dca-b921-8e388272846a"

    event_selector {
        read_write_type = "All"
        include_management_events = true
    }
}