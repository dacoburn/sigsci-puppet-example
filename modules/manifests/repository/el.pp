# == Class sigsci::repository::el
#
# Install the correct package repository for an EL distribution
# CentOS / RedHat / etc
#
class sigsci::repository::el {
  exec {  'import-sigsci_gpgkey':
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => 'rpm --import https://yum.signalsciences.net/gpg.key',
    unless    => 'rpm -q gpg-pubkey | grep gpg-pubkey-e2498d86-5602e4be',
    logoutput => 'on_failure',
    before    => [Yumrepo['sigsci_release']],
  }
}
