variable "test_run_unique_identifier" {
  type        = string
  description = "A unique identifier of the test run to avoid colliding resource names in Azure."

  validation {
    condition = can(regex("^[A-Za-z]+$", var.test_run_unique_identifier))
    error_message = "The test_run_unique_identifier must only consist of the characters A-Z (case insensitive)."
  }
  validation {
    condition = 4 <= length(var.test_run_unique_identifier) && length(var.test_run_unique_identifier) <= 15
    error_message = "The test_run_unique_identifier must be between 4 and 10 characters long."
  }
}