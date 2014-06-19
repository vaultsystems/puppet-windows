define windows_hardening($os = $title, $ensure = 'present') {
  file {"C:\\Windows\\TEMP\\policy.inf":
    ensure  => file,
    source_permissions => 'ignore',
    source  => 'puppet:///modules/windows_hardening/policy.inf'
  } ->
  exec { "Importing Policies":
    command => '
      secedit /import /cfg "C:\\Windows\\TEMP\\policy.inf" /db "C:\\Windows\\TEMP\\policyDB.sdb"
    ',
    logoutput => true,
    provider  => powershell,
  } ->
  exec { "Applying configuration":
    command => '
      secedit /configure /db "C:\\Windows\\TEMP\\policyDB.sdb"
    ',
    logoutput => true,
    provider  => powershell,
  } ->
  exec { "Perform policy refresh":
    command => '
      iex "cmd.exe /c gpupdate.exe"
    ',
    logoutput => true,
    provider  => powershell,
  }
}