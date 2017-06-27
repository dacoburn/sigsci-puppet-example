# == Class sigsci::install::nginx
#
# This class is called from sigsci for install.
#
class sigsci::install::nginx {
  case $::osfamily {
    'Redhat': { include sigsci::repository::nginx::el }
    'Debian': { include sigsci::repository::nginx::debian }
    default:  { fail("No sigsci managed package repository is available for ${::osfamily}") }
  }

  package { 'nginx':
    ensure => $::sigsci::nginx_version,
    before => File['/etc/nginx/conf.d/sigsci.conf'],
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['nginx']
  }
}
