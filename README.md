# Bootstraping Docker

```
$ sudo salt "*" state.apply
```

# Launching iperf servers and clients

```
#cleanup
docker service rm iperf-servers iperf-clients
docker network rm my-network
sleep 1

docker network create  --driver overlay  my-network
sleep 1

docker service create \
 --replicas 3 \
 --name iperf-servers \
 --network my-network \
 --detach=true \
 nherbaut/netcont:latest \
 iperf -s -p 5000

sleep 1
docker service update  --publish-add 5001:5000 iperf-servers --detach=true

sleep 1

docker service create \
 --replicas 3 \
 --name iperf-clients \
 --network my-network \
 --detach=true \
 nherbaut/netcont:latest \
 iperf -c 192.168.56.102 -p 5001 -t 3
 
```
