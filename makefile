MAKEFLAGS+=--silent
.PHONY: default check apply destroy template

default:
	docker-compose up -d

check:
	kubectl --kubeconfig kubeconfig.yaml cluster-info
	kubectl --kubeconfig kubeconfig.yaml get node

apply:
	docker run --rm -v $$PWD/helm:/apps alpine/helm:3.0.1 template . | \
	kubectl --kubeconfig kubeconfig.yaml apply -f -
	kubectl --kubeconfig kubeconfig.yaml rollout status -n timescaledb-prometheus-grafana deploy grafana
	kubectl --kubeconfig kubeconfig.yaml rollout status -n timescaledb-prometheus-grafana sts prometheus
	kubectl --kubeconfig kubeconfig.yaml rollout status -n timescaledb-prometheus-grafana sts timescaledb
	kubectl --kubeconfig kubeconfig.yaml rollout status -n timescaledb-prometheus-grafana deploy prom-pg-adapter
	printf 'http://%s:3000\n' $$(kubectl --kubeconfig kubeconfig.yaml get svc -n timescaledb-prometheus-grafana grafana -o json | \
	jq -rc '.status.loadBalancer.ingress[0].ip')

destroy:
	docker-compose down

template:
	docker run --rm -v $$PWD/helm:/apps alpine/helm:3.0.1 template .
