# Manage Ntpdate 
class admin::ntp {
	package { 'ntpdate':  ensure=> installed}
	cron { 'sync-time':
		  ensure  => 'present',
		  command => 'ntpdate -u pool.ntp.org',
		  minute  => '*/10',
		  user    => 'root',
	}
}