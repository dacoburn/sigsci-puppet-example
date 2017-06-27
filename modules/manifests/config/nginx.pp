# == Class sigsci::module
#
# This class is called from sigsci to configure the nginx integration
#
class sigsci::config::nginx {
  # Most nginx configurations will include everything in conf.d
  $settings = $::sigsci::settings
  file { '/etc/nginx/conf.d/sigsci.conf':
    content => template('sigsci/modules/nginx-lua-module.erb'),
  }
}
