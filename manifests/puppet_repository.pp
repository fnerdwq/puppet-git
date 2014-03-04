# == Class: git
#
# Creates a bare git puppet repository including remote checkout script.
#
# Be sure to exchange ssh keys between the puppet server and the git
# repository server.
#
# This works on Debian like systems.
# Puppet Version >= 3.4.0
#
# === Parameters
#
# [*owner*]
#  The owner of the repository.
#  *Optional* (defaults to root)
#
# [*group*]
#  The group of the repository.
#  *Optional* (defaults to root)
#
# [*symbolic_ref*]
#  The HEAD branch of the repository ('production' could be usefull')
#  *Optional* (defaults to master)
#
# [*remote_user*]
#  The user on the puppet server which is used to log in/clone.
#  *Optional* (defaults to puppet)
#
# [*remote_dir*]
#  Directory on puppet_server where environments should be cloned.
#  *Optional* (defaults to /etc/puppet/environments)
#
# [*puppet_server*]
#  The puppet server, where the environments should be cloned.
#  *Optional* (defaults to puppet.$::fqdn)
#
#
# === Examples
#
# git::puppet_repository { '/srv/git-environment.git': }
#
# === Authors
#
# Frederik Wagner <wagner@wagit.de>
#
# === Copyright
#
# Copyright 2014 Frederik Wagner
#
define git::puppet_repository (
  $owner         = 'root',
  $group         = 'root',
  $symbolic_ref  = 'master',
  $remote_user   = 'puppet',
  $remote_dir    = '/etc/puppet/environments',
  $puppet_server = "puppet.${::domain}",
) {

  include git

  file {$name:
    ensure  => directory,
    owner   => $owner,
    group   => $group,
    mode    => '0644',
    recurse => true,
  }

  exec {"git init bare: ${name}":
    command => 'git init --bare --quiet',
    cwd     => $name,
    user    => $owner,
    unless  => 'git rev-parse',
    path    => ['/usr/bin'],
    require => File[$name],
  }

  exec {"${name}: set symbolic-ref HEAD":
    command => "git symbolic-ref HEAD refs/heads/${symbolic_ref}",
    cwd     => $name,
    user    => $owner,
    unless  => "git symbolic-ref HEAD |grep -q '^refs/heads/${symbolic_ref}'",
    path    => ['/bin', '/usr/bin'],
    require => Exec["git init bare: ${name}"],
  }

  ensure_resource('package','ruby-net-ssh', { 'ensure' => 'installed' })

  file{ "${name}: puppet post-receive hook":
    name    => "${name}/hooks/post-receive",
    owner   => $owner,
    group   => $group,
    mode    => '0755',
    content => template('git/post-receive.erb'),
    require => Exec["git init bare: ${name}"],
  }
}
