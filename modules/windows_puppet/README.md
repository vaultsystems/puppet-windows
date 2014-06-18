# Puppet-Windows_puppet
[![Build Status](https://travis-ci.org/cyberious/puppet-windows_puppet.png?branch=master)](https://travis-ci.org/cyberious/puppet-windows_puppet)

#### Gives the ability to automate the download and upgrade/installation of puppet on Windows

    class{'windows_puppet':
        $version    => '3.4.1'
    }

#### RemoteURL can be provided but is only the base URL for the version.

    class{'windows_puppet':
            $version    => '3.4.1'
            $remoteUrl  => 'http://downloads.puppetlabs.com/windows/'
            $installDir => 'C:\software'
    }

#### Utilizes Hiera backend as well if you would like to manage versions and sources

    {
        'windows_puppet::version':'3.4.2',
        'windows_puppet::remoteUrl':'http://myalternateUrl',
        'windows_puppet::installDir':'C:\temp'
    }

##### If you do provide an alternate url please note that we assume that the msi is of the pattern 'puppet-version.msi'

Please log tickets and issues at our [Projects site](http://github.com/cyberious/puppet-windows_puppet)
