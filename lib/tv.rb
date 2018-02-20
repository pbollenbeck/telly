class Tv
  def power_on
    command("PON")
  end

  def power_off
    command("POF")
  end

  def input_sat_tv
    command("IND")
  end

  def input_hdmi1
    command("INPS01")
  end

  def channel_up
    command("CHNFWD")
  end

  def channel_down
    command("CHNREV")
  end

  private

  def command(c)
    puts "[TV #{Time.now}] Command: #{c}"
    serial_port.write("\x02**#{c}\x03")
    get_result
  end

  def serial_port
    @serial_port ||= SerialPort.new('/dev/ttyUSB0', 9600, 8, 1,
                                    SerialPort::NONE)
  end

  def get_result
    result = ""
    loop do
      c = serial_port.getc
      break if c.nil? || c == "\x03"
      result += c
    end
    puts "[TV #{Time.now}] " + result[1..-1] # strip STX
    result
  end
end
