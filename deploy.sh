docker build -t rnarukulla/multi-client:latest -t rnarukulla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rnarukulla/multi-server:latest -t rnarukulla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rnarukulla/multi-worker:latest -t rnarukulla/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rnarukulla/multi-client:latest
docker push rnarukulla/multi-server:latest
docker push rnarukulla/multi-worker:latest

docker push rnarukulla/multi-client:$SHA
docker push rnarukulla/multi-server:$SHA
docker push rnarukulla/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rnarukulla/multi-server:$SHA
kubectl set image deployments/client-deployment client=rnarukulla/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rnarukulla/multi-worker:$SHA