#
# Cookbook Name:: serverdensity-inviqa
# Recipe:: plugin_install
#
# Copyright (c) 2015 Inviqa, All Rights Reserved.

include_recipe 'serverdensity-inviqa::default'

node['serverdensity-inviqa']['plugins'].each do |plugin_name, options|
  if !options.has_key?('key') || !options['key'] then
    raise ArgumentError.new("Please provide a key value for `node['serverdensity-inviqa']['plugins']['#{plugin_name}']['key']`. This should be provided by serverdensity.")
  end

  execute "download plugin #{plugin_name}" do
    cwd node['serverdensity-inviqa']['installation']['directory']
    command "./plugins.py -v #{options['key']}"
  end

  serverdensity_plugin plugin_name do
    action :enable
  end
end