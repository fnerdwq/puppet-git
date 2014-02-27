# installs git (private)
class git::install {

  package { 'git':
    ensure => latest,
  }

}
