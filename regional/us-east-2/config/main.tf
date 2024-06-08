resource "aws_iam_service_linked_role" "config" {
  aws_service_name = "config.amazonaws.com"
}

resource "aws_config_configuration_recorder_status" "config" {
  name       = aws_config_configuration_recorder.config.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.config]
}

resource "aws_config_delivery_channel" "config" {
  name           = "goldrock"
  s3_bucket_name = var.configservice_bucket_name
}

resource "aws_config_configuration_recorder" "config" {
  name     = "goldrock"
  role_arn = aws_iam_service_linked_role.config.arn
  #role_arn = "arn::iam::398930073421:role/aws-service-role/config.amazonaws.com/AWSServiceRoleForConfig"

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }

  recording_mode {
    recording_frequency = "CONTINUOUS"
  }
}

variable "configservice_bucket_name" {
  type = string
}
