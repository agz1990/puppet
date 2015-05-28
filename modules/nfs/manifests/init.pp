# Manage NFS server
class nfs {
	package { ['nfs-utils', 'rpcbind']: ensure => installed }

	service { ['nfs', 'rpcbind']:
		ensure => running,
		enable => true,
		hasrestart => true,
		require => Package['nfs-utils', 'rpcbind'],
	}
	file { '/etc/exports.d':
		ensure => directory,
	}
	
	exec { 'update-etc-exports':
		command => '/bin/cat /etc/exports.d/* >/etc/exports',
		notify => Service['nfs', 'rpcbind'],
		refreshonly => true,
	}
}