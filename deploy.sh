docker build -t mgarciac88/multi-client:latest -t mgarciac88/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mgarciac88/multi-server:latest -t mgarciac88/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mgarciac88/multi-worker:latest -t mgarciac88/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mgarciac88/multi-client:latest
docker push mgarciac88/multi-server:latest
docker push mgarciac88/multi-worker:latest

docker push mgarciac88/multi-client:$SHA
docker push mgarciac88/multi-server:$SHA
docker push mgarciac88/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mgarciac88/multi-server:$SHA
kubectl set image deployments/client-deployment client=mgarciac88/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mgarciac88/multi-worker:$SHA
