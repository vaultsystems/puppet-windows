# Windows autologon


##Overview

Setting up autologon
 for selected user.

##Module Description

Puppet is not providing any extended feature for windows and usualy is not able to execute in current user context. This module adds ability to set autologon
 for windows and all puppet scripts will execute in current user context. Handy!

##Setup

###Install

Checkout from git to your module folder in puppet

##Usage

To set `Administrator` account as autologon
:

    auto_login { 'Administrator':
      password => 'TRICKY_PASSWORD',
      count => '10',
    }


Param `count` will set autologon count and will disable automatic logon feature after N times. If you skip it user will be not limited for autologon.

##License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)


