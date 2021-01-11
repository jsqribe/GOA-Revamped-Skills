//Jon


proc
	Make_Water(loc)
		var/obj/water/W=new/obj/water
		W.loc=loc
		spawn(1200)
			del(W)



mob
	proc
		NearWater(range=world.view)
			//not needed as Iswater checks that
			/*for(var/obj/water/X in oview(src, range))
				return 1*/
			for(var/turf/X in oview(src, range))
				if(Iswater(X))
					return 1
			return 0


		ClosestWater(range=world.view)
			var/closest
			var/closest_dist = 1e40
			for(var/turf/X in oview(src, range))
				if(Iswater(X))
					var/new_dist = get_true_dist(src, X)
					if(new_dist < closest_dist)
						closest = X
						closest_dist = new_dist
			return closest




/*proc
	Mirrors(mob/target, mob/user)
		if(!target || !user) return

		var/atom/water = user.ClosestWater(10)
		if(!water) return

		var/obj/Q = new/obj/waterblob(locate(water.x,water.y,water.z))

		user.oldloc = user.loc
		user.loc = null
		if(user.client) user.client.eye = Q

		while(get_dist(Q, target) > 1)
			step_to(Q, target)
			CHECK_TICK
			if(!Q || !target || !user) return

		var/turf/cen = Q.loc
		if(user.client) user.client.eye = cen

		Q.loc = null
		Q = null

		var/mirrorlist[0]
		mirrorlist+=Make_Mirror(cen, -2, 0, "Right", user, pixel_x = -16)
		mirrorlist+=Make_Mirror(cen, -2, 1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -2, -1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 0, 2, "Back", user, pixel_y = 16)
		mirrorlist+=Make_Mirror(cen, 1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 2, 0, "Left", user, pixel_x = 16)
		mirrorlist+=Make_Mirror(cen, 2, 1, "Left", user)
		mirrorlist+=Make_Mirror(cen, 2, -1, "Left", user)
		mirrorlist+=Make_Mirror(cen, -1, -2, "Back", user, hide = 1)
		mirrorlist+=Make_Mirror(cen, 0, -2, "Back", user, pixel_y = -16, hide = 1)
		mirrorlist+=Make_Mirror(cen, 1, -2, "Back", user, hide = 1)

		mirrorlist+=Make_Mirror(cen, -2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, -2, 2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, 2, "", user)

		return list("center" = cen, "mirrors" = mirrorlist)


	Make_Mirror(atom/start, dx, dy, state, mob/user, pixel_x=0, pixel_y=0, hide=0)
		if(!user || !start)
			return

		var/turf/mirror_loc=locate(start.x+dx,start.y+dy,start.z)
		if(!mirror_loc) return

		var/obj/mirror/X=new/obj/mirror(mirror_loc)
		X.invisibility = 101

		switch(state)
			if("Back")
				if(!hide)
					X.icon=user.icon
					X.overlays+=user.overlays
				X.underlays+=/obj/mirror/Back
				X.overlays+=/obj/mirror/Front

			if("Right", "Left")
				X.icon='icons/Haku.dmi'
				X.icon_state=state

		X.pixel_x=pixel_x
		X.pixel_y=pixel_y

		spawn()
			var/obj/Q = new/obj/waterblob(start)
			while(Q.loc != mirror_loc)
				step_to(Q, mirror_loc)
				CHECK_TICK
				if(!user)
					Q.loc = null
					return

			Q.icon_state="none"
			switch(state)
				if("Right")
					Q.dir=EAST
				if("Left")
					Q.dir=WEST
				if("Back")
					Q.dir=NORTH
			flick("formmirrors",Q)
			sleep(12)
			Q.loc = null
			X.invisibility = 0

		return X*/


/*proc
	Mirrors(mob/target, mob/user)
		if(!target || !user) return

		var/atom/water = user.ClosestWater(10)
		if(!water) return

		var/obj/Q = new/obj/waterblob(locate(water.x,water.y,water.z))
		while(get_dist(Q, target) > 1)
			step_to(Q, target)
			CHECK_TICK
			if(!Q || !target || !user) return

		var/turf/cen = Q.loc
		Q.loc = null
		Q = null

		var/mirrorlist[0]
		mirrorlist+=Make_Mirror(cen, -2, 0, "Right", user, pixel_x = -16)
		mirrorlist+=Make_Mirror(cen, -2, 1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -2, -1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 0, 2, "Back", user, pixel_y = 16)
		mirrorlist+=Make_Mirror(cen, 1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 2, 0, "Left", user, pixel_x = 16)
		mirrorlist+=Make_Mirror(cen, 2, 1, "Left", user)
		mirrorlist+=Make_Mirror(cen, 2, -1, "Left", user)
		mirrorlist+=Make_Mirror(cen, -1, -2, "Back", user, hide = 1)
		mirrorlist+=Make_Mirror(cen, 0, -2, "Back", user, pixel_y = -16, hide = 1)
		mirrorlist+=Make_Mirror(cen, 1, -2, "Back", user, hide = 1)
		return list("center" = cen, "mirrors" = mirrorlist)

*/

proc
	Mirrors(mob/target, mob/user)
		if(!target || !user) return

		var/atom/water = user.ClosestWater(10)
		if(!water) return

		var/obj/Q = new/obj/waterblob(locate(water.x,water.y,water.z))

		user.oldloc = user.loc
		//user.loc = null
		if(user.client) user.client.eye = Q

		var/step_count=20
		while(get_dist(Q, target) > 1 && step_count>0)
			step_to(Q, target)
			step_count--
			sleep(1)
			if(!Q || !target || !user) return

		var/turf/cen = Q.loc
		if(user.client) user.client.eye = cen

		Q.loc = null
		Q = null

		var/mirrorlist[0]
		mirrorlist+=Make_Mirror(cen, -2, 0, "Right", user, pixel_x = -16)
		mirrorlist+=Make_Mirror(cen, -2, 1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -2, -1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 0, 2, "Back", user, pixel_y = 16)
		mirrorlist+=Make_Mirror(cen, 1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 2, 0, "Left", user, pixel_x = 16)
		mirrorlist+=Make_Mirror(cen, 2, 1, "Left", user)
		mirrorlist+=Make_Mirror(cen, 2, -1, "Left", user)
		mirrorlist+=Make_Mirror(cen, -1, -2, "Back", user, hide = 1)
		mirrorlist+=Make_Mirror(cen, 0, -2, "Back", user, pixel_y = -16, hide = 1)
		mirrorlist+=Make_Mirror(cen, 1, -2, "Back", user, hide = 1)

		mirrorlist+=Make_Mirror(cen, -2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, -2, 2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, 2, "", user)

		return list("center" = cen, "mirrors" = mirrorlist)

	Make_Mirror(atom/start, dx, dy, state, mob/user, pixel_x=0, pixel_y=0, hide=0)
		if(!user || !start)
			return

		var/turf/mirror_loc=locate(start.x+dx,start.y+dy,user.z)
		if(!mirror_loc) return

		var/obj/mirror/X=new/obj/mirror(mirror_loc)
		X.invisibility = 101

		switch(state)
			if("Back")
				if(!hide)
					X.icon=user.icon
					X.overlays+=user.overlays
				X.underlays+=/obj/mirror/Back
				X.overlays+=/obj/mirror/Front

			if("Right", "Left")
				X.icon='icons/Haku.dmi'
				X.icon_state=state

		X.pixel_x=pixel_x
		X.pixel_y=pixel_y

		spawn()
			var/obj/Q = new/obj/waterblob(start)
			while(Q.loc != mirror_loc)
				step_to(Q, mirror_loc)
				sleep(1)
				if(!user)
					del(Q)
					return

			Q.icon_state="none"
			switch(state)
				if("Right")
					Q.dir=EAST
				if("Left")
					Q.dir=WEST
				if("Back")
					Q.dir=NORTH
			flick("formmirrors",Q)
			sleep(12)
			del(Q)
			X.invisibility = 0

		return X