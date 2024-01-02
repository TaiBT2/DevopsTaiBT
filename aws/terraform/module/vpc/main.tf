resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Project = var.project_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnets[0]
  availability_zone = var.availability_zones[1]
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnets[1]
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnets[0]
  availability_zone = var.availability_zones[0]
}

resource "aws_route_table" "route_table_pb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.project_name}-public"
  }  
  depends_on = [ aws_internet_gateway.gw, aws_vpc.vpc ]
}

resource "aws_route_table_association" "my_route_table_association_pb" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table_pb.id

  depends_on = [ aws_route_table.route_table_pb, aws_subnet.public_subnet ]
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "${var.project_name}-private"
  }  
}
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "my_route_table_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "eipalloc-017a5be03a54c9c94"
  subnet_id     = aws_subnet.public_subnet.id
}

