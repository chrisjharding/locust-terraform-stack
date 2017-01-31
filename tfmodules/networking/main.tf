
# created a vpc and a route table
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
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

# create 1 public (this is only a load test cluster so we don't need 1 per az or a private)
resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    tags {
        Name = "${var.name}-subnet-public-1"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${var.name}-igw"
    }
}
