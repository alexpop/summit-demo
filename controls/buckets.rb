
title 'Google Cloud: Bucket Controls'

# Legacy attribute definition
#bucket_location = attribute('gcp_bucket_location', default: 'EU', description: "Bucket location that all cloud buckets need to be in, eg. 'US'")


control 'gcp-bucket-location' do
  impact 'high'
  title 'Ensure Buckets are in a specific geographical location'
  desc 'To ensure complinace with data protection regulations, we must ensure that all storage buckets are in the specified location.'

  google_storage_buckets(project: attribute('gcp_project_id')).bucket_names.each do |bucket_name|
    describe google_storage_bucket(name: bucket_name) do
      its('location') { should eq attribute('gcp_bucket_location') }
    end
  end
end

control 'gcp-bucket-storage-class' do
  impact 'low'
  title 'Cloud Storage type for the buckets must be Multi-Regional'
  desc 'Multi-Regional Storage Class offers the best value/money based on our data consumption model. Read more about the other types here: https://cloud.google.com/storage/docs/storage-classes'
  only_if('MULTI_REGIONAL storage class not enforced in test') do
    attribute('gcp_project_id') != 'acme-test'
  end

  google_storage_buckets(project: attribute('gcp_project_id')).bucket_names.each do |bucket_name|
    describe google_storage_bucket(name: bucket_name) do
      its('storage_class') { should eq 'MULTI_REGIONAL' }
    end
  end
end
