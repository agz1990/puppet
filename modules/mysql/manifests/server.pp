# Manage MySQL server
class mysql::server {
	$password = '0507108063'
	$version = 'mysql-server'
	package { $version: ensure => installed }
	
	service { 'mysqld':
		ensure => running,
		enable => true,
		require => Package[$version],
	}
	
	file { '/mysql/datadir':
		ensure => directory,
		owner => 'mysql',
		group => 'mysql',
		mode => '0600',
	}
	
	file { '/etc/my.cnf':
		source => 'puppet:///modules/mysql/my.cnf',
		owner => 'mysql',
		group => 'mysql',
		notify => Service['mysqld'],
		require => Package[$version],
	}
	
	exec { 'set-mysql-password':
		unless => "/usr/bin/mysqladmin -uroot -p${password} status",
		command => "/usr/bin/mysqladmin -uroot password ${password}",
		require => Service['mysqld'],
	}
}