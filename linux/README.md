## COMMON COMMAND
- check size folder
```
find /mnt/HDD/nfs -type f -size +1M -exec du -h {} + | sort -rh | head -n 10
```
- rsync
```
rsync -aP /mnt/HDD/nfs/s24dapvpwebpt-test-data-postgresql-0-pvc-c00f4d3e-bea1-4d6d-89f4-e04a0fe5ed1a/ root@10.0.0.79:/mnt/HDD/nfs/k8s-pv/pvc-337e408e-ea8d-4225-87a8-ba6e8ee8ec1a/
```