# log-alert-operator
## create
operator-sdk new log-alert-operator --repo=github.com/example-inc/log-alert-operator
## add crd & ctrl
operator-sdk add api --api-version=example.com/v1alpha1 --kind=LogAlert

operator-sdk add controller --api-version=example.com/v1alpha1 --kind=LogAlert

## apply cr & run operator local
export KUBECONFIG="$HOME/.kube/config"

make apply-crd
make dev 
## apply cr
make replace-cr

make replace-cr-2