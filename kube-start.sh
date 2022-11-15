az aks get-credentials --resource-group flask-portfolio-project --name k8-cluster-flask 

kubectl delete deployment flask-app
kubectl delete deployment pg
kubectl delete deployment pgadmin

kubectl create -f flask-app-deployment.yaml
kubectl create -f c-persistentvolumeclaim.yaml
kubectl create -f pg-deployment.yaml
kubectl create -f pgadmin-deployment.yaml
kubectl proxy
kubectl expose deployment/flask-app --type="LoadBalancer" --port 5000
kubectl expose deployment/pg --type="NodePort" --port 5432
kubectl expose deployment/pgadmin --type="LoadBalancer" --port 5433

# dump db backup
PGPOD = $( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")
kubectl exec $PGPOD -- pg_dump postgres > pg/my_pumps_dump.sql


# get pg pod and recover db backup
PGPOD = $( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")
kubectl cp pg/sql_files/my_pumps_dump.sql $PGPOD:/tmp
kubectl exec $PGPOD -- psql postgres -f tmp/my_pumps_dump.sql