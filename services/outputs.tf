output "usage_source_data_bucket_name" {
  value = module.power_usage_data_bucket.s3_bucket_id
}

output "usage_query_result_bucket_name" {
  value = module.power_usage_query_result_bucket.s3_bucket_id
}
