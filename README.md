# example_chef_compliance_phase

Example repository to reference using Chef Infra Compliance Phase.  Chef Infra Client `17.5` introducted new helpers and resources to facilitate more streamlined InSpec profile, waiver and input configurations for Chef Infra Client runs, allowing for objects to be easily referenced and distributed with cookbook code written in the Chef Infra Language.

## Requirements

- `Chef Workstation`: Latest stable release recommended.
- `Chef Infra Client`: ***Requires mimimum Chef Infra Client version `17.9.42` for bug-fixes related to Compliance Phase for full functionality.***

## Repository Contents

- `Policyfile.rb`: Sample Policyfile used for this repository configuration to mock a real-world-type cofiguration.  Used by `Test Kitchen`.  Contains base configuration for Compliance Phase via `default['audit']` attributes.
- `kitchen.yml`: Test Kitchen configuration file to use local repository components.
- Cookbooks:
  - `base_cookbook`: Base cookbook which is the default `run_list` entry for Test Kitchen suites in this repo.  [Default recipe](cookbooks/base_cookbook/recipes/default.rb) contains examples of different ways to use new Compliance Phase Helpers and Resources.

    ```ruby
    # cookbooks/base_cookbook/recipes/default.rb

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

    # Specify input(s) inline with the `inspec_input` resource
    inspec_input 'user_which_should_not_exist' do
    source({ user_which_should_not_exist: 'someuser' })
    end

    # Include an input file in this cookbook under compliance/inputs path
    #  Inputs could be included from another cookbook as well in this way
    include_input 'base_cookbook::kernel_min_ver' if linux?

    # Load an existing input file from the system at a given location, if present.
    inspec_input '/path/to/my/input.yml' if ::File.exist?('/path/to/my/input.yml')

    # Include the web_server default recipe.
    #  This cookbook also has Compliance Phase components configured and those will run too.
    include_recipe 'web_server' if ubuntu_platform?

    ```

  - `linux_el`: A profile-only Cookbook.  Referenced by `base_cookbook` for Compliance Phase for data under `compliance` directory of cookbook.
  - `linux_ubuntu`: A profile-only Cookbook.  Referenced by `base_cookbook` for Compliance Phase for data under `compliance` directory of cookbook.
  - `web_server`: A sample app cookbook which configures `nginx` on a system.  Referenced by `base_cookbook` for Recipe and Compliance Phase components.
