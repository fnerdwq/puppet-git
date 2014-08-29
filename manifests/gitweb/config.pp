# configures gitweb (private)
class git::gitweb::config {

  $projectroot                    = $git::gitweb::projectroot
  $git_base_url_list              = $git::gitweb::projects_list_group_categories
  $projects_list_group_categories = $git::gitweb::projects_list_group_categories

  file { '/etc/gitweb.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("git/gitweb.conf.${::osfamily}.erb"),
  }

}
