# Manage puppetmaster
class puppet::server {
	package { 'puppet-server':
		ensure => installed,
	}
	
	service { 'puppetmaster':
		ensure  => 'running',
		enable => true,
		require => Package['puppet-server'],
	}
}