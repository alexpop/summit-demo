# Community Summit Demo Profile

An InSpec profile to show profile and control improvements using a Google Cloud profile.

Example of how to run it:
```
# Point to the Google Cloud credential file:
export GOOGLE_APPLICATION_CREDENTIALS='/home/user/.config/gcloud/your-creds-file.json'

git clone https://github.com/alexpop/summit-demo

# Update ./summit-demo/attrs.yaml and specify your Google Cloud project

# Execute inspec with the default CLI reporter:
inspec exec ./summit-demo -t gcp:// --attrs ./summit-demo/attrs.yaml
```
