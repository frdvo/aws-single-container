resource "aws_ecs_cluster" "cluster" {
  name = "${var.container_name}-cluster-${random_id.container.hex}"
}

resource "aws_ecs_task_definition" "task_definition" {
  family = "${var.container_name}-family-${random_id.container.hex}"
  #   execution_role_arn       = aws_iam_role.webapp_ecs_task_execution_role.arn
  #   task_role_arn            = aws_iam_role.webapp_ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  #   volume {
  #     name = "webapp_efs"
  #     efs_volume_configuration {
  #       file_system_id = var.efs_id
  #     }
  #   }

  container_definitions = jsonencode([
    {
      name      = "Fargate-Container"
      image     = var.app_image
      essential = true
      #   mountPoints = [
      #     {
      #       sourceVolume  = "webapp_efs"
      #       containerPath = "/var/www/html"
      #     }
      #   ]
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
        }
      ]
      #   "logConfiguration" : {
      #     "logDriver" : "awslogs",
      #     "options" : {
      #       "awslogs-group" : "/ecs/webapp",
      #       "awslogs-region" : var.aws_region,
      #       "awslogs-stream-prefix" : "ecs"
      #     }
      #   }
      #   "secrets" : [
      #     {
      #       "name" : "WORDPRESS_DB_HOST",
      #       "valueFrom" : var.rds_endpoint
      #     },
      #     {
      #       "name" : "WORDPRESS_DB_USER",
      #       "valueFrom" : var.rds_database_username
      #     },
      #     {
      #       "name" : "WORDPRESS_DB_PASSWORD",
      #       "valueFrom" : var.rds_database_password
      #     },
      #     {
      #       "name" : "WORDPRESS_DB_NAME",
      #       "valueFrom" : var.rds_database_username
      #     }
      #   ]
    }
  ])

}

resource "aws_ecs_service" "service" {
  name                 = "${var.container_name}-service-${random_id.container.hex}"
  cluster              = aws_ecs_cluster.cluster.id
  task_definition      = aws_ecs_task_definition.task_definition.arn
  desired_count        = 1
  launch_type          = "FARGATE"
  platform_version     = "1.4.0"
  force_new_deployment = true
  scheduling_strategy  = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.fargate_sg.id]
    subnets          = [var.public_subnet]
    assign_public_ip = true
  }

  #   load_balancer {
  #     target_group_arn = aws_alb_target_group.webapp_tg.id
  #     container_name   = "webapp"
  #     container_port   = var.app_port
  #   }

  #   depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.attach_ecs_task_execution_role, aws_iam_role_policy_attachment.attach_ecs_task_role]
}