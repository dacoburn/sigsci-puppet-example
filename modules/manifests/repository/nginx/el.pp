# == Class sigsci::repository::nginx::el
#
# Install the correct package repository for an EL distribution
#
class sigsci::repository::nginx::el {
    if $::sigsci::nginx_release_type == "distro" {
      yumrepo { 'sigsci_nginx_noarch':
        baseurl   => "https://yum.signalsciences.net/nginx/${::sigsci::nginx_release_type}/el${::operatingsystemmajrelease}/noarch",
        descr     => 'Provides sigsci-nginx-noarch distro packaging',
        enabled   => '1',
        gpgcheck  => '0', # the rpm isn't signed
        gpgkey    => 'https://yum.signalsciences.net/gpg.key',
        sslverify => '1',
        before    => Package[$::sigsci::package_name],
        require   => Exec['import-sigsci_gpgkey'],
      }
    }

    yumrepo { 'sigsci_nginx':
    baseurl   => "https://yum.signalsciences.net/nginx/${::sigsci::nginx_release_type}/el${::operatingsystemmajrelease}/${::architecture}",
      descr     => 'Provides sigsci-nginx packaging',
      enabled   => '1',
      gpgcheck  => '0', # the rpm isn't signed
      gpgkey    => 'https://yum.signalsciences.net/gpg.key',
      sslverify => '1',
      before    => Package[$::sigsci::package_name],
      require   => Exec['import-sigsci_gpgkey'],
    }
}
