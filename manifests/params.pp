# git parameters (private)
class git::params {

  $gitweb_projectroot = '/var/lib/git'

  case $::osfamily {
    'Debian': {
      $gitweb_dir = '/usr/share/gitweb'
    }
    'RedHat': {
      $gitweb_dir = '/var/www/git'
    }
    default:  {
      fail("Module ${module_name} is not supported on ${::operatingsystem}/${::osfamily}")
    }

  }

}
