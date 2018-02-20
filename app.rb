$:.unshift File.expand_path('./lib', __dir__)

require 'serialport'
require 'io/console'
require 'tv'
require 'avr'

tv = Tv.new
avr = Avr.new

loop do
  puts <<~MSG

    1) TV Power on
    2) TV Power off
    3) TV Input Sat
    4) TV Input HDMI 1 (AVR)
    5) AVR Power On
    6) AVR Power Off
    7) AVR Input BD
    8) AVR Input TV
    9) AVR Input CD
    0) Switch everything off
    o) Switch all devices on
    s) Watch Satellite TV
    f) Watch FireTV
    m) Listen to music (Sonos)
    +) Volume up
    -) Volume down
    j) Channel Up
    k) Channel Down
    x) Exit

  MSG

  c = STDIN.getch
  case c
  when "1"
    tv.power_on
  when "2"
    tv.power_off
  when "3"
    tv.power_on
    tv.input_sat_tv
  when "4"
    tv.power_on
    tv.input_hdmi1
  when "5"
    avr.power_on
  when "6"
    avr.power_off
  when "7"
    avr.input_bd
  when "8"
    avr.input_tv
  when "9"
    avr.input_cd
  when "0"
    tv.power_off
    avr.power_off
  when "o"
    tv.power_on
    avr.power_on
  when "s"
    tv.power_on
    avr.power_on
    tv.input_sat_tv
    avr.input_tv
  when "f"
    tv.power_on
    avr.power_on
    tv.input_bd
    avr.input_hdmi1
  when "m"
    tv.power_off
    avr.power_on
    avr.input_cd
  when "+"
    avr.volume_up
  when "-"
    avr.volume_down
  when "j"
    tv.channel_up
  when "k"
    tv.channel_down
  when "x", "\u0003"
    exit(0)
  end
end
