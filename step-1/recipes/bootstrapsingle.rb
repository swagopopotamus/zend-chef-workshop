# Recipe to bootstrap a single server

include_recipe "zendserver::manage"

admin_password = TK[TK][TK]
order_number   = TK[TK][TK]
license_key    = TK[TK][TK]
production     = TK[TK][TK]
admin_email    = TK[TK][TK]
dev_password   = TK[TK][TK]

bootstrap_cmd = "/usr/local/zend/bin/zs-manage bootstrap-single-server -p #{admin_password} -a TRUE"
bootstrap_cmd << " -o #{order_number}" unless order_number.nil? || order_number.empty?
bootstrap_cmd << " -l #{license_key}" unless license_key.nil? || license_key.empty?
bootstrap_cmd << " -r #{production}" unless production.nil? || production.empty?
bootstrap_cmd << " -e #{admin_email}" unless admin_email.nil? || admin_email.empty?
bootstrap_cmd << " -d #{devpassword}" unless dev_password.nil? || dev_password.empty?

execute "create-api-key" do
  command "/usr/local/zend/bin/zs-manage api-keys-add-key -n #{node[:zendserver][:apikeyname]} -s #{node[:zendserver][:apikeysecret]}"
  retries 5
  retry_delay 5
  ignore_failure false
  not_if { is_server_bootstrapped(node[:zendserver][:apikeyname], node[:zendserver][:apikeysecret]) }
end 

execute "bootstrap-single-server" do
  command bootstrap_cmd
  ignore_failure false
  notifies :run, 'execute[restart-api]'
  not_if { is_server_bootstrapped(node[:zendserver][:apikeyname], node[:zendserver][:apikeysecret]) }
end
