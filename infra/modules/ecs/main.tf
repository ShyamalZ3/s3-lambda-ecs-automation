resource "aws_ecs_cluster" "cluster" {
    name = var.cluster_name
    configuration {
      execute_command_configuration {
        logging = "OVERRIDE"
        log_configuration {
          cloud_watch_encryption_enabled = true
          cloud_watch_log_group_name = var.loggroup_name
        }
      }
    }
}

resource "aws_iam_policy" "role_policy" {
  name = "${var.ecs_policy_name}"
  description = "Policy for ${var.task_family}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:AssociateAddress",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "ecs_task_role" {
    name = var.task_role_name
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role" "ecs_execution_role" {
    name = var.execution_role_name
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy" {
    policy_arn = aws_iam_policy.role_policy.arn
    role = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
    policy_arn = var.task_execution_role_arn
    role = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
    policy_arn = var.policy_arn
    role = aws_iam_role.ecs_execution_role.name
}

resource "aws_ecs_task_definition" "ecs_task" {
    family = var.task_family
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = 1024
    memory = 3072
    execution_role_arn = aws_iam_role.ecs_execution_role.arn
    task_role_arn = aws_iam_role.ecs_task_role.arn

    container_definitions = jsonencode([{
        name = var.container_name
        essential = true
        image = var.image_uri
        cpu = 1024
        memory = 3072
        environment = [
            { name="bucket_name", value="default_bucket_name" },
            { name="path", value="default_path"}
        ]
        portMappings = [
            { containerPort = 80, hostPort = 80, protocol = "tcp", appProtocol="http" }
        ]
    }])

    runtime_platform {
      operating_system_family = "LINUX"
      cpu_architecture        = "X86_64"
    }

    lifecycle {
      create_before_destroy = true
    }
}

output "container_name" {
  value = var.container_name
}

output "task_name" {
  value = var.task_family
}

output "cluster_name" {
  value = var.cluster_name
}