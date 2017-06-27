# SignalSciences Repo Puppet Module
#
# Copyright (C) 2015 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#

# == Class sigsci::repository
#
# This class selects a package repository to install
#
class sigsci::repository {
  case $::osfamily {
    'Redhat': {
      include sigsci::repository::el
      include sigsci::repository::release::el
    }
    'Debian': {
      include sigsci::repository::debian
      include sigsci::repository::release::debian
    }
    default: { fail("No package repository is available for ${::osfamily}") }
  }
  if $sigsci::manage_nginx {
    case $::osfamily {
      'Redhat': { include sigsci::repository::nginx::el }
      'Debian': { include sigsci::repository::nginx::debian }
      'Ubuntu': { include sigsci::repository::nginx::ubuntu }
      default: { fail("No package repository is available for ${::osfamily}") }
    }
  }
}
