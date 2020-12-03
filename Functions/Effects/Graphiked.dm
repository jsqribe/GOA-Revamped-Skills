mob
	proc/Graphiked(icon/I, xoffset, yoffset)
		var/image/O = image(I,src, pixel_x = xoffset, pixel_y = yoffset)
		world << O
		sleep(1)
		var/time = 0
		var/time_limit = 5
		while(time < time_limit)
			O.pixel_y += 2
			sleep(1)
			time++
		O.loc = null