# knife.rb for user scoped. Put as '~/.chef/knife.rb'

# Supposed directory structures.
#
#  +--<site repository> (Workdirectory)
#      |     * This directory managed on Github,
#      |       for Configuration Management of Production Servers.
#      |
#      +-- ./cookbooks
#      |     * The directory for cookbooks downloaded by berkshelf.
#      |       This directory should not be committed into site repository,
#      |       but committed as an empty directory. (Use .gitkeep)
#      |
#      +-- ./site-cookbooks
#      |     * The directory for cookbooks, localized or created for your sites.
#      |
#      +-- ./nodes
#      |     * The nodes managed under the site repository.
#      |
#      +-- ./clients
#            * The client keys managed under the site repository.
#

# * Use knife.zero.
#   knife-zero gem is required. Please execute followings to install.
#   $ chef gem install knife-zero
local_mode true

# * Use repository into current working directory.
#   The node configurations will be commited on site repos.
chef_repo_path   File.expand_path(".")

cookbook_path    [
  # "."
  #   - Search current workinig directory at first.
  '.',
  # "./site-cookbooks"
  #   - The directory for customized or server specific cookbooks in your sites.
  './site-cookbooks',
  # ./cookbooks
  #   - The directory for cookbooks downloaded by berkshelf,
  #     and used as is. This directory should be empty if you
  #     commit into your site repository.
  './cookbooks',
  '..',
]

knife[:ssh_user] = 'vagrant'
knife[:ssh_attribute] = "knife_zero.host"
knife[:use_sudo] = true
knife[:identity_file] = "~/.ssh/id_rsa"
knife[:automatic_attribute_whitelist] = %w[
  fqdn
  os
  os_version
  hostname
  ipaddress
  roles
  recipes
  ipaddress
  platform
  platform_version
  cloud
  cloud_v2
  chef_packages
]
