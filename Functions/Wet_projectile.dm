proc
	wet_proj(dx,dy,dz,eicon,estate,mob/human/u,dist,epower,emag,sticky,dur=1200)
		var/obj/proj/M = new/obj/proj(locate(dx, dy, dz))
		M.projdisturber = 1
		M.density = 0
		M.icon = eicon
		M.icon_state = estate

		switch(u.dir)
			if(NORTHEAST, NORTHWEST)
				M.dir = NORTH
			if(SOUTHEAST, SOUTHWEST)
				M.dir = SOUTH
			else
				M.dir = u.dir

		if(emag >= 1)
			Wet_cap(M.x, M.y, M.z, M.dir, emag, dur, sticky)
			Wet(M.x, M.y, M.z, M.dir, emag, dur, sticky)

		sleep(1)
		var/stepsleft = dist
		while(stepsleft > 0 && M)
			if(M && u)
				var/mob/hit
				for(var/mob/O in M.loc)
					if(istype(O, /mob/human))
						if(O != u)
							hit = O

				M.loc = get_step(M, M.dir)

				sleep(1)

				if(emag>=1)
					Wet(M.x, M.y, M.z, M.dir, emag, dur, sticky)

				walk(M, 0)
				stepsleft--
				if(hit)
					hit = hit.Replacement_Start(u)
					if(epower) hit.Damage(epower, 0, u, "Water Projectile", "Normal")
					if(sticky) hit.Timed_Stun(50)
					spawn(1)
						if(hit)
							hit.Knockback(1, M.dir)
							if(u)
								spawn(2)
									if(hit)
										hit.Hostile(u)
										spawn(2) if(hit) hit.Replacement_End()

		M.loc = get_step(M, M.dir)

		if(emag >= 1)
			Wet_cap(M.x, M.y, M.z, M.dir, emag, dur, sticky)

		sleep(1)

		M.loc = null

proc
	Wet_cap(start_x, start_y, start_z, xdir, mag, xdur, sticky)
		spawn()
			var
				side_dx = 0
				side_dy = 0
				water_type
				sides[0]

			switch(xdir)
				if(NORTH)
					side_dx = 1
					if(sticky) water_type = /obj/water_sides/sticky/wu
					else water_type = /obj/water_sides/wu
				if(SOUTH)
					side_dx = 1
					if(sticky) water_type = /obj/water_sides/sticky/wd
					else water_type = /obj/water_sides/wd
				if(EAST)
					side_dy = 1
					if(sticky) water_type = /obj/water_sides/sticky/wr
					else water_type = /obj/water_sides/wr
				if(WEST)
					side_dy = 1
					if(sticky) water_type = /obj/water_sides/sticky/wl
					else water_type = /obj/water_sides/wl
				else
					CRASH("Unsupported xdir ([xdir])")

			sides += new water_type(locate(start_x, start_y, start_z))
			while(mag > 1)
				sides += new water_type(locate(start_x + (mag-1)*side_dx, start_y + (mag-1)*side_dy, start_z))
				sides += new water_type(locate(start_x - (mag-1)*side_dx, start_y - (mag-1)*side_dy, start_z))

				--mag

			spawn(xdur)
				for(var/obj/O in sides)
					O.loc = null

	Wet(start_x, start_y, start_z, xdir, mag, xdur, sticky)
		spawn()
			var
				side_dx = 0
				side_dy = 0
				side_type1
				side_type2
				water_type = /obj/water
				water[0]

			if(sticky) water_type = /obj/water/sticky

			switch(xdir)
				if(NORTH)
					side_dx = 1
					if(sticky)
						side_type1 = /obj/water_sides/sticky/wr
						side_type2 = /obj/water_sides/sticky/wl
					else
						side_type1 = /obj/water_sides/wr
						side_type2 = /obj/water_sides/wl
				if(SOUTH)
					side_dx = 1
					if(sticky)
						side_type1 = /obj/water_sides/sticky/wr
						side_type2 = /obj/water_sides/sticky/wl
					else
						side_type1 = /obj/water_sides/wr
						side_type2 = /obj/water_sides/wl
				if(EAST)
					side_dy = 1
					if(sticky)
						side_type1 = /obj/water_sides/sticky/wu
						side_type2 = /obj/water_sides/sticky/wd
					else
						side_type1 = /obj/water_sides/wu
						side_type2 = /obj/water_sides/wd
				if(WEST)
					side_dy = 1
					if(sticky)
						side_type1 = /obj/water_sides/sticky/wu
						side_type2 = /obj/water_sides/sticky/wd
					else
						side_type1 = /obj/water_sides/wu
						side_type2 = /obj/water_sides/wd
				else
					CRASH("Unsupported xdir ([xdir])")

			water += new water_type(locate(start_x, start_y, start_z))
			water += new side_type1(locate(start_x + mag * side_dx, start_y + mag * side_dy, start_z))
			water += new side_type2(locate(start_x - mag * side_dx, start_y - mag * side_dy, start_z))
			while(mag > 1)
				water += new water_type(locate(start_x + (mag-1)*side_dx, start_y + (mag-1)*side_dy, start_z))
				water += new water_type(locate(start_x - (mag-1)*side_dx, start_y - (mag-1)*side_dy, start_z))

				--mag

			spawn(xdur)
				for(var/obj/O in water)
					O.loc = null


	LavaHit(locz)
		for(var/turf/T in view(locz,2))
			var/obj/L = new/obj/lava(locate(T.x,T.y,T.z))

			spawn(100)
				del(L)