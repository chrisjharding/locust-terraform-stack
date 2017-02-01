
# created a vpc and a route table
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    tags {
        Name = "${var.name}-vpc"
    }
}

# allow the network to have internet access
resource "aws_route" "r" {
    route_table_id = "${aws_vpc.main.default_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
}

# create public subnets (this is only a load test cluster so we don't need 1 per az or a private)
resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.main.id}"
    count = "${length(split(",", lookup(var.azs, var.region)))}"
    cidr_block = "${cidrsubnet(var.vpc_cidr, 4, count.index)}"
    availability_zone = "${element(split(",", lookup(var.azs, var.region)), count.index)}"
    map_public_ip_on_launch = true

    tags {
        Name = "${var.name}-subnet-public-${element(split(",", lookup(var.azs, var.region)), count.index)}"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${var.name}-igw"
    }
}
