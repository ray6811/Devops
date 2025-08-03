#!/bin/bash
# Usage: ./deploy.sh service_name gcp_key_path gcp_project_id gcp_region repo_name image_tag CLUSTER_ZONE CLUSTER_NAME
SERVICE_NAME=$1
GCP_KEY_PATH=$2
GCP_PROJECT_ID=$3
GCP_REGION=$4
REPO_NAME=$5
IMAGE_TAG=$6
CLUSTER_ZONE=$7
CLUSTER_NAME=$8

if [ -z "$SERVICE_NAME" ]; then
  echo "Service name not provided."
  exit 1
fi

FULL_IMAGE_NAME="$GCP_REGION-docker.pkg.dev/$GCP_PROJECT_ID/$REPO_NAME/$SERVICE_NAME:$IMAGE_TAG"

# Authenticate to GCP
if [ ! -z "$GCP_KEY_PATH" ]; then
  gcloud auth activate-service-account --key-file="$GCP_KEY_PATH"
fi

gcloud config set project "$GCP_PROJECT_ID"
gcloud auth configure-docker "$GCP_REGION-docker.pkg.dev"

docker push "$FULL_IMAGE_NAME"

gcloud container clusters get-credentials "$CLUSTER_NAME" --zone "$CLUSTER_ZONE" --project "$GCP_PROJECT_ID"
kubectl set image deployment/"$SERVICE_NAME" "$SERVICE_NAME"="$FULL_IMAGE_NAME"
kubectl rollout status deployment/"$SERVICE_NAME"