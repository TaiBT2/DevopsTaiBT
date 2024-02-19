## COMMON COMMAND
- check size folder
```
find /mnt/HDD/nfs -type f -size +1M -exec du -h {} + | sort -rh | head -n 10
```