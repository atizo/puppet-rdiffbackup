class rdiff-backup::server(
  $confdir = '/etc/rdiff-backup',
  $datadir = '/srv/backup'
){
  include rdiff-backup
  file{$basedir:
    ensure => directory,
  }
  file{'/usr/local/sbin/rdiff-backup_reschedule.sh':
    source => "puppet://$server/modules/rdiff-backup/rdiff-backup_reschedule.sh",
  }
  exec{'rdiff-backup_reschedule':
    command => '/usr/local/sbin/rdiff-backup_reschedule.sh "$confdir"',
    require => File['/usr/local/sbin/rdiff-backup_reschedule.sh'],
    refreshonly => true,
  }
  File <| $fqdn in tag |> {
    notify => Exec['reschedule'],
  }
}
