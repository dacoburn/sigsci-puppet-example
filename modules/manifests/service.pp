# == Class sigsci::service
#
# This class is meant to be called from sigsci.
# It ensure the service is running.
#
class sigsci::service {
  case "${::operatingsystem}${$::operatingsystemmajrelease}" {
    'CentOS6': { include ::sigsci::service::centos6 }
    default:   { include ::sigsci::service::default }
  }
}
