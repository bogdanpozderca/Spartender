class Mixer < ActiveRecord::Base
  attr_reader :type, :gpio

  def initialize(type, viscosity, gpio)
    @type = name
    @viscosity = viscosity
    @motor = Motor.new gpio 
    @gpio = @motor.gpio
  end

  def pour(ml, intensity)
    # Do some math for viscosity, intensity, and ml to calculate time for motor
    seconds = 2 # hardcoded for now 
    @motor.run seconds
  end

end
