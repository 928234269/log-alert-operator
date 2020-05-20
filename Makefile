.PHONY: build dev gen deploy

VERSION := v0.0.1
TAG := example.com/log-alert-operator:$(VERSION)

CRD := ./deploy/crds/*_crd.yaml
CR := ./deploy/crds/*_cr.yaml
CR-2 := ./deploy/crds/*_cr_2.yaml

NS = demo
KC = kubectl -n $(NS)

# compile test
run:
	go run ./cmd/manager

# 生成crd
gen:
	operator-sdk generate k8s --verbose \
	&& operator-sdk generate crds --verbose

# 本地run
dev:
	# --operator-flags="--zap-level=debug --zap-encoder=console"
	# local不能连接k8s的svc
	operator-sdk up local --namespace $(NS) --operator-flags="--zap-devel"

build:
	operator-sdk build $(TAG)

replace-operator:
	$(KC) replace --force -f $(OPERATOR)

rollout-restart:
	$(KC) rollout restart deploy log-alert-operator


kind-load:
	kind load docker-image $(TAG)

kind-update: build kind-load replace-operator

# 部署operator
deploy-operator-all: apply-crd
	$(KC) apply -f ./deploy

apply-crd:
	$(KC) apply -f $(CRD)

# WARN!!! 删除crd会清除所有crd的实例
delete-crd:
	$(KC) delete -f $(CRD)

replace-cr:
	$(KC) replace --force -f $(CR)

replace-cr-2:
	$(KC) replace --force -f $(CR-2)