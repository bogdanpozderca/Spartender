class Motor < ActiveRecord::Base
	attr_reader :gpio, :io, :pwm_hz, :is_air_pump

  def initialize(gpio)
    @gpio = gpio

    if @gpio == 25
    	@is_air_pump = true
    else
    	@is_air_pump = false
    end
    # @sensor = Sensor.new
    @pwm_hz = 100
    initialize_gpio()
  end

  def run(seconds)
	seconds = seconds.to_f
	start_time = Time.now.to_f
  	# if !@sensor.is_high
  	# 	prime()
  	# end

	while Time.now.to_f < start_time + seconds
		set_pwm(100)
	end
  	stop_pwm()

  end

  def stop()
  	stop_pwm()
  end

  def continuous_run
  	if is_air_pump
  		set_pwm(100)
  	end
  end

  def stop_continuous_run
  	complete_stop()
  end

  private
    
    attr_writer :gpio, :io, :pwm_hz

  	def initialize_gpio()
  		@io = ::RaspPiIO.io
  		@io.pin_mode(@gpio.to_i, WiringPi::HIGH)
  	  @io.soft_pwm_create(@gpio.to_i, 0, @pwm_hz)
  	end

    def shutdown_gpio()
      @io.pin_mode(@gpio.to_i, WiringPi::LOW)
      @io = nil
    end

    def set_pwm(power)
    	if @io.blank? 
    		initialize_gpio()
    	end

      @io.soft_pwm_write(@gpio.to_i, power)
    end

    def delay(delay)
    	@io.delay(delay.to_i)
    end

    def stop_pwm()
      @io.soft_pwm_write(@gpio.to_i, WiringPi::LOW)
    end

    def complete_stop()
      stop_pwm()
      shutdown_gpio()
    end

    def prime()
    	primed = @sensor.check
    	if !primed
    		set_pwm(100)
    		prime()
    	else
    		stop_pwm()
    	end
    end

end
