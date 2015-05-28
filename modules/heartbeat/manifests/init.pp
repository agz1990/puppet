# Manage Heartbeat
class heartbeat {
	package { 'heartbeat':
		ensure => installed,
	}
	service { 'heartbeat':
		ensure => running,
		enable => true,
		require => Package['heartbeat'],
	}
	exec { 'reload-heartbeat':
		command => '/usr/sbin/service heartbeat reload',
		refreshonly => true,
	}
	file { '/etc/ha.d/authkeys':
		content => "auth 1\n1 sha1 TopSecret",
		mode => '0600',
		require => Package['heartbeat'],
		notify => Exec['reload-heartbeat'],
	}
}