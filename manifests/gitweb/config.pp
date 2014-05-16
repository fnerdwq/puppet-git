# configures gitweb (private)
class git::gitweb::config (
  $projectroot = $git::params::gitweb_projectroot,
) {

  file {'/etc/gitweb.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("git/gitweb.conf.${::osfamily}.erb"),
  }

}
