resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subnet1_cidr
    availability_zone = "${var.region}a"
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subnet2_cidr
    availability_zone = "${var.region}b"
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "route" {
    route_table_id = aws_route_table.route_table.id
    gateway_id = aws_internet_gateway.internet_gateway.id
    destination_cidr_block = var.world_cidr
}

resource "aws_route_table_association" "subnet1_association" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_association" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "security_group" {
    vpc_id = aws_vpc.vpc.id
    name = var.security_group_name
    ingress = [{
        description      = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.world_cidr}"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    },{
        description      = "All TCP"
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["${var.world_cidr}"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    },{
        description      = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.world_cidr}"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }]
    
    egress = [{
        description      = "For all Outgoing Traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.world_cidr}"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }]
}

output "subnets" {
  value = "${aws_subnet.subnet1.id},${aws_subnet.subnet2.id}"
}

output "security_groups" {
  value = "${aws_security_group.security_group.id}"
}