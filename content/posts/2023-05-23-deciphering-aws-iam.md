
Terraform error:
```
╷
│ Error: error creating EC2 VPN Connection Route (10.51.200.0/21:vpn-xxxxxxxxxx): UnauthorizedOperation: You are not authorized to perform this operation. Encoded authorization failure message: xxxxxx
│ 	status code: 403, request id: 3d3b00b0-3ad4-465f-ba64-0ebefc913e02
│
│   with aws_vpn_connection_route.vpn_connection_route_1["hub"],
│   on aws.tf line 58, in resource "aws_vpn_connection_route" "vpn_connection_route_1":
│   58: resource "aws_vpn_connection_route" "vpn_connection_route_1" {
│
```

You need to add `ec2:CreateVpnConnectionRoute` to the IAM Policy, the policy we use for creating VPN Connections between AWS & Azure uses the following policy:

```hcl
resource "aws_iam_user_policy" "als_vpn" {
  name = "als-vpn-mgmt"
  user = aws_iam_user.als.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*",
        "ec2:CreateTags",
        "elasticloadbalancing:Describe*",
        "sts:GetCallerIdentity",
        "ec2:CreateCustomerGateway",
        "ec2:CreateVpnConnection"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
```
