obj/BSEnter
	icon='icons/bloodtracks.dmi'
	icon_state="enter"
	New()
		..()
		spawn(rand(70,110))
			del(src)
obj/BSExit
	icon='icons/bloodtracks.dmi'
	icon_state="exit"
	New()
		..()
		spawn(rand(70,110))
			del(src)




mob/proc/Blood_Add(mob/V)
	if(V)
		if(!bloodrem.Find(V))
			bloodrem+=V
			//world<<"Adding [V.name] to blood list"
			spawn(600+world.tick_lag) //Spawn Tick Changes
				bloodrem-=V

		//else
			//world<<"[V.name] already in blood list"

proc/Blood2(mob/X, mob/human/U)
	spawn()
		if(!X || (X && X.chambered)) return
		if(U && U.HasSkill(BLOOD_BIND))
			spawn() U.Blood_Add(X)
		var/obj/o = new /obj/effect(locate(X.x, X.y, X.z))
		o.icon = 'icons/blood.dmi'
		var/r = rand(1, 7)
		flick("[r]", o)

		var/obj/undereffect/x = new /obj/undereffect(locate(X.x, X.y, X.z))
		spawn()
			x.uowner = X
			for(var/obj/undereffect/G in locate(X))
				var/nopk = 0
				for(var/area/O in orange(0, src))
					if(!O.pkzone)
						nopk = 1

				if(!nopk)
					G.uowner = X
				else
					G.uowner = 0

		spawn(9)
			o.loc = null
			if(!x) return
			x.icon = 'icons/blood.dmi'
			var/v = rand(1,7)
			x.icon_state = "l[v]"
			spawn(600)
				x.loc = null

proc/Blood(dx, dy, dz)
	spawn()
		var/obj/o = new /obj/effect(locate(dx, dy, dz))
		o.icon = 'icons/blood.dmi'
		var/r = rand(1, 7)
		flick("[r]", o)
		var/obj/x = new /obj/undereffect(locate(dx, dy, dz))
		spawn(9)
			o.loc = null
			if(!x) return
			x.icon = 'icons/blood.dmi'
			var/v = rand(1,7)
			x.icon_state = "l[v]"
			spawn(600)
				x.loc = null