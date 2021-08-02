output "external_nat_ip_ids" {
  value       = aws_eip.vpc_nat.*.id
  description = "The elastic public ip address for vpc nat gateway"
}
