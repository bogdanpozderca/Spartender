class StaticPagesController < ApplicationController
	
	def index
		@gpios = [21,22,23,24,26,28,29]
		pp Mixer.all
		ps = PowerSupply.new do |p|
		end

		pp PowerSupply.all

	end

	def test
		@gpios = [21,22,23,24,26,27,28,29]
	end

	def test_post
		power_supply = PowerSupply.new
		air_pump = Motor.new 25
		air_pump.continuous_run

		8.times.each do |x|
			if !test_params["gpio#{x}"].blank?
				p test_params["gpio#{x}"].to_i
				motor = Motor.new test_params["gpio#{x}"].to_i
				if !test_params["time#{x}"].blank?
					Thread.new { motor.run test_params["time#{x}"] }
				else
					Thread.new { motor.run 2 }
				end
			end
		end

		sleep 7
		air_pump.stop_continuous_run
		power_supply.stop
	end

	def stop
		@gpios = [21,22,23,24,26,28,29]
		@gpios.each do |x|
			mot = Motor.new x.to_i
			mot.stop
		end

		air_pump = Motor.new 25
		air_pump.stop_continuous_run
		power_supply = PowerSupply.new
		power_supply.stop
	end


	private
		def test_params
	    params.permit(:gpio1, :gpio2, :gpio3, :gpio4, :gpio5, :gpio6, :gpio7,
	    	:time1, :time2, :time3, :time4, :time5, :time6, :time7,)
	  end
end
