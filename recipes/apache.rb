#
# Cookbook Name:: serverdensity-inviqa
# Recipe:: apache
#
# Copyright (c) 2015 Inviqa, All Rights Reserved.

node.default['serverdensity']['apache_status_url'] = 'http://127.0.0.1/server-status?auto'

include_recipe 'apache2::default'

apache_conf 'serverdensity' do
  source 'serverdensity.conf.erb'
end