proc/PoisonSmoke(mob/human/user, dx, dy, dz, direction)
	var/obj/entertrigger/poisonsmoke/o = new/obj/entertrigger/poisonsmoke(locate(dx, dy, dz))
	o.owner = user
	o.muser = user
	o.step_size = 32

	spawn(120)
		if(o)
			o.loc = null

	if(direction == NORTH)
		o.pixel_y -= 16
		o.pixel_x += 0
	else if(direction == SOUTH)
		o.pixel_y += 16
		o.pixel_x += 0
	else if(direction == EAST)
		o.pixel_y += 0
		o.pixel_x -= 16
	else if(direction == WEST)
		o.pixel_y += 0
		o.pixel_x += 16
	spawn(rand(1,4))
		while(o.pixel_y != -32 || o.pixel_x != -32)
			if(o.pixel_y > -32)
				o.pixel_y -= 1
			else if(o.pixel_y < -32)
				o.pixel_y += 1
			if(o.pixel_x > -32)
				o.pixel_x -= 1
			else if(o.pixel_x < -32)
				o.pixel_x += 1
			sleep(rand(1,4))