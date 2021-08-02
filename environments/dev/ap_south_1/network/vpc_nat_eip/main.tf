resource "aws_eip" "vpc_nat" {
  count = 3
  vpc = true
}
