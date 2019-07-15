docker build -t bpanneer/multi-client:latest -t bpanneer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bpanneer/multi-server:latest -t bpanneer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bpanneer/multi-worker:latest -t /bpanneer/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bpanneer/multi-client:latest
docker push bpanneer/multi-server:latest
docker push bpanneer/multi-worker:latest

docker push bpanneer/multi-client:$SHA
docker push bpanneer/multi-server:$SHA
docker push bpanneer/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bpanneer/multi-server:$SHA
kubectl set image deployments/client-deployment client=bpanneer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bpanneer/multi-worker:$SHA
