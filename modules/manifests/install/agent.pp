# == Class sigsci::install::agent
#
# This class is called from sigsci for install.
#
class sigsci::install::agent {
  package { $::sigsci::agent_package:
    ensure => $::sigsci::agent_version,
    notify => Service[$::sigsci::service_name],
  }
}
