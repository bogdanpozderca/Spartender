class Mixer < ActiveRecord::Base
  attr_reader :type, :gpio, :io, :pwm_power, :pwm_hz

  def initialize(type, gpio, pwm_hz = 100)
    @type = name
    @gpio = gpio
    @pwm_power = 0
    @pwm_hz = pwm_hz
    initialize_gpio()
  end

  private
    
    attr_writer :type, :gpio, :io, :pwm_power, :pwm_hz

  	def initialize_gpio()
  		@io = WiringPi::GPIO.new do |gpio|
  	    gpio.pin_mode(@gpio, WiringPi::HIGH)
  	    gpio.soft_pwm_create(@gpio, @pwm_power, @pwm_hz)
  		end
  	end

    def shutdown_gpio()
      @io.pin_mode(@gpio, WiringPi::LOW)
    end

    def start_pwm()
    end

    def stop_pwm()
      io.soft_pwm_write(@gpio, WiringPi::LOW)
    end

    def stop()
      stop_pwm()
      shutdown_gpio()
    end

    def shutdown_gpio()
    end

end
