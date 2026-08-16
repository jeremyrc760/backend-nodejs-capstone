resource "aws_cloudwatch_log_group" "backend" {
  name              = "/aws/ecs/${var.project_name}-backend"
  retention_in_days = 3

  tags = {
    Name    = "${var.project_name}-backend-logs"
    Project = var.project_name
    Managed = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/aws/ecs/${var.project_name}-frontend"
  retention_in_days = 3

  tags = {
    Name    = "${var.project_name}-frontend-logs"
    Project = var.project_name
    Managed = "terraform"
  }
}