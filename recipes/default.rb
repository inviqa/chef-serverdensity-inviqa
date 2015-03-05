#
# Cookbook Name:: serverdensity-inviqa
# Recipe:: default
#
# Copyright (c) 2015 Inviqa, All Rights Reserved.

require 'json'

include_recipe 'serverdensity'

serverdensity node.name do
  metadata :tags => JSON.dump(node['serverdensity-inviqa']['tags'])
end