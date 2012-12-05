class raspberrypi {
  $os_pkgs = [ 'ruby-shadow', 'python-pip', 'ruby-dev', 'smartsim', ]
  $latest_pkgs = [ 'raspi-config', ]
  $pip_pkgs = [ 'rpi.gpio', ]
  $ruby_pkgs = [ 'builder', 'wiringpi', ]

  package { $latest_pkgs:
    ensure => latest,
  }

  package { $os_pkgs:
    ensure => installed,
  }

  package { $pip_pkgs:
    ensure   => installed,
    provider => 'pip',
    require  => Package['python-pip'],
  }

  package { $ruby_pkgs:
    ensure   => installed,
    provider => 'gem',
    require  => Package['ruby-dev'],
  }

  file { '/boot/config.txt':
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/raspberrypi/config.txt',
  }

  # Make sure we keep the pi backed up
  cron { "rpi backup - home":
    command => "/usr/bin/rsync -av --delete /home rsync://gir/rpi_backups",
    user    => 'root',
    hour    => [0, 6, 12, 18], # every 6 hours should be sufficient
  }
}
