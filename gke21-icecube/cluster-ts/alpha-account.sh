# Create a service account
YOUR_EMAIL=you@example.com
SA_SHORT_NAME=alpha-svc-acct
SA_FULL_NAME="${SA_SHORT_NAME?}@${PROJECT_ID?}.iam.gserviceaccount.com"
gcloud iam service-accounts create "${SA_SHORT_NAME?}" --project "${PROJECT_ID?}"

# Allow you to impersonate the service account.
gcloud iam service-accounts add-iam-policy-binding --project "${PROJECT_ID?}" \
  "${SA_FULL_NAME?}" --member "user:${YOUR_EMAIL?}" \
  --role roles/iam.serviceAccountTokenCreator

# Grant roles needed for calling the GKE API. Note that
# roles/iam.serviceAccountActor is required to create node instances with the
# default compute service account.
gcloud projects add-iam-policy-binding "${PROJECT_ID?}" \
  --member "serviceAccount:${SA_FULL_NAME?}" --role roles/container.clusterAdmin

gcloud projects add-iam-policy-binding "${PROJECT_ID?}" \
  --member "serviceAccount:${SA_FULL_NAME?}" --role roles/iam.serviceAccountActor

