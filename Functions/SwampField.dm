proc/SwampField(mob/human/user, turf/source, size=3, delay=2)
	var/obj/entertrigger/swampobj/swamp = new/obj/entertrigger/swampobj(source)
	swamp.muser = user
	swamp.spread2(source, size, delay)
	user.onswamp=0
	//if(!user.onswamp) user.SwampDmg()
	user.UsrOnSwamp=1
	sleep(15)
	user.UsrOnSwamp=0


obj/entertrigger/swampobj
	icon = 'icons/swamp.dmi'
	icon_state = ""
	var/tmp/mob/human/muser
	New()
		..()
		underlays += image(icon='icons/swamp.dmi', icon_state = "up", pixel_y=32)
		underlays += image(icon='icons/swamp.dmi', icon_state = "down", pixel_y=-32)
		underlays += image(icon='icons/swamp.dmi', icon_state = "left", pixel_x=-32)
		underlays += image(icon='icons/swamp.dmi', icon_state = "right", pixel_x=32)
		spawn(200)
			if(muser in src.loc)
				muser.Affirm_Icon()
				muser.Load_Overlays()
			loc = null

	SteppedOn(mob/human/player/M)
		if(istype(M,/mob/human/player) && M.client && !M.ko && !M.IsProtected())
			//M.Poison += 1 + muser.skillspassive[23]*0.25
			//M.combat("You have been affected by swamp")
			//world << "Affected Mob([M.x],[M.y]) by Object([src.x],[src.y])"
			if(M!=muser)
				M.Timed_Move_Stun(30) //lags out?
				M.Hostile(muser)
				//world << "[M],[muser]"
				M.Damage(500,0,muser,"Swamp of the Underworld","Normal")

	proc/spread2(turf/source, size=3, delay=2)
		var/list/dirs = list(NORTH,,EAST,SOUTH,WEST,NORTHWEST,NORTHEAST,SOUTHEAST,SOUTHWEST)
		for(var/xdir in dirs)
			var/doit = 1
			for(var/obj/entertrigger/swampobj/mo in get_step(src,xdir))
				if(mo.muser == src.muser) doit = 0
			if(doit)
				var/obj/entertrigger/swampobj/swamp = new/obj/entertrigger/swampobj(src.loc)
				swamp.muser = src.muser
				var/stepcheck = step(swamp, xdir)
				if(stepcheck)
					if(size > get_dist(swamp,source)) spawn(delay) swamp.spread2(source, size=size, delay=delay)
					sleep(1)
				else
					swamp.loc = null