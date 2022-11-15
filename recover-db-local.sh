# get pg pod and recover db backup
sleep 3
PGPOD=$( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")
echo $PGPOD
kubectl cp pg/sql_files/my_pumps_dump.sql $PGPOD:/tmp
kubectl exec $PGPOD -- psql postgres -f tmp/my_pumps_dump.sql