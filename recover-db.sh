# get pg pod and recover db backup
PGPOD=$( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")
kubectl cp pg/sql_files/my_pumps_dump.sql $PGPOD:/tmp
kubectl exec $PGPOD -- psql postgres -f tmp/my_pumps_dump2.sql