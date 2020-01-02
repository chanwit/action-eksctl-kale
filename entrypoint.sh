#
# WORKDIR = /github/workspace
#
PATH=/usr/local/bin:$HOME/.local/bin:$PATH
eksctl utils write-kubeconfig --cluster=${EKSCTL_CLUSTER_NAME}
export KUBECONFIG=/github/home/.kube/config

PIPELINE_NAME="pipeline-${GITHUB_SHA::8}"
EXPERIMENT_NAME="experiment-${GITHUB_SHA::8}"
kale --nb ${KALE_NOTEBOOK} --run_pipeline \
	--pipeline_name=${PIPELINE_NAME} \
	--experiment_name=${EXPERIMENT_NAME}

sleep 2
# wait until the pipeline finish
PIPELINE_STATUS="Running"
while [ "$PIPELINE_STATUS" == "Running" ]
do
	PIPELINE_STATUS=$(kubectl get workflow -n kubeflow -o jsonpath="{.items[?(@.spec.entrypoint=='${PIPELINE_NAME}')].status.phase}")
	echo "Current status: ${PIPELINE_STATUS} ..."
	sleep 10
done
