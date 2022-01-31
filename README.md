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
  - `linux_el`: A profile-only Cookbook.  Referenced by `base_cookbook` for Compliance Phase for data under `compliance` directory of cookbook.
  - `linux_ubuntu`: A profile-only Cookbook.  Referenced by `base_cookbook` for Compliance Phase for data under `compliance` directory of cookbook.
  - `web_server`: A sample app cookbook which configures `nginx` on a system.  Referenced by `base_cookbook` for Recipe and Compliance Phase components.
