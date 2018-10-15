
gcp_project_id = attribute('gcp_project_id')

control 'gcp-kubernetes-legacy-authz-disabled' do
  impact 'high'
  title 'Ensure Legacy Authorization is set to Disabled on Kubernetes Engine Clusters'
  tag 'gcp', 'k8s', 'authz'
  desc 'en', 'Legacy authorization in Kubernetes Engine grants broad, statically defined permissions. To ensure that RBAC, which has significant security advantages, limits
  permissions correctly, you must disable the legacy authorizer.'
  desc 'de', 'Die Kubernetes Legacy-Autorisierung mussen umfangreiche statisch definierte  Berechtigungen. Um sicherzustellen das RBAC, die erhebliche Sicherheitsvorteile umsetzt, mussen Sie den Legacy-Autorizer deaktivieren.'

  google_compute_zones(project: gcp_project_id).zone_names.each do |zone_name|
    google_container_clusters(project: gcp_project_id, zone: zone_name).cluster_names.each do |cluster_name|
      describe google_container_cluster(project: gcp_project_id, zone: zone_name, name: cluster_name) do
        it { should have_legacy_abac_disabled }
      end
    end
  end
end
