class rdiff-backup::client(
  $servers,
  $confdir = '/etc/rdiff-backup',
  $targets = [
    '/etc',
    '/home',
    '/opt',
    '/root',
    '/srv',
    '/usr/local',
    '/var',
  ],
  $includes = [],
  $excludes = []
){
  include rdiff-backup
  @file{'/var/lib/rdiff-backup/$fqdn':
    tag => $servers,
    content => join($targets, '\n')
    owner => root, group => root, mode 0440;
  }
}
