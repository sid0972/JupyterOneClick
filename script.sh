#!/bin/sh
#project_id=$(gcloud config list project)
#echo $project_id | grep qwik

#docker build -t jupyter:latest .

export PROJECT_ID="$(gcloud config get-value project -q)"

docker build -t gcr.io/${PROJECT_ID}/jupyter-app:v1 .

docker images

gcloud auth configure-docker

docker push gcr.io/${PROJECT_ID}/jupyter-app:v1

gcloud container clusters create jupyter-cluster --num-nodes=3

#gcloud compute instances list

kubectl run jupyter-deployment --image=gcr.io/${PROJECT_ID}/jupyter-app:v1 --port 8888

kubectl get pods

kubectl expose deployment jupyter-deployment --type=LoadBalancer --port 80 --target-port 8888

kubectl get service
