output "cluster_name" {
    value = aws_eks_cluster.mycluster.name
}

output "cluster_endpoint" {
    value = aws_eks_cluster.mycluster.endpoint
}