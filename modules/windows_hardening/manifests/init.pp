define windows_hardening($os = $title, $ensure = 'present') {
  file {"C:\\Windows\\TEMP\\policy.inf":
    ensure  => file,
    source_permissions => 'ignore',
    source  => 'puppet:///modules/windows_hardening/policy.inf'
  } ->
  exec { "Hardening setup":
    command => '
      secedit /import /cfg "C:\\Windows\\TEMP\\policy.inf" /db "${env:temp}\policyDB.sdb"
      secedit /configure /db "${env:temp}\policyDB.sdb"
    ',
    logoutput => true,
    provider  => powershell,
  }
}