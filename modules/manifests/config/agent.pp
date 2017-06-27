# == Class sigsci::config
#
# This class is called from sigsci for service config.
# See https://dashboard.signalsciences.net/documentation/getting-started/agent-installation
# for documentation on config settings
#
class sigsci::config::agent {
  # the purpose of having settings defined here is to allow greater
  # flexibility when more settings are needed in the future.
  # the template simply converts this hash into a config file.
  $config_settings = $::sigsci::settings
  $access_settings = {
      'accesskeyid'     => $::sigsci::accesskeyid,
      'secretaccesskey' => $::sigsci::secretaccesskey,
    }

  # Create the sigsci directory in /etc
  file { '/etc/sigsci/':
    ensure => 'directory',
    owner   => $::sigsci::user,
    group   => $::sigsci::group,
    mode    => '0640',
  }

  # Create the agent config rile
  file { $::sigsci::config_file:
    owner   => $::sigsci::user,
    group   => $::sigsci::group,
    mode    => '0640',
    content => template('sigsci/agent/agent.conf.erb'),
    notify  => Service[$::sigsci::service_name],
    before  => Service[$::sigsci::service_name],
    require => [Package[$::sigsci::agent_package],
                File['/etc/sigsci/']]
  }
}
