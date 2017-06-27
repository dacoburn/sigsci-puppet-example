# == Class sigsci::repository::debian
#
# Install the correct package repository for debian
#
class sigsci::repository::release::debian {
    require sigsci::repository::debian

    # Add the repo to sources.list.d
    file{'sigsci-release-repo':
        path    => '/etc/apt/sources.list.d/sigsci-release.list',
        mode    => 0644,
        owner   => 'root',
        group   => 'root',
        content => template('sigsci/repos/release/debian.erb'),
        notify  => Exec['update-sigsci-release'],
    }

    exec{'update-sigsci-release':
        path        => ['/usr/bin/', '/bin/'],
        command     => 'apt-get update -o Dir::Etc::sourcelist="sources.list.d/sigsci-release.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"',
        require     => File['/etc/apt/sources.list.d/sigsci-release.list'],
        refreshonly => true,
        before      => [Package[$::sigsci::agent_package],
                        Package[$::sigsci::nginx_package],
                        File[$::sigsci::config_file]]
    }
}
