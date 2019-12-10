#
# WORKDIR = /github/workspace
#
PATH=/usr/local/bin:$HOME/.local/bin:$PATH
eksctl utils write-kubeconfig --cluster=${EKSCTL_CLUSTER_NAME}
cat /github/home/.kube/config

export KUBECONFIG=/github/home/.kube/config
kubectl proxy --port=8080 &
sleep 2

kale --nb ${KALE_NOTEBOOK} --run_pipeline --kfp_host=127.0.0.1:8080