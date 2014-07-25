template "/etc/mysql/conf.d/vxd_my.cnf" do
  source "vxd_my.cnf.erb"
  mode "0644"
  notifies :restart, "service[mysql]", :delayed
end
