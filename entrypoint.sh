#
# WORKDIR = /github/workspace
#
PATH=/usr/local/bin:$HOME/.local/bin:$PATH
eksctl utils write-kubeconfig --cluster=${EKSCTL_CLUSTER_NAME}
export KUBECONFIG=/github/home/.kube/config

EXPERIMENT_NAME="run-${GITHUB_SHA::8}"
kale --nb ${KALE_NOTEBOOK} --run_pipeline --experiment_name=${EXPERIMENT_NAME}

# wait until the pipeline finish
