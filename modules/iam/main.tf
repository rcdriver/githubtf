### 12. Instance profile, IAM Role, IAM Policy resource

# IAM Role for EC2 without using data block

resource "aws_iam_role" "dev_ec2_ssm_role" {
  name = "dev_ec2_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach Amazon SSM Managed Policy to the role
resource "aws_iam_role_policy_attachment" "dev_ssm_policy" {
  role       = aws_iam_role.dev_ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "dev_ec2_ssm_instance_profile" {
  name = "dev_ec2_ssm_instance_profile"
  role = aws_iam_role.dev_ec2_ssm_role.name
}
