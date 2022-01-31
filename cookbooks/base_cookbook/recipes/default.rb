#
# Cookbook:: base_cookbook
# Recipe:: default
#

# Version-check components
unless respond_to?(:include_profile) && respond_to?(:include_waiver) && respond_to?(:include_input)
  log 'This version of Chef Infra Client does not support required helpers used by this recipe.'
  return
end

# ====> Include InSpec profiles from local cookbook and others
#   Other cookbooks, if used, must have a metadata `depends`
include_profile 'base_cookbook::base_linux'    if linux?
include_profile 'linux_el::base_linux_el'      if redhat_based?
include_profile 'linux_ubuntu::base_ubuntu'    if ubuntu_platform?

# ====> Include InSpec Waivers via different example methods:
# Include a waiver from a file in this cookbook under compliance/waivers path
#  Waiver could be included from another cookbook as well in this way
include_waiver 'base_cookbook::crond'          if linux?

# Specify a waiver directly via Resource
inspec_waiver 'Add waiver entry for control' do
  control 'auditd-service'
  run_test false
  justification "auditd service not required for #{node['platform']}"
  expiration '2023-01-01'
  action :add
  only_if { linux? }
end

# Load an existing waiver file from the system at a given location, if present.
inspec_waiver 'Consume waiver from disk location' do
  source '/path/to/my/waiver.yml'
  only_if { ::File.exist?('/path/to/my/waiver.yml') }
end

# ====> Include InSpec Inputs to pass to Compliance Phase
inspec_input 'user_which_should_not_exist' do
  source({ user_which_should_not_exist: 'someuser' })
end

include_input 'base_cookbook::kernel_min_ver' if linux?

inspec_input '/path/to/my/input.yml' if ::File.exist?('/path/to/my/input.yml')

include_recipe 'web_server' if ubuntu_platform?
