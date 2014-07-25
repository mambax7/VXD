template "/var/www/index.html" do
  source "vxd_help.html.erb"
  owner "vagrant"
  group "vagrant"
  mode 00644
  variables(
    :sites => node["sites"]
  )
end
