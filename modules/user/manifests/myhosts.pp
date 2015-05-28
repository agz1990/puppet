class myhosts {
	file { '/etc/hosts':
		ensure => present,
		source => 'puppet:///modules/puppet/hosts',
	}
}