class Avr
  def initialize
    @listener = Thread.new do
      while s = serial_port.gets
        $stdout.puts "[AVR #{Time.now}] #{s}"
      end
    end
  end

  def power_on
    command
    sleep(0.1)
    command("\rPO")
  end

  def power_off
    command("PF")
  end

  def input_bd
    command("25FN")
  end

  def input_tv
    command("05FN")
  end

  def input_cd
    command("01FN")
  end

  def volume_up(n=3)
    n.times { command("VU") }
  end

  def volume_down(n=3)
    n.times { command("VD") }
  end

  private

  def command(c = "")
    puts "[AVR #{Time.now}] Command: #{c.strip}"
    serial_port.write("#{c}\r")
  end

  def serial_port
    @serial_port ||= SerialPort.new('/dev/ttyUSB1', 9600, 8, 1,
                                    SerialPort::NONE)
  end
end
