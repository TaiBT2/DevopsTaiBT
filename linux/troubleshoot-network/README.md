## TROUBLESHOOTING NETWORK
- Check log network specific time
```sh
sudo journalctl -u NetworkManager --since "2024-06-01 22:00:00" --until "2024-06-01 23:50:00"
```
- check log current time
```
sudo tcpdump -i enp6s0
```