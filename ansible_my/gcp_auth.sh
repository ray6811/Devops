#!/bin/bash 
gcloud auth activate-service-account --key-file={{ gcp_key_path }}
gcloud config set project {{ gcp_project_id }}
gcloud auth configure-docker {{ gcp_region }}-docker.pkg.dev --quiet
gcloud container clusters get-credentials {{ CLUSTER_NAME }} --zone {{ CLUSTER_ZONE}}