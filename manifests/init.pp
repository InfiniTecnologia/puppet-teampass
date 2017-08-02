# Class: teampass
# ===========================
#
# Full description of class teampass here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'teampass':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#

class teampass {
  $teampass_docroot = '/var/www/teampass'
  $teampass_repository = 'https://github.com/nilsteampassnet/TeamPass.git'
  $teampass_port = '80'
  $teampass_url = 'teampass.local'

  include apache
  include apache::mod::php
  include apache::mod::alias
  include apache::mod::rewrite
  include apache::mod::ssl
  include apache::mod::vhost_alias
  include apache::mod::headers 

  class { '::php':
    settings   => {
      'PHP/max_execution_time'  => '90',
    },
    extensions => {
      bcmath    => { },
      msql      => { },
      mbstring  => { },
      mcrypt    => { },
      openssl   => { },
      iconv     => { },
      xml       => { },
      gd        => { },
    },

  }

  # Clone teampass repository to doc root
  vcsrepo { $teampass_docroot:
    ensure   => present,
    provider => git,
    source   => $teampass_repository,
    revision => 'master',
  }
 
  php::apache_vhost { $teampass_url:
    docroot        => $teampass_docroot,
    port           => $teampass_port,
    fastcgi_socket => 'fcgi://127.0.0.1:9000/$1',

  }

#  apache::vhost { $teampass_url:
#    port    => $teampass_port,
#    docroot => $teampass_docroot,
#  }

}
