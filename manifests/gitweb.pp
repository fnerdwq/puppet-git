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
# include git
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
  $projectroot = $git::params::gitweb_projectroot
) {

  if ! defined(Class['git']) {
    fail('You must include the git base class before using gitweb')
  }

  Class['git'] -> Class['gitweb']

  contain git::gitweb::install

  Class ['git::gitweb::install']
  -> class {'git::gitweb::config':
    projectroot => $projectroot
  }

}
