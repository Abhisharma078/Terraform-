# default vpc use 

data "aws_vpc" "default" {
    default = true
}

#default subnet use

data "aws_subnets" "default" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.default.id]       
    }
}

# create cluster role

resource "aws_iam_role" "cluster_role" {
    name = "cluster_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = { Service = "eks.amazonaws.com"}
            Action = "sts:AssumRole"
        }]
    })
}

#create cluster policy

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
    role = aws_iam_role.cluster_role.name
    policy_arn = "arn:aws:iam::aws:policy//AmazonEKSClusterPolicy"  
}

#create node role

resource "aws_iam_role" "node_role" {
    name = "node_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = { Service = "ec2.amazonaws.com"}
            Action = "sts:AssumRole"
        }]
    })
}

#create node policies

resource "aws_iam_role_policy_attachment" "node_policies" {
    count = 3
    role = aws_iam_role.node_role.name

    policy_arn = element([
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ], count.index)
}

#cluster create

resource "aws_eks_cluster" "mycluster" {
    name = "mycluster"

    role_arn = aws_iam_role.cluster_role.arn
    version = "1.36"

    vpc_config {
      subnet_ids = data.aws_subnets.default.ids
    }

    depends_on = [ aws_iam_role_policy_attachment.eks_cluster_policy] 
}

# create node 

resource "aws_eks_node_group" "nodegroup" {
    cluster_name = aws_eks_cluster.mycluster.name
    node_group_name = "nodegroup"
    node_role_arn = aws_iam_role.node_role.arn
    subnet_ids = data.aws_subnets.default.ids
    instance_types = ["t3.micro"]

    scaling_config {
      desired_size = 1
      max_size = 2
      min_size = 1
    }

    depends_on = [ aws_iam_role_policy_attachment.node_policies ]


  
}