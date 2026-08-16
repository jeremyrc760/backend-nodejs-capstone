resource "aws_cloudwatch_dashboard" "backend" {
  dashboard_name = "${var.project_name}-backend-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 3

        properties = {
          markdown = "# SecondChance ECS Monitoring\n\nTerraform-managed dashboard for backend and frontend ECS Fargate services, ALB target groups, response time, target health, CPU, and memory."
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 3
        width  = 12
        height = 6

        properties = {
          title   = "Backend ALB Requests and 5XX Errors"
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          period  = 60

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "TargetGroup",
              aws_lb_target_group.backend.arn_suffix,
              "LoadBalancer",
              aws_lb.backend.arn_suffix,
              {
                stat  = "Sum"
                label = "Backend Requests"
              }
            ],
            [
              ".",
              "HTTPCode_Target_5XX_Count",
              ".",
              ".",
              ".",
              ".",
              {
                stat  = "Sum"
                label = "Backend Target 5XX"
              }
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 3
        width  = 12
        height = 6

        properties = {
          title   = "Frontend ALB Requests and 5XX Errors"
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          period  = 60

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "TargetGroup",
              aws_lb_target_group.frontend.arn_suffix,
              "LoadBalancer",
              aws_lb.backend.arn_suffix,
              {
                stat  = "Sum"
                label = "Frontend Requests"
              }
            ],
            [
              ".",
              "HTTPCode_Target_5XX_Count",
              ".",
              ".",
              ".",
              ".",
              {
                stat  = "Sum"
                label = "Frontend Target 5XX"
              }
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 9
        width  = 12
        height = 6

        properties = {
          title   = "Backend Response Time and Healthy Targets"
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          period  = 60

          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "TargetGroup",
              aws_lb_target_group.backend.arn_suffix,
              "LoadBalancer",
              aws_lb.backend.arn_suffix,
              {
                stat  = "Average"
                label = "Backend Response Time"
              }
            ],
            [
              ".",
              "HealthyHostCount",
              ".",
              ".",
              ".",
              ".",
              {
                stat  = "Average"
                label = "Backend Healthy Targets"
              }
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 9
        width  = 12
        height = 6

        properties = {
          title   = "Frontend Response Time and Healthy Targets"
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          period  = 60

          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "TargetGroup",
              aws_lb_target_group.frontend.arn_suffix,
              "LoadBalancer",
              aws_lb.backend.arn_suffix,
              {
                stat  = "Average"
                label = "Frontend Response Time"
              }
            ],
            [
              ".",
              "HealthyHostCount",
              ".",
              ".",
              ".",
              ".",
              {
                stat  = "Average"
                label = "Frontend Healthy Targets"
              }
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 15
        width  = 12
        height = 6

        properties = {
          title   = "Backend ECS CPU and Memory Utilization"
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          period  = 60

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.backend.name,
              {
                stat  = "Average"
                label = "Backend CPU"
              }
            ],
            [
              ".",
              "MemoryUtilization",
              ".",
              ".",
              ".",
              ".",
              {
                stat  = "Average"
                label = "Backend Memory"
              }
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 15
        width  = 12
        height = 6

        properties = {
          title   = "Frontend ECS CPU and Memory Utilization"
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          period  = 60

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.frontend.name,
              {
                stat  = "Average"
                label = "Frontend CPU"
              }
            ],
            [
              ".",
              "MemoryUtilization",
              ".",
              ".",
              ".",
              ".",
              {
                stat  = "Average"
                label = "Frontend Memory"
              }
            ]
          ]
        }
      }
    ]
  })
}