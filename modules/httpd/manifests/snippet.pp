# Deploy an Apache config snippet
define httpd::snippet() {
	include httpd
	file { "/etc/httpd/conf.d/${name}":
		source => "puppet:///modules/httpd/${name}",
		require => Package['httpd'],
		notify => Service['httpd'],
	}
}