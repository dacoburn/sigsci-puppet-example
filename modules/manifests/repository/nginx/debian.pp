# == Class sigsci::repository::nginx::debian
#
# Install the correct package repository for Debian
#
class sigsci::repository::nginx::debian {
    require sigsci::repository::debian

    # Add the repo to sources.list.d
    file{'sigsci-nginx-repo':
        path    => '/etc/apt/sources.list.d/sigsci-nginx.list',
        mode    => 0644,
        owner   => 'root',
        group   => 'root',
        content => template('sigsci/repos/nginx/debian.erb'),
        notify  => Exec['update-sigsci-nginx'],
    }

    exec{'update-sigsci-nginx':
        path        => ['/usr/bin/', '/bin/'],
        command     => 'apt-get update -o Dir::Etc::sourcelist="sources.list.d/sigsci-nginx.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"',
        require     => File['/etc/apt/sources.list.d/sigsci-nginx.list'],
        refreshonly => true,
        before      => [Package[$::sigsci::agent_package],
                        Package['nginx'],
                        File[$::sigsci::config_file]]
    }
}
