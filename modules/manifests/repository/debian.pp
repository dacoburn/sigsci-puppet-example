# == Class sigsci::repository::debian
#
# Install the correct package repository for Debian
#
class sigsci::repository::debian {

  $apt_key = 'E2498D86'

  # Need Apt HTTP transport for the repos
  package{'apt-transport-https':
    ensure => 'present',
    before => Exec['install-sigsci-gpgkey'],
  }

  exec{'install-sigsci-gpgkey':
      path    => ['/usr/bin/', '/bin/'],
      command => 'wget -qO - https://apt.signalsciences.net/gpg.key| apt-key add -',
      unless  => "apt-key list | grep ${$apt_key}",
  }

}
