function logs() {
	kubectl logs $(kubectl get pods | grep "$1" | grep -v "Terminating" | awk '{print $1}')
}

function attach() {
	kubectl exec -it $(kubectl get pods | grep "$1" | grep -v "Terminating" | awk '{print $1}') -- sh
}
