resource "aws_vpc" "tr_vpc" {
  cidr_block = var.vpc-ip

  tags = merge(var.tags, {
    Name = format("%s-%s", var.vpc-name, "${terraform.workspace}")
  })
}


resource "aws_subnet" "pub-sub" {
  vpc_id            = aws_vpc.tr_vpc.id
  cidr_block        = var.sub-ip
  availability_zone = var.AZ

  tags = merge(var.tags, {
    Name = format("%s-%s", var.subnet-name, "${terraform.workspace}")
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tr_vpc.id

  tags = merge(var.tags, {
    Name = "tr-igw-${terraform.workspace}"
  })
}


resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.tr_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.tags, {
    Name = "rt-pub-${terraform.workspace}"
  })
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.rt-pub.id
}
