# Policyfile.rb - Used by Test Kitchen within Repo configuration to apply Policy configuration

# A name that describes what the system you're building with Chef does.
name 'base_policy'

# Where to find external cookbooks:
default_source :supermarket

# Default run_list for Policy
run_list 'base_cookbook::default'

# Local cookbook dependencies within repository
cookbook 'base_cookbook', path: './cookbooks/base_cookbook'
cookbook 'linux_el', path: './cookbooks/linux_el'
cookbook 'linux_ubuntu', path: './cookbooks/linux_ubuntu'
cookbook 'web_server', path: './cookbooks/web_server'

# Compliance Phase Configuration Items
#   https://docs.chef.io/chef_compliance_phase/

default['audit']['compliance_phase'] = true
default['audit']['interval']['enabled'] = false
# default['audit']['interval']['time'] = 1800
# default['audit']['fetcher'] = 'chef-server'
# default['audit']['reporter'] = %w(chef-server-automate cli)
# default['audit']['json_file']['location'] = '/tmp/audit_report.json'
# default['audit']['waiver_file'] = '/var/chef/waivers.yml'

# Profiles can be added as Attributes
# default['audit']['profiles']['ssh-baseline'] = {
#   'url': 'https://github.com/dev-sec/ssh-baseline/archive/refs/head/master.zip'
# }
