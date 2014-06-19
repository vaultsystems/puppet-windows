define windows_hardening($os = $title, $ensure = 'present') {
  file {"C:\\Windows\\TEMP\\policy.inf":
    ensure  => file,
    source  => 'puppet:///modules/windows_hardening/policy.inf'
  } ->
  file {"C:\\Windows\\TEMP\\gpo.reg":
    ensure  => file,
    source  => 'puppet:///modules/windows_hardening/gpo.reg'
  } ->
  exec { "Importing Policies":
    command => '
      if ((Test-Path "C:\Windows\Temp\policyDB.sdb") -eq $true){ rm "C:\Windows\Temp\policyDB.sdb" }
      secedit /import /cfg "C:\Windows\Temp\policy.inf" /db "C:\Windows\Temp\policyDB.sdb"
    ',
    logoutput => true,
    provider  => powershell,
  } ->
  exec { "Applying configuration":
    command => '
      secedit /configure /db "C:\Windows\Temp\policyDB.sdb"
    ',
    logoutput => true,
    provider  => powershell,
  } ->
  exec { "Copy ADMX Templates":
    command => '
      iex "cmd.exe /c \'regedit.exe /s C:\Windows\Temp\gpo.reg\'"
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