#puppet-git

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What Vim affects](#what-git-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Vim](#beginning-with-Vim)
4. [Usage](#usage)
5. [Limitations](#limitations)
6. [TODOs](#TODOs)

##Overview

This small git module installs git.
The puppet\_repository define creates git repositories with tho
git post-receive hook to automatically check out git branches as
environements.

Written for Puppet >= 3.4.0.

##Module Description

See [Overview](#overview) for now.

##Setup

###What Vim affects

* git :-) 

###Setup Requirements

Be sure to exchange corresponding ssh keys, if you create a puppet repository.
	
###Beginning with Vim	

Simply include it to install git. Or see [Usage](#usage) for puppet repository.

##Usage

Just include the module by 
```puppet
include git
```

To create a puppet git repository with post-receive hook (to check out
environments on a puppet server:
```puppet
git::puppet_repository { '/srv/puppet-environment.git':
  owner        => git-puppet,
  group        => git-puppet,
  symbolic_ref => 'production',
}
```

##Limitations:

Debian like systems. 
Tested on:

* Debian 7

Puppet Version >= 3.4.0, due to specific hiera usage.

##TODOs:

* make it work with puppet pre 3.4 
* make it work wit Redhat like systems
* create normal repositories

