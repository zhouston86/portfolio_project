# get pg pod and recover db backup
sleep 10
PGPOD2=$( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")
echo $PGPOD2
kubectl cp pg/my_pumps_dump2.sql $PGPOD2:/tmp
kubectl exec $PGPOD2 -- psql postgres -f tmp/my_pumps_dump2.sql