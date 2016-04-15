class StaticPagesController < ApplicationController
	
	def index
		@gpios = [21,22,23,24,26,28,29]
		mot = Motor.new 9
		puts mot.io
	end

	def test
		power_supply = PowerSupply.new
		air_pump = Motor.new 25
		air_pump.continuous_run

		7.times.each do |x|
			if !test_params["gpio#{x}"].blank?
				p test_params["gpio#{x}"].to_i
				motor = Motor.new test_params["gpio#{x}"].to_i
				if test_params["time#{x}"]
					motor.run test_params["time#{x}"]
				else
					motor.run 2
				end
			end
		end

		sleep 7
		air_pump.stop_continuous_run
		power_supply.stop
	end

	private
		def test_params
	    params.permit(:gpio1, :gpio2, :gpio3, :gpio4, :gpio5, :gpio6, :gpio7,
	    	:time1, :time2, :time3, :time4, :time5, :time6, :time7,)
	  end
end
