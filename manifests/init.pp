# == Class: git
#
# Installs git.
#
# This works on Debian like systems.
# Puppet Version >= 3.4.0
#
# === Parameters
#
# none
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
class git {

  contain git::install

}
