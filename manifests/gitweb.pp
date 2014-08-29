# == Class: gitweb
#
# Installs gitweb.
#
# An apache::vhost should be created like
#
# apache::vhost:
#  "gitweb":
#    servername: "gitpuppet.example.com"
#    port: 80
#    docroot: /usr/share/gitweb
#    directories:
#      - path: /usr/share/gitweb
#        options:
#          - FollowSymLinks
#          - +ExecCGI
#        addhandlers:
#          - handler: cgi-script
#            extensions:
#              - .cgi
#
# This works on Debian and RedHat like systems.
# Puppet Version >= 3.4.0
#
# === Parameters
#
# [*projectroot*]
#  Sets the project root for gitweb.
#  *Optional* (Default to /var/lib/git)
#
# === Examples
#
# include git::gitweb
#
# === Authors
#
# Frederik Wagner <wagner@wagit.de>
#
# === Copyright
#
# Copyright 2014 Frederik Wagner
#
class git::gitweb (
  $projectroot                    = $git::gitweb::params::projectroot,
  $git_base_url_list              = $git::gitweb::params::git_base_url_list,
  $projects_list_group_categories = $git::gitweb::params::projects_list_group_categories,
) inherits git::gitweb::params {

  include git

  contain git::gitweb::install
  contain git::gitweb::config

  Class['git'] ->
  Class['git::gitweb::install'] ->
  Class['git::gitweb::config']

}
