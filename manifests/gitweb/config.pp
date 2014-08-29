# configures gitweb (private)
class git::gitweb::config {

  $projectroot                    = $git::gitweb::projectroot
  if $git::gitweb::git_base_url_list {
    $git_base_url_list            = any2array($git::gitweb::git_base_url_list)
  } else {
    $git_base_url_list            = undef
  }
  $projects_list_group_categories = $git::gitweb::projects_list_group_categories

  file { '/etc/gitweb.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("git/gitweb.conf.${::osfamily}.erb"),
  }

}
