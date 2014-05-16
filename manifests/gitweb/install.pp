# installs gitweb (private)
class git::gitweb::install {

  package { 'gitweb':
    ensure => latest,
  }

}
