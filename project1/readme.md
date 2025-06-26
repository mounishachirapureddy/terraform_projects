
## 🚀 VPC Peering Setup with Terraform

This project sets up a **VPC peering connection** between two VPCs using Terraform.
It supports **both creating new VPCs** or **peering existing VPCs created manually via AWS Console or other tools**.

---

### ✅ Option 1: Create and Peer Two New VPCs

You can create two new VPCs and peer them automatically:

```bash
terraform init
terraform apply -var="env=dev" \
                -var="vpc_a_cidr=10.0.0.0/16" \
                -var="vpc_b_cidr=10.1.0.0/16"
```

This will:

* Create VPC A and VPC B with the given CIDR blocks
* Create a VPC peering connection between them
* Tag all resources using the `env` value (e.g., `dev`)

---

### 🔄 Option 2: Peer Two **Existing VPCs**

If you already have two VPCs created manually (via console or scripts), follow these steps to peer them:

#### 📋 1. Add the Existing VPCs to `main.tf`

Keep the resource blocks for `aws_vpc.vpc_a` and `aws_vpc.vpc_b` **in your code**, even though Terraform won't create them again.

#### 📥 2. Import the VPCs into Terraform

Replace the VPC IDs with your actual values:

```bash
terraform init

terraform import aws_vpc.vpc_a vpc-xxxxxxxxxxxxxxxxx
terraform import aws_vpc.vpc_b vpc-yyyyyyyyyyyyyyyyy
```

> Make sure the corresponding `cidr_block` values in `variables.tf` match your existing VPC CIDRs.

#### 🔍 3. Review with `terraform plan`

Terraform will now recognize and manage the existing VPCs in its state.
You may see minor drift (e.g., tags) — confirm that nothing destructive will happen.

#### 🚀 4. Apply the Peering Connection

```bash
terraform apply -var="env=dev" \
                -var="vpc_a_cidr=10.0.0.0/16" \
                -var="vpc_b_cidr=10.1.0.0/16"
```

✅ Only the **peering connection** and any uncreated resources will be applied.

