module ScrimagesHelper
	def remaining_time(scrimage)
		(scrimage.end_time.to_time - DateTime.now.to_time).to_i
	end

	def voting_time(scrimage)
		((scrimage.end_time.to_time+(5*60*60*24)) - DateTime.now.to_time).to_i
		# To test with shorter voting period
		#(scrimage.end_time + 5 - DateTime.now).to_i
	end
end
