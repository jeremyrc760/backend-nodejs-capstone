resource "aws_cloudwatch_metric_alarm" "backend_alb_5xx" {
  alarm_name          = "${var.project_name}-backend-alb-5xx"
  alarm_description   = "Alarm when the backend ALB returns 5XX responses."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_Target_5XX_Count"
  statistic           = "Sum"
  period              = 60
  evaluation_periods  = 2
  datapoints_to_alarm = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = aws_lb.backend.arn_suffix
  }

  tags = {
    Name = "${var.project_name}-backend-alb-5xx"
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_alb_response_time" {
  alarm_name          = "${var.project_name}-backend-alb-response-time"
  alarm_description   = "Alarm when backend ALB target response time is too high."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "TargetResponseTime"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = aws_lb.backend.arn_suffix
  }

  tags = {
    Name = "${var.project_name}-backend-alb-response-time"
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_healthy_targets" {
  alarm_name          = "${var.project_name}-backend-healthy-targets-low"
  alarm_description   = "Alarm when the backend target group has fewer healthy targets than expected."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HealthyHostCount"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 2
  datapoints_to_alarm = 2
  threshold           = 2
  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "breaching"

  dimensions = {
    LoadBalancer = aws_lb.backend.arn_suffix
    TargetGroup  = aws_lb_target_group.backend.arn_suffix
  }

  tags = {
    Name = "${var.project_name}-backend-healthy-targets-low"
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_ecs_cpu_high" {
  alarm_name          = "${var.project_name}-backend-ecs-cpu-high"
  alarm_description   = "Alarm when backend ECS service CPU utilization is high."
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 3
  threshold           = 70
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.backend.name
  }

  tags = {
    Name = "${var.project_name}-backend-ecs-cpu-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_ecs_memory_high" {
  alarm_name          = "${var.project_name}-backend-ecs-memory-high"
  alarm_description   = "Alarm when backend ECS service memory utilization is high."
  namespace           = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 3
  threshold           = 80
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.backend.name
  }

  tags = {
    Name = "${var.project_name}-backend-ecs-memory-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_alb_5xx" {
  alarm_name          = "${var.project_name}-frontend-alb-5xx"
  alarm_description   = "Alarm when the frontend target group returns 5XX responses."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_Target_5XX_Count"
  statistic           = "Sum"
  period              = 60
  evaluation_periods  = 2
  datapoints_to_alarm = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = aws_lb.backend.arn_suffix
    TargetGroup  = aws_lb_target_group.frontend.arn_suffix
  }

  tags = {
    Name = "${var.project_name}-frontend-alb-5xx"
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_alb_response_time" {
  alarm_name          = "${var.project_name}-frontend-alb-response-time"
  alarm_description   = "Alarm when frontend target response time is too high."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "TargetResponseTime"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = aws_lb.backend.arn_suffix
    TargetGroup  = aws_lb_target_group.frontend.arn_suffix
  }

  tags = {
    Name = "${var.project_name}-frontend-alb-response-time"
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_healthy_targets" {
  alarm_name          = "${var.project_name}-frontend-healthy-targets-low"
  alarm_description   = "Alarm when the frontend target group has fewer healthy targets than expected."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HealthyHostCount"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 2
  datapoints_to_alarm = 2
  threshold           = 2
  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "breaching"

  dimensions = {
    LoadBalancer = aws_lb.backend.arn_suffix
    TargetGroup  = aws_lb_target_group.frontend.arn_suffix
  }

  tags = {
    Name = "${var.project_name}-frontend-healthy-targets-low"
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_ecs_cpu_high" {
  alarm_name          = "${var.project_name}-frontend-ecs-cpu-high"
  alarm_description   = "Alarm when frontend ECS service CPU utilization is high."
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 3
  threshold           = 70
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.frontend.name
  }

  tags = {
    Name = "${var.project_name}-frontend-ecs-cpu-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_ecs_memory_high" {
  alarm_name          = "${var.project_name}-frontend-ecs-memory-high"
  alarm_description   = "Alarm when frontend ECS service memory utilization is high."
  namespace           = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 3
  threshold           = 80
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.frontend.name
  }

  tags = {
    Name = "${var.project_name}-frontend-ecs-memory-high"
  }
}
