#
# Cookbook Name:: oracle
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'oracle::oracle_user_config'
include_recipe 'oracle::deps_install'
include_recipe 'oracle::kernel_params'
include_recipe 'oracle::dbsoft_install'
#include_recipe 'oracle::custdb'
