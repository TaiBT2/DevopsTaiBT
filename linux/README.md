## COMMON COMMAND
- check size folder
```
find /mnt/HDD/nfs -type f -size +1M -exec du -h {} + | sort -rh | head -n 10
```
- rsync
```
rsync -aP /mnt/HDD/nfs/s24dapvpwebpt-test-data-postgresql-0-pvc-c00f4d3e-bea1-4d6d-89f4-e04a0fe5ed1a/ root@10.0.0.79:/mnt/HDD/nfs/k8s-pv/pvc-337e408e-ea8d-4225-87a8-ba6e8ee8ec1a/
```
- run suppervisord 
```
"/usr/bin/supervisord", "-c", "/etc/supervisord.conf"
```
- check size folder , file
```
du -sh /path_folder
du -sh /file_name
```
```
sudo sync; echo 1 > /proc/sys/vm/drop_caches
du -hsc /var/docker/overlay2
find -type f -exec du -sh {} + | sort -rh | head -n 5
netstat -a -o | grep mysql
---

---
prompt:
 - clear :cls
 - ls: dir
 - ipconfig /flushdns
---
kubectl create secret docker-registry fms-repo-key --docker-server=nexusrepo.rikkei.org --docker-username=admin --docker-password=secret --docker-email=thanhtai18021994@gmail.com -n fms
---

db.createUser({
    user: "rkdg1-user",
    pwd: "12345678",
    roles: [
      "readWrite"
    ],
    passwordDigestor: "server"
  })

--
db.adminCommand(
   {
      shutdown: 1,
      comment: "Convert to cluster"
   }
)
---
mongod --auth --port <port> --dbpath /var/lib/mongodb --replSet 
mongod --auth --port 27017 --dbpath "/home/taibt/data" --replSet "rs0"
--
cfg = rs.conf()
cfg.members[0].host = "mongo2.example.net"
rs.reconfig(cfg)
--
sudo iptables -I INPUT -i eth0 -p tcp --dport 3306 -m comment --comment "# Anaconda Repo #" -j ACCEPT
```