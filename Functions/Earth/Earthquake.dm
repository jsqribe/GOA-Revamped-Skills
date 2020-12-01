mob
	proc/Earthquake(max_steps = 5, offset_min = -2, offset_max = 2)
		for(var/mob/M in viewers())
			if(M.client)
				spawn()
					var/steps = 0
					while(M && M.client && steps < max_steps)
						M.client.pixel_y = rand(offset_min, offset_max)
						sleep(1)
						++steps