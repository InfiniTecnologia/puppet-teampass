class teampass::database {
  $db_name = 'teampass'
  $db_user = 'teampass'
  $db_pass = 'teampass_pass'
  $teampass_server = '172.22.0.102'

  mysql::db { $db_name:
    user     => $db_user,
    password => $db_pass,
    charset  => 'utf8',
    collate  => 'utf8_general_ci',
    host     => $teampass_server,
    grant    => ['all'],
    require  => Class['mysql::server'],
  }
  
}
