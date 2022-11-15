
# dump db backup
PGPOD=$( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")

LEN=$( $PGPOD | wc -c)
echo $LEN

if [ $LEN -gt 0 ]
then
    echo 'delete'
    kubectl exec $PGPOD -- pg_dump postgres > pg/my_pumps_dump2.sql
fi

# kubectl delete deployment flask-app
# kubectl delete deployment pg
# kubectl delete deployment pgadmin

# kubectl create -f flask-app-deployment.yaml
# kubectl create -f c-persistentvolumeclaim.yaml
# kubectl create -f pg-deployment.yaml
# kubectl create -f pgadmin-deployment.yaml
# kubectl proxy
# kubectl expose deployment/flask-app --type="LoadBalancer" --port 5000
# kubectl expose deployment/pg --type="NodePort" --port 5432
# kubectl expose deployment/pgadmin --type="LoadBalancer" --port 5433


# # get pg pod and recover db backup
# PGPOD=$( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")
# kubectl cp pg/sql_files/my_pumps_dump.sql $PGPOD:/tmp
# kubectl exec $PGPOD -- psql postgres -f tmp/my_pumps_dump.sql