PATH=/usr/local/bin:$HOME/.local/bin:$PATH
eksctl utils write-kubeconfig --cluster=${EKSCTL_CLUSTER_NAME}
kale
