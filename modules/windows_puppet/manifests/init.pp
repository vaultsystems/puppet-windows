# == Class: windows_puppet
#
# Full description of class windows_puppet here.
#
# === Parameters
#
# Document parameters here.
#
# [*version*]
# Tell the desired remote version to be installed
#
# [*remoteUrl*]
# Remote base url to retrieve puppet-$version.msi from
#
# === Examples
#
#  class { windows_puppet:
#    version => '3.4.1',
#    remoteUrl => 'http://downloads.puppetlabs.com/windows/',
#    installDir=> 'C:/software'
#  }
#
# === Authors
#
# Author Name Travis Fields
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class windows_puppet(
  $version    = hiera('windows_puppet::version','3.4.2'),
  $remoteUrl	= hiera('windows_puppet::remoteUrl','http://downloads.puppetlabs.com/windows/'),
  $installDir	= hiera('windows_puppet::installDir','C:\software')){
    if $puppetversion != $version {
      file{$installDir:
        ensure => directory,
        recurse => true
      }
	  pget{'DownloadPuppet':
	    source  => "${remoteUrl}puppet-${version}.msi",
        target  => $installDir,
        require => File[$installDir]
      }
      package{'UpgradePuppet':
        name => 'Puppet',
        ensure  => "${version}",
        require => Pget['DownloadPuppet'],
        source  => "${installDir}\\puppet-${version}.msi",
        install_options => ['/qn']
      }
    }
}
