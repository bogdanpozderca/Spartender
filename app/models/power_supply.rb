class PowerSupply < ActiveRecord::Base
  attr_reader :gpio, :io

  def initialize
    @gpio = 6
    initialize_gpio()
  end

	def start()
    initialize_gpio()
	end

	def stop()
    shutdown_gpio()
	end

	private
    attr_writer :gpio, :io

  	def initialize_gpio()
  		@io = WiringPi::GPIO.new do |gpio|
  	    gpio.pin_mode(@gpio, WiringPi::HIGH)
  		end
  	end

    def shutdown_gpio()
      @io.pin_mode(@gpio, WiringPi::LOW)
      @io = nil
    end
end
