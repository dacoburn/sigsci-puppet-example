# == Class sigsci::install::module
#
# This class is called from sigsci for install.
#
class sigsci::install::module {
  case $sigsci::webserver {
    'nginx':  { $lua_package = $::sigsci::params::nginx_package }
    'apache': { $lua_package = $::sigsci::params::apache_package }
    default:  { fail("webserver ${sigsci::webserver} is not supported") }
  }

  if $::sigsci::manage_repo {
    Class[::sigsci::repository] -> Package[$lua_package]
  }

  package { $lua_package:
    ensure  => $::sigsci::module_version,
    require => $require,
  }
}
