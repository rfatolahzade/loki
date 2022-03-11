{
helm repo add grafana https://grafana.github.io/helm-charts
kubectl create ns loki
helm upgrade --install loki grafana/loki-stack  --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false -n loki
}

kubectl create -f sc-local-storage.yaml -f loki-pv.yaml -f loki-pvc.yaml

sleep 60 
echo "YourPassword for user admin is":
{
kubectl get secret --namespace loki loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
}
echo "visit localhost:3000"
kubectl port-forward --namespace loki service/loki-grafana 3000:80

