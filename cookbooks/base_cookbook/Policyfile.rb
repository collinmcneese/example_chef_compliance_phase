# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'base_cookbook'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'base_cookbook::default'

# Specify a custom source for a single cookbook:
cookbook 'base_cookbook', path: '.'
cookbook 'linux_el', path: '../linux_el'
cookbook 'linux_ubuntu', path: '../linux_ubuntu'
cookbook 'web_server', path: '../web_server'
