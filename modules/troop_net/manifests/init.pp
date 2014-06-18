define troop_net($eth, $ip_address, $gateway, $dns){
  $eth0 = '$eth0'
  exec { "Setup troop network ${eth}":
      command   => "
        Import-Module NetAdapter
        $eth0 = Get-NetAdapter -Name $eth
        $eth0 | Set-NetIPInterface -DHCP Disabled

        $eth0 | New-NetIPAddress -AddressFamily IPv4 -IPAddress $ip_address -PrefixLength 24 -Type Unicast -DefaultGateway $gateway
        Set-DnsClientServerAddress -InterfaceAlias $eth -ServerAddresses $dns
      ",
      logoutput => true,
      provider  => powershell,
    }
}