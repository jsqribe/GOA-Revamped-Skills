proc/WaveDamage(mob/human/u, mag, dam, knockback, xdist, burn=0)
	var/turf/center = u.loc
	if(!center) return

	var/list/effect_turfs = list(center)
	//var/list/effect_objs = list()

	//effect_objs += new /obj/Gustfx(center)

	var/dir = u.dir
	var/dir1 = turn(dir, 90)
	var/dir2 = turn(dir, -90)
	var/turf/T1 = center
	var/turf/T2 = center
	for(var/i = 1, i < mag, ++i)
		T1 = get_step(T1, dir1)
		T2 = get_step(T2, dir2)
		effect_turfs += T1
		effect_turfs += T2
		//effect_objs += new /obj/Gustfx(T1)
		//effect_objs += new /obj/Gustfx(T2)

	//for(var/obj/O in effect_objs)
	//	O.dir = dir

	var/distance = xdist
	var/list/hit = list()
	for(, distance > 0; --distance)
		center = get_step(center, dir)

		if(!center) return

		var/list/new_effect = list()

		for(var/turf/T in effect_turfs)
			new_effect += get_step(T, dir)

		effect_turfs = new_effect

		//for(var/obj/O in effect_objs)
		//	step(O, dir)


		for(var/turf/T in effect_turfs)
			for(var/mob/human/M in T)
				if(!istype(M, /mob/human/npc) && !(M in hit))
					M = M.Replacement_Start(u)
					hit += M
					spawn() if(M) M.Knockback(knockback,dir,0)//donn't slow
					M.Damage(dam, 0, u, "WaveDamage", "Normal")
					if(burn) M.BurnDOT(u,13*u.ControlDamageMultiplier())
					spawn() if(M) M.Hostile(u)
					spawn(5) if(M) M.Replacement_End()
			if(burn)
				for(var/obj/smoke/s in T)
					spawn()
						if(!s.ignited) s.Ignite(s,s.loc)

		sleep(1)

	//for(var/obj/O in effect_objs)
	//	O.loc = null

proc/InsectWaveDamage(mob/human/u,mag,dam,knockback,xdist)
	var/dir = u.dir
	var/turf/center = u.loc
	var/distance = xdist
	var/list/hit = list()
	for(, center && distance > 0; --distance)
		center = get_step(center, dir)
		if(!center) return
		var/dir1 = turn(dir, 90)
		var/dir2 = turn(dir, -90)
		var/turf/T1 = center
		var/turf/T2 = center
		var/list/effect_turfs = list(center)
		for(var/i = 0, i < mag, ++i)
			T1 = get_step(T1, dir1)
			T2 = get_step(T2, dir2)
			effect_turfs += T1
			effect_turfs += T2

		for(var/turf/T in effect_turfs)
			for(var/mob/human/M in T)
				if(!istype(M, /mob/human/npc) && !(M in hit) && M!=u)
					hit += M
					spawn() if(M) M.Knockback(knockback,dir)
					M.Dec_Stam(dam,0,u)
					u.Bug_Projectile_Hit(M,u)
					spawn() if(M) M.Hostile(u)

		sleep(1)