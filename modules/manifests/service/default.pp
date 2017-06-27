# == Class sigsci::service::default
#
# This class is meant to be called from sigsci.
# It ensure the service is running.
#
class sigsci::service::default {
    service { $::sigsci::service_name:
      ensure     => running,
      enable     => true,
      hasrestart => true,
    }
}
