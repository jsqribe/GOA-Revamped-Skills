mob/proc/Knockback(k, xdir, slow=1)
	//if(!istype(src, /mob/human/npc) && src.paralysed == 0 && !src.stunned && !src.ko && !src.mane && !src.chambered)
	if(!istype(src, /mob/human/npc) && src.paralysed == 0 && !src.ko && !src.noknock && !src.mane && !src.chambered && !src.sandshield && !src.incombo && !src.IsProtected())
		//if(slow) spawn src.Timed_Move_Stun(20)
		if(!src.icon_state)
			src.icon_state = "hurt"
		if(!src.cantreact)
			src.cantreact = 1
			spawn(10)
				src.cantreact = 0
		src.animate_movement = 2
		var/i = k
		var/reflected = 0

		while(i > 0 &&src)
			src.kstun = 2
			var/pass = 1
			var/turf/T = get_step(src, xdir)
			for(var/atom/o in get_step(src, xdir))
				if(o)
					if(o.density)
						pass = 0
			if(!T)
				pass = 0
			else
				if(T.density)
					pass = 0
			if(xdir == NORTH)
				if(pass)
					src.y++
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(SOUTHEAST, SOUTHWEST)
					reflected = 1
					continue
			if(xdir == SOUTH)
				if(pass)
					src.y--
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(NORTHEAST, NORTHWEST)
					reflected = 1
					continue
			if(xdir == EAST)
				if(pass)
					src.x++
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(NORTHWEST, SOUTHWEST)
					reflected = 1
					continue
			if(xdir == WEST)
				if(pass)
					src.x--
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(NORTHEAST, SOUTHEAST)
					reflected = 1
					continue
			if(xdir == NORTHWEST)
				if(pass)
					src.y++
					src.x--
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(EAST, SOUTH)
					reflected = 1
					continue
			if(xdir == NORTHEAST)
				if(pass)
					src.y++
					src.x++
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(WEST, SOUTH)
					reflected = 1
					continue
			if(xdir == SOUTHEAST)
				if(pass)
					src.y--
					src.x++
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(WEST, NORTH)
					reflected = 1
					continue
			if(xdir == SOUTHWEST)
				if(pass)
					src.y--
					src.x--
				else if(!reflected)
					i /= 2
					i = round(i,1)
					xdir = pick(EAST, NORTH)
					reflected = 1
					continue
			sleep(1)
			i--
		src.kstun = 0
		if(src)
			src.animate_movement = 1
			if(src.icon_state == "hurt") src.icon_state = ""