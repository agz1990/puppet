# Manage puppetmaster
class puppet::master {
	package { 'puppet-server':
		ensure => installed,
	}
	
	service { 'puppetmaster':
		ensure  => 'running',
		enable => true,
		require => Package['puppet-server'],
	}
}