name 'base_cookbook'
maintainer 'Collin McNeese'
maintainer_email 'cmcneese@chef.io'
license 'Apache-2.0'
description 'Installs/Configures base_cookbook'
version '0.1.0'
chef_version '>= 16.0'

depends 'linux_el'
depends 'linux_ubuntu'
depends 'web_server'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/base_cookbook/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/base_cookbook'
