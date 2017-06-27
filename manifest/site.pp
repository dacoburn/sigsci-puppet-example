node 'puppet.client.com' {

    info("Installing SigSci with Apache on ${::operatingsystem} ${::operatingsystemrelease} (Puppet ${::puppetversion})")

class { 'apache': }             # use apache module
  apache::vhost { 'example.com':  # define vhost resource
    port    => '80',
    docroot => '/var/www/html'
  }

    # Install SignalSciences
    class{'sigsci':
        accesskeyid        => 'CHANGEME',
        secretaccesskey    => 'CHANGEME',
	webserver	   => 'apache'
    }

    # Example Attack Simluation
    notice("SignalSciences: Once puppet finished, you can test using the following command:")
    notice("for i in {1..10}; do curl 'http://localhost?sigscitest=><svg%20onerror=alert(window);/>'; done")

}
