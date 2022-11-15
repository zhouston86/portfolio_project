# dump db backup
PGPOD=$( kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "pg-")

LEN=$( echo -n $PGPOD | wc -m)
echo $LEN

if [ $LEN -gt 0 ]
then
    echo 'delete'
    kubectl exec $PGPOD -- pg_dump postgres > pg/my_pumps_dump2.sql
fi