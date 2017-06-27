# == Class sigsci::repository::el
#
# Install the correct package repository for an EL distribution
# CentOS / RedHat / etc
#
class sigsci::repository::release::el {
  yumrepo { 'sigsci_release':
    baseurl   => "https://yum.signalsciences.net/release/el/${::operatingsystemmajrelease}/${::architecture}",
    descr     => 'Provides sigsci-release packaging',
    enabled   => '1',
    gpgcheck  => '0', # the rpm isn't signed
    gpgkey    => 'https://yum.signalsciences.net/gpg.key',
    sslverify => '1',
    before    => Package[$::sigsci::package_name],
    require   => Exec['import-sigsci_gpgkey'],
  }
}
