# Export a specific file share via NFS
define nfs::share($path,$allowed,$options='') {
	include nfs
	file { $path:
		ensure => directory,
	}
	
	file { "/etc/exports.d/${name}":
		content => "${path} ${allowed}(${options})\n",
		notify => Exec['update-etc-exports'],
	}
}