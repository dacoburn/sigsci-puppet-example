# == Class sigsci::service::centos6
#
# This class is meant to be called from sigsci.
# It ensure the service is running.
#
class sigsci::service::centos6 {
  service { $::sigsci::service_name:
    ensure     => running,
    hasrestart => true,
    hasstatus => true,
    restart => '/sbin/initctl restart sigsci-agent',
    start => '/sbin/initctl start sigsci-agent',
    stop => '/sbin/initctl stop sigsci-agent',
    status => '/sbin/initctl status sigsci-agent | grep "/running" 1>/dev/null 2>&1',
  }
}
