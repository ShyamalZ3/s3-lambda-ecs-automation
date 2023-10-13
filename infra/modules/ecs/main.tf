# resource "aws_ecs_cluster" "ecs_cluster" {
#   name = "ecs_cluster_name"
# }

# # resource "aws_ecs_task_definition" "ecs_task" {
# #   family                = "ecs_task_family"
# #   container_definitions = file("container_definitions.json")
# # }

# output "ecs_cluster_name" {
#   value = aws_ecs_cluster.ecs_cluster.name
# }