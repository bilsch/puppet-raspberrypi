class raspberrypi::wiringpi {
  include raspberrypi

  git::clone { 'wiringpi':
    repo   => 'git://git.drogon.net/wiringPi',
    target => '/home/pi/wiringpi',
    owner  => 'pi',
    group  => 'pi',
  }

  # builds wiringpi from git repo
  exec { 'build wiringpi':
    cwd     => '/home/pi/wiringpi',
    command => 'sh build',
    onlyif  => 'test ! -x /home/pi/wiringpi/gpio/gpio',
    path    => ['/bin', '/usr/bin', '/usr/local/bin', '/usr/sbin', '/sbin', ],
    creates => '/home/pi/wiringpi/gpio/gpio',
    require => Git::Clone['wiringpi'],
  }

  exec { 'install gpio':
    cwd     => '/home/pi/wiringpi/gpio',
    command => 'make install',
    #onlyif  => 'test ! -x /usr/local/bin/gpio',
    path    => ['/bin', '/usr/bin', '/usr/local/bin',
                '/usr/sbin', '/sbin', ],
    creates => '/usr/local/bin/gpio',
    require => Exec['build wiringpi'],
  }

  exec { 'install wiringpi lib':
    cwd     => '/home/pi/wiringpi/wiringPi',
    command => 'make install',
    #onlyif  => 'test ! -x /usr/local/bin/gpio',
    path    => ['/bin', '/usr/bin', '/usr/local/bin',
                '/usr/sbin', '/sbin', ],
    creates => '/usr/local/lib/libwiringPi.so.1.0',
    require => Exec['build wiringpi'],
  }
}
