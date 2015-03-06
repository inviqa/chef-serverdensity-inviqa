#
# Cookbook Name:: serverdensity-inviqa
# Recipe:: apache
#
# Copyright (c) 2015 Missguided, All Rights Reserved.

include_recipe 'apache2::default'

apache_conf 'serverdensity' do
  source 'serverdensity.conf.erb'
end