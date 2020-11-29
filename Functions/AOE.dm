proc/AOEPoison(xx, xy, xz, radius, stamdamage, duration, mob/human/attacker, poi, stun)
	var/obj/entertrigger/poisonsmoke/o = new/obj/entertrigger/poisonsmoke(locate(xx, xy, xz))
	var/i = duration
	while(i > 0)
		i -= 10
		sleep(10)
	o.loc = null




proc/AOE_(xx,xy,xz,radius,stamdamage,duration,mob/human/attacker,wo,stun)
	var/obj/M=new/obj(locate(xx,xy,xz))
	var/i=duration
	while(i>0)
		i-=10
		for(var/mob/human/O in oview(radius,M))
			if(O==attacker)
				return
			else
				if(O)
					spawn()
						var/time = rand(2,6)
						O.combat("Your body is slowly corroding due to the mist")
						while(O && time > 0)
							if(O)
								O.Wound(rand(0,wo),0, attacker)
								O.Dec_Stam(stamdamage/4,0,attacker)

								O.Hostile(attacker)

							sleep(rand(10,20))
							time--

					if(O.move_stun<30 && !O.ko && !O.protected)
						O.move_stun += rand(1,50)

					O.Dec_Stam(stamdamage,0,attacker)
					O.Hostile(attacker)
		sleep(10)
	CHECK_TICK
	del(M)

proc/AOE(xx, xy, xz, radius, stamdamage, duration, mob/human/attacker, wo, stun)
	var/obj/M = new /obj(locate(xx, xy, xz))
	var/i = duration
	while(i > 0)
		i -= 5
		for(var/mob/human/O in oview(radius, M))
			spawn()
				if(O)
					O = O.Replacement_Start(attacker)
					O.Timed_Move_Stun(30)
					O.Damage(stamdamage/2, rand(0, wo), attacker, "AOE", "Normal")
					O.Hostile(attacker)
					if(O.burning && O.burndur) O.burndur = 50
					spawn(5) if(O) O.Replacement_End()
		sleep(5)
	M.loc = null

proc/AOEx(xx, xy, xz, radius, stamdamage, duration, mob/human/attacker, wo, stun)
	var/obj/M = new/obj(locate(xx, xy, xz))
	var/i = duration
	while(i > 0)
		i -= 10
		for(var/mob/human/O in oview(radius, M))
			if(O != attacker)
				spawn()
					O = O.Replacement_Start(attacker)
					if(stun)
						stun = stun * 10
						O.Timed_Move_Stun(stun)
					O.Damage(stamdamage, rand(0, wo), attacker, "AOEx", "Normal")
					O.Hostile(attacker)
					spawn(5) if(O) O.Replacement_End()

		sleep(10)
	M.loc = null

mob/var/justwalk=0
proc/AOExk(xx, xy, xz, radius, stamdamage, duration, mob/human/attacker, wo, stun, knock)
	var/obj/M = new /obj(locate(xx, xy, xz))
	var/i = duration
	while(i > 0)
		i -= 10
		for(var/mob/human/O in oview(radius, M))
			if(O != attacker)
				spawn()
					if(O)
						O = O.Replacement_Start(attacker)
						O.Damage(stamdamage, rand(0, wo), attacker, "AOExk", "Normal")
						//O.Wound(rand(0, wo), 0, attacker)
						//O.Dec_Stam(stamdamage, 0, attacker)
						O.Hostile(attacker)
						if(O && knock)
							var/ns = 0
							var/ew = 0
							if(O.x > xx)
								ew = 1
							if(O.x < xx)
								ew = 2
							if(O.y < xy)
								ns = 2
							if(O.y > xy)
								ns = 1
							if(O && ns == 1 && ew == 0)
								O.Knockback(knock+1, NORTH)
							if(O && ns == 2 && ew == 0)
								O.Knockback(knock+1, SOUTH)
							if(O && ns == 1 && ew == 1)
								O.Knockback(knock+1, NORTHEAST)
							if(O && ns == 1 && ew == 2)
								O.Knockback(knock+1, NORTHWEST)
							if(O && ns == 2 && ew == 1)
								O.Knockback(knock+1, SOUTHEAST)
							if(O && ns == 2 && ew == 2)
								O.Knockback(knock+1, SOUTHWEST)
							if(O && ns == 0 && ew == 1)
								O.Knockback(knock+1, EAST)
							if(O && ns == 0 && ew == 2)
								O.Knockback(knock+1, WEST)
						if(O) O.Timed_Move_Stun(stun*10)
						spawn(5) if(O) O.Replacement_End()
		sleep(10)
	M.loc = null

proc/AOExk2(xx, xy, xz, radius, stamdamage, duration, mob/human/attacker, wo, stun, knock)
	var/obj/M = new /obj(locate(xx, xy, xz))
	var/i = duration
	while(i > 0)
		i -= 10
		for(var/mob/human/O in oview(radius, M))
			spawn()
				O = O.Replacement_Start(attacker)
				O.Damage(stamdamage, rand(0, wo), attacker, "AOExk2", "Normal")
				//O.Wound(rand(0, wo), 0, attacker)
				//O.Dec_Stam(stamdamage, 0, attacker)
				O.Hostile(attacker)
				if(knock && O)
					var/ns = 0
					var/ew = 0
					if(O.x > xx)
						ew = 1
					if(O.x < xx)
						ew = 2
					if(O.y < xy)
						ns = 2
					if(O.y > xy)
						ns = 1
					if(ns == 1 && ew == 0)
						O.Knockback(knock+1, NORTH)
					if(ns == 2 && ew == 0)
						O.Knockback(knock+1, SOUTH)
					if(ns == 1 && ew == 1)
						O.Knockback(knock+1, NORTHEAST)
					if(ns == 1 && ew == 2)
						O.Knockback(knock+1, NORTHWEST)
					if(ns == 2 && ew == 1)
						O.Knockback(knock+1, SOUTHEAST)
					if(ns == 2 && ew == 2)
						O.Knockback(knock+1, SOUTHWEST)
					if(ns == 0 && ew == 1)
						O.Knockback(knock+1, EAST)
					if(ns == 0 && ew == 2)
						O.Knockback(knock+1, WEST)
				if(O) O.Timed_Move_Stun(stun*10)
				spawn(5) if(O) O.Replacement_End()
		sleep(10)
	M.loc = null

proc/AOEcc(xx, xy, xz, radius, stamdamage, stamdamage2, duration, mob/human/attacker, wo, stun, knock)
	var/obj/M = new /obj(locate(xx, xy, xz))
	var/i = duration
	var/list/gotcha[] = list()
	while(i > 0)
		i -= 10
		for(var/mob/human/O in oview(radius, M))
			spawn() if(O && O != attacker && !O.IsProtected())
				O = O.Replacement_Start(attacker)
				if(!gotcha.Find(O.realname))
					O.Damage(stamdamage, rand(0, wo), attacker, "AOEcc", "Normal")
					if(istype(O,/mob/human/ironsand))
						del(O)
						return
					gotcha.Add(O.realname)
				else
					O.Damage(stamdamage2, rand(0, wo), attacker, "AOEcc", "Normal")
				O.Hostile(attacker)
				if(!O.ko && O.icon_state != "hurt") O.icon_state = "hurt"
				O.Timed_Stun(11)
				O.Timed_Move_Stun(stun*10)
				spawn(5) if(O) O.Replacement_End()
		sleep(10)
	for(var/mob/human/O in oview(radius, M))
		spawn() if(O  && O != attacker && knock)
			var/ns = 0
			var/ew = 0
			if(O.x > xx)
				ew = 1
			if(O.x < xx)
				ew = 2
			if(O.y < xy)
				ns = 2
			if(O.y > xy)
				ns = 1
			O = O.Replacement_Start(attacker)
			if(ns == 1 && ew == 0)
				O.Knockback(knock+1, NORTH)
			if(ns == 2 && ew == 0)
				O.Knockback(knock+1, SOUTH)
			if(ns == 1 && ew == 1)
				O.Knockback(knock+1, NORTHEAST)
			if(ns == 1 && ew == 2)
				O.Knockback(knock+1, NORTHWEST)
			if(ns == 2 && ew == 1)
				O.Knockback(knock+1, SOUTHEAST)
			if(ns == 2 && ew == 2)
				O.Knockback(knock+1, SOUTHWEST)
			if(ns == 0 && ew == 1)
				O.Knockback(knock+1, EAST)
			if(ns == 0 && ew == 2)
				O.Knockback(knock+1, WEST)
			if(O && !gotcha.Find(O.realname))
				O.Damage(stamdamage, rand(0, wo), attacker, "AOEcc", "Normal")
			else
				if(O) O.Damage(stamdamage2, rand(0, wo), attacker, "AOEcc", "Normal")
			if(O)
				O.Hostile(attacker)
				O.Timed_Stun(4)
				O.Timed_Move_Stun(stun*10)
			spawn(5) if(O) O.Replacement_End()
		spawn(5) if(O && !O.ko && O.icon_state == "hurt") O.icon_state = ""
	M.loc = null