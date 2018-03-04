$:.unshift File.expand_path('./lib', __dir__)

require 'serialport'
require 'io/console'
require 'tv'
require 'avr'

tv = Tv.new
avr = Avr.new

loop do
  puts <<~MSG

    1) Switch telly on
    0) Switch telly off
    s) Watch Satellite TV
    f) Watch FireTV
    x) Play XBox
    e) Watch external Source
    m) Listen to music (Sonos)
    +) Volume up
    -) Volume down
    j) Channel Up
    k) Channel Down
    Ctrl-C) Exit

  MSG

  c = STDIN.getch
  case c
  when "1"
    tv.power_on
    avr.power_on
  when "0"
    tv.power_off
    avr.power_off
  when "s"
    tv.input_sat_tv
    avr.input_tv
  when "f"
    tv.input_hdmi1
    avr.input_bd
  when "x"
    tv.input_hdmi1
    avr.input_hdmi1
  when "e"
    tv.input_hdmi1
    avr.input_hdmi4
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
  when "\u0003"
    exit(0)
  end
end
