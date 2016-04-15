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
  	# if !@sensor.is_high
  	# 	prime()
  	# end

  	set_pwm(100)
  	sleep seconds
  	stop_pwm()

  end

  def continuous_run
  	if is_air_pump
  		set_pwm(100)
  	end
  end

  def stop_continuous_run
  	stop_pwm()
  end

  private
    
    attr_writer :gpio, :io, :pwm_hz

  	def initialize_gpio()
  		@io = ::RaspPiIO.io
  		@io.pin_mode(@gpio, WiringPi::HIGH)
  	  @io.soft_pwm_create(@gpio, 0, @pwm_hz)
  	end

    def shutdown_gpio()
      @io.pin_mode(@gpio, WiringPi::LOW)
      @io = nil
    end

    def set_pwm(power)
    	if @io.blank? 
    		initialize_gpio()
    	end

      @io.soft_pwm_write(@gpio, power)
    end

    def delay(delay)
    	@io.delay(delay)
    end

    def stop_pwm()
      @io.soft_pwm_write(@gpio, WiringPi::LOW)
    end

    def stop()
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
