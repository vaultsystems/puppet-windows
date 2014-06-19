node "default" {
  if $osfamily == 'windows' {
    windows_hardening {'Set LGP': ensure => present }
  }
}