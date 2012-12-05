class raspberrypi::adafruit {
  include raspberrypi

  git::clone { 'adafruit_python':
    repo   => 'https://github.com/adafruit/Adafruit-Raspberry-Pi-Python-Code.git',
    target => '/home/pi/adafruit_python',
    owner  => 'pi',
    group  => 'pi',
  }
}
