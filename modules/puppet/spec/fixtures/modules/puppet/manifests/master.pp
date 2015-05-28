# Manage puppetmaster
class puppet::master {
	include puppet
	package { 'puppet-server':
		ensure => installed,
	}
	
	service { 'puppetmaster':
		ensure  => 'running',
		enable => true,
		require => Package['puppet-server'],
		
	}
	
	file { '/etc/puppet/puppet.conf':
		source => 'puppet:///modules/puppet/puppet.conf',
		mode   => '0755',
		notify => Service['puppetmaster'],
	} 
  
}