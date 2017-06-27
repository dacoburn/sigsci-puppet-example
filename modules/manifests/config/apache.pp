# == Class sigsci::config::apache
#
# This class is called from sigsci to configure the apache module
# This assumes use of the puppetlabs-apache module
#
class sigsci::config::apache {
  apache::mod { 'signalsciences': }
}
