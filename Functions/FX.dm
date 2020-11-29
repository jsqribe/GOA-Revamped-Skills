obj
	dense
		density = 1

	overfx
		icon = 'icons/appear.dmi'
		density = 0
		layer = MOB_LAYER+1
		New()
			. = ..()
			spawn(4)
				loc = null

	overfx2
		icon = 'icons/appeartai.dmi'
		density = 0
		layer = MOB_LAYER+1
		New()
			. = ..()
			spawn(3)
				loc = null

	Poison_Poof
		icon = 'icons/poison2.dmi'
		icon_state = "cloud"
		layer = MOB_LAYER+2
		mouse_opacity = 0
		animate_movement = 0
		New()
			..()

			for(var/obj/Poison_Poof/X in loc)
				if(X != src)
					loc = null
					return

			spawn()
				src.underlays += image('icons/poison2.dmi', icon_state = "l", pixel_x = -32, layer = MOB_LAYER+2)
				src.underlays += image('icons/poison2.dmi', icon_state = "r", pixel_x = 32, layer = MOB_LAYER+2)
				src.underlays += image('icons/poison2.dmi', icon_state = "tr", pixel_y = 32, pixel_x = 16, layer = MOB_LAYER+2)
				src.underlays += image('icons/poison2.dmi', icon_state = "br", pixel_y = -32, pixel_x = 16, layer = MOB_LAYER+2)
				src.underlays += image('icons/poison2.dmi', icon_state = "tl", pixel_y = 32, pixel_x = -16, layer = MOB_LAYER+2)
				src.underlays += image('icons/poison2.dmi', icon_state = "bl", pixel_y = -32, pixel_x = -16, layer = MOB_LAYER+2)

obj/four_pillar
	icon = 'icons/four_pillar_binding.dmi'
	density = 1
	layer = MOB_LAYER
	New(location,way)
		..()
		icon_state = way
		flick("[way]_Rise",src)
		spawn(60) loc = null
obj/kazesand
	//icon = "icons/Kazesand.dmi"
	density = 1
	layer = MOB_LAYER

obj
	pp
		icon='icons/cubical_variant.dmi'
		layer=MOB_LAYER+1
		New()
			..()
			flick("flick",src)
obj
	ll
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		icon_state="state 1"
		pixel_x=-16
		New()
			..()
			flick("expand 1",src)
	xx
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		icon_state="state 2"
		pixel_x=16
		New()
			..()
			flick("expand 2",src)
	yy
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		icon_state="state 3"
		pixel_x=-16
		pixel_y=32
		New()
			..()
			flick("expand 3",src)
	zz
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		icon_state="state 4"
		pixel_x=16
		pixel_y=32
		New()
			..()
			flick("expand 4",src)
obj
	aa
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		pixel_x=-16
		New()
			..()
			flick("blast 1",src)
	ss
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		pixel_x=16
		New()
			..()
			flick("blast 2",src)
	ff
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		pixel_x=-16
		pixel_y=32
		New()
			..()
			flick("blast 3",src)
	dd
		icon='icons/cubical_variant2.dmi'
		layer=MOB_LAYER+1
		pixel_x=16
		pixel_y=32
		New()
			..()
			flick("blast 4",src)

obj
	expand
		var/list/youtube=new
		New()
			spawn()..()
			spawn()
				youtube+=new/obj/pp(locate(src.x,src.y,src.z))
	expansion
		var/list/google=new
		New()
			spawn()..()
			spawn()
				google+=new/obj/ll(locate(src.x,src.y,src.z))
				google+=new/obj/xx(locate(src.x,src.y,src.z))
				google+=new/obj/zz(locate(src.x,src.y,src.z))
				google+=new/obj/yy(locate(src.x,src.y,src.z))
		Del()
			for(var/obj/x in src.google)
				del(x)
			..()
	blast
		var/list/facebook=new
		New()
			spawn()..()
			spawn()
				facebook+=new/obj/aa(locate(src.x,src.y,src.z))
				facebook+=new/obj/ss(locate(src.x,src.y,src.z))
				facebook+=new/obj/dd(locate(src.x,src.y,src.z))
				facebook+=new/obj/ff(locate(src.x,src.y,src.z))


obj
	hspike
		density = 1
		layer = MOB_LAYER+1
		icon = 'icons/HakuSpikes.dmi'

proc
	Haku_Spikes(dx, dy, dz)
		var/obj/x1 = new /obj/hspike(locate(dx-1, dy+1, dz))
		var/obj/x2 = new /obj/hspike(locate(dx, dy+1, dz))
		var/obj/x3 = new /obj/hspike(locate(dx+1, dy+1, dz))
		var/obj/x4 = new /obj/hspike(locate(dx-1, dy, dz))
		var/obj/x5 = new /obj/hspike(locate(dx, dy, dz))
		var/obj/x6 = new /obj/hspike(locate(dx+1, dy, dz))
		var/obj/x7 = new /obj/hspike(locate(dx-1, dy-1, dz))
		var/obj/x8 = new /obj/hspike(locate(dx, dy-1, dz))
		var/obj/x9 = new /obj/hspike(locate(dx+1, dy-1, dz))

		x1.icon_state = "top-leftd"
		x2.icon_state = "top-midd"
		x3.icon_state = "top-rightd"
		x4.icon_state = "mid-leftd"
		x5.icon_state = "mid-midd"
		x6.icon_state = "mid-rightd"
		x7.icon_state = "bot-leftd"
		x8.icon_state = "bot-midd"
		x9.icon_state = "bot-rightd"

		flick("top-left", x1)
		flick("top-mid", x2)
		flick("top-right", x3)
		flick("mid-left", x4)
		flick("mid-mid", x5)
		flick("mid-right", x6)
		flick("bot-left", x7)
		flick("bot-mid", x8)
		flick("bot-right", x9)

		sleep(36)

		x1.loc = null
		x2.loc = null
		x3.loc = null
		x4.loc = null
		x5.loc = null
		x6.loc = null
		x7.loc = null
		x8.loc = null
		x9.loc = null

obj
	Bonespire
		var
			causer = 0
		icon = 'icons/sawarabi.dmi'
		layer = MOB_LAYER-0.1
		density = 1

		New(loc, mob/human/cause)
			..()

			var/conbuff = 1

			if(cause)
				conbuff = cause.ControlDamageMultiplier()

			spawn(1)
				src.icon_state = "fin"
				flick("flick", src)

				for(var/mob/human/player/X in loc)
					if(!X.icon_state)
						flick("hurt", X)
					X.Damage(round(rand(2000, 3000) + rand(700,700) * conbuff), 10, cause, "Bonespire", "Normal")
					X.Hostile(cause)
					spawn() Blood2(X)
					X.Timed_Move_Stun(30)

				sleep(400)
				src.loc = null

proc
	SpireCircle(bx, by, bz, finrad, mob/cause)
		var/rad = 0
		var/rad2 = 0
		var/nx = bx
		var/ny = by
		var/nx2 = bx
		var/list/listx = new()
		var/nx3 = bx
		var/nx4 = bx

		while(rad < finrad)
			rad += 2
			rad2 += 1
			nx = bx + rad
			nx2 = bx + rad2
			nx3 = bx - rad
			nx4 = bx - rad2
			var/diff = 0
			var/diff2 = 1

			spawn()
				var/mx2 = nx2

				if(rad2 == 1)
					listx += new /obj/Bonespire(locate(bx, ny+rad2, bz), cause)
					listx += new /obj/Bonespire(locate(bx, ny-rad2, bz), cause)
				else
					listx += new /obj/Bonespire(locate(bx, ny+rad2-1, bz), cause)
					listx += new /obj/Bonespire(locate(bx, ny-rad2+1, bz), cause)

				while(mx2 > bx)
					listx += new /obj/Bonespire(locate(mx2, ny-diff2, bz), cause)
					listx += new /obj/Bonespire(locate(mx2, ny+diff2, bz), cause)

					mx2 -= 2
					diff2 += 2

			spawn()
				var/mx = nx
				while(mx > bx)
					if(diff)
						listx += new /obj/Bonespire(locate(mx, ny+diff, bz), cause)
						listx += new /obj/Bonespire(locate(mx, ny-diff, bz), cause)

					mx -= 2
					diff += 2

			var/diff3 = 0
			var/diff4 = 1

			spawn()
				var/mx2 = nx4

				if(rad2 == 1)
					listx += new /obj/Bonespire(locate(bx+rad2, ny, bz), cause)
					listx += new /obj/Bonespire(locate(bx-rad2, ny, bz), cause)
				else
					listx += new /obj/Bonespire(locate(bx+rad2-1, ny, bz), cause)
					listx += new /obj/Bonespire(locate(bx-rad2+1, ny, bz), cause)

				while(mx2 < bx)
					listx += new /obj/Bonespire(locate(mx2, ny+diff4, bz), cause)
					listx += new /obj/Bonespire(locate(mx2, ny-diff4, bz), cause)
					mx2 += 2
					diff4 += 2

			spawn()
				var/mx = nx3
				while(mx < bx)
					if(diff3)
						listx += new /obj/Bonespire(locate(mx, ny+diff3, bz), cause)
						listx += new /obj/Bonespire(locate(mx, ny-diff3, bz), cause)

					mx += 2
					diff3 += 2

			rad2 += 1
			sleep(5)

		for(var/obj/Bonespire/E in listx)
			E.causer = cause


obj
	Magnetthing
		var
			causer = 0
		icon = 'icons/sawarabi2.dmi'
		layer = MOB_LAYER-0.1
	//	density = 1

		New(loc, mob/human/cause)
			..()

		//	var/conbuff = 1

			/*if(cause)
				conbuff = cause.ControlDamageMultiplier()*/

			spawn(1)
				src.icon_state = "fin"
				flick("flick", src)

				for(var/mob/human/player/X in loc)
					if(!X.icon_state)
						flick("hurt", X)
					X.Poison+=rand(4,8)
					X.movepenalty=25
					X.Hostile(cause)
					spawn() Blood2(X)
					X.Timed_Move_Stun(30)

				sleep(400)
				src.loc = null

proc
	MagnetWorld(bx, by, bz, finrad, mob/cause)
		var/rad = 0
		var/rad2 = 0
		var/nx = bx
		var/ny = by
		var/nx2 = bx
		var/list/listx = new()
		var/nx3 = bx
		var/nx4 = bx

		while(rad < finrad)
			rad += 2
			rad2 += 1
			nx = bx + rad
			nx2 = bx + rad2
			nx3 = bx - rad
			nx4 = bx - rad2
			var/diff = 0
			var/diff2 = 1

			spawn()
				var/mx2 = nx2

				if(rad2 == 1)
					listx += new /obj/Magnetthing(locate(bx, ny+rad2, bz), cause)
					listx += new /obj/Magnetthing(locate(bx, ny-rad2, bz), cause)
				else
					listx += new /obj/Magnetthing(locate(bx, ny+rad2-1, bz), cause)
					listx += new /obj/Magnetthing(locate(bx, ny-rad2+1, bz), cause)

				while(mx2 > bx)
					listx += new /obj/Magnetthing(locate(mx2, ny-diff2, bz), cause)
					listx += new /obj/Magnetthing(locate(mx2, ny+diff2, bz), cause)

					mx2 -= 2
					diff2 += 2

			spawn()
				var/mx = nx
				while(mx > bx)
					if(diff)
						listx += new /obj/Magnetthing(locate(mx, ny+diff, bz), cause)
						listx += new /obj/Magnetthing(locate(mx, ny-diff, bz), cause)

					mx -= 2
					diff += 2

			var/diff3 = 0
			var/diff4 = 1

			spawn()
				var/mx2 = nx4

				if(rad2 == 1)
					listx += new /obj/Magnetthing(locate(bx+rad2, ny, bz), cause)
					listx += new /obj/Magnetthing(locate(bx-rad2, ny, bz), cause)
				else
					listx += new /obj/Magnetthing(locate(bx+rad2-1, ny, bz), cause)
					listx += new /obj/Magnetthing(locate(bx-rad2+1, ny, bz), cause)

				while(mx2 < bx)
					listx += new /obj/Magnetthing(locate(mx2, ny+diff4, bz), cause)
					listx += new /obj/Magnetthing(locate(mx2, ny-diff4, bz), cause)
					mx2 += 2
					diff4 += 2

			spawn()
				var/mx = nx3
				while(mx < bx)
					if(diff3)
						listx += new /obj/Magnetthing(locate(mx, ny+diff3, bz), cause)
						listx += new /obj/Magnetthing(locate(mx, ny-diff3, bz), cause)

					mx += 2
					diff3 += 2

			//rad2 += 1
			sleep(5)

		for(var/obj/Magnetthing/E in listx)
			E.causer = cause



obj
	Testspire
		icon = 'icons/sawarabi.dmi'
		icon_state = "fin"


mob/human
	dog
		var/hp=100
		var/tired=0
		density=1
		icon='icons/dog.dmi'
		icon_state=""

		New()
			spawn()
				src.nopkloop()
		proc
			P_Attack(mob/human/etarget,mob/human/owner)
				if(tired)return
				tired=1
				spawn(30)
					tired=0
				for(var/mob/human/x in oview(7,src))
					if(x==etarget)
						walk_to(src,x,1,1)
						sleep(1)
						var/hit=0
						if(get_dist(src,x)<=1)hit=1
						else
							sleep(1)
						if(get_dist(src,x)<=1)hit=1
						else
							sleep(1)
						if(get_dist(src,x)<=1)hit=1
						else
							sleep(1)
						if(hit)
							spawn(9)
								src.density=0
								walk_to(src,owner,0,1)
								sleep(6)
								src.density=1
								walk(src,0)
							etarget.Dec_Stam(src.str*rand(100,200)/150)
							if(!etarget.icon_state)
								flick("hurt",etarget)
							etarget.Hostile(owner)

		Del()
			src.invisibility=99
			src.density=0
			src.loc=locate(0,0,0)
			sleep(100)
			..()

		Dec_Stam(x,xpierce,mob/attacker, hurtall,taijutsu, internal)
			return
		Wound(x,xpierce, mob/attacker, reflected)
			return

mob/human
	sandmonster
		var/hp = 50
		var/tired = 0
		var/ownerkey
		var/owner

		density = 1
		icon = 'icons/gaarasand.dmi'
		icon_state = ""
		show_name = 0
		pk = 1
		//icon = 'sandblob.dmi'
		//pixel_x = -32
		//pixel_y = -32
		animate_movement = SLIDE_STEPS
		layer = MOB_LAYER + 0.1

		New()
			..()
			src.ownerkey = usr.key
			src.underlays += image('icons/sand-up.dmi', pixel_y = -10)
			src.underlays += image('icons/sand-down.dmi', pixel_y = 10)
			src.underlays += image('icons/sand-right.dmi', pixel_x = -10)
			src.underlays += image('icons/sand-left.dmi', pixel_x = 10)
			loc = usr.loc

		Move(location,direction)

			loc = location
			dir = direction

			if(usr)
				if(usr.z != z)
					loc = usr.loc


			if(!usr)
				del src

		proc
			P_Attack(mob/human/etarget, mob/human/owner)
				if(tired) return
				//world.log << "[src]"

				tired = 1

				if(etarget in oview(4, src))
					var/hit = 0
					var/allowed_dist = 2
					while(allowed_dist > 0 && get_dist(src, etarget) > 1)
						src.icon_state="attack"
						step_towards(src, etarget, 1)
						allowed_dist--
						sleep(2)
					if(get_dist(src, etarget) <= 1)
						hit = 1

					if(hit)
						etarget.Knockback(1, dir)

						spawn(1)
							src.icon_state=""
							src.density = 0
							walk_to(src, owner, 0, 1)
							sleep(6)
							src.density = 1
							walk(src, 0)

						etarget.Damage(src.con * rand(50, 150) / 100, 0, owner, "Sand Mass", "Normal")
						if(!etarget.icon_state)
							flick("hurt", etarget)
						etarget.Hostile(owner)
				spawn(15) tired = 0

		Del()
			//src.invisibility = 99
			//src.density = 0
			//src.loc = locate(0, 0, 0)
			//sleep(100)
			..()

		Dec_Stam()
			return

		Wound()
			return

mob/proc/nopkloop() //Dipic: Unused as it's dumb
	while(src && loc)
		var/area/A = loc.loc
		if(!A.pkzone)
			del(src)
		sleep(10)

obj/gatesaura
	icon = 'icons/gateaura.dmi'
	bl
		icon_state = "bl"
		pixel_x = -16
	br
		icon_state = "br"
		pixel_x = 16
	tl
		icon_state = "tl"
		pixel_x = -16
		pixel_y = 32
	tr
		icon_state = "tr"
		pixel_x = 16
		pixel_y = 32

obj/oodamaexplosion
	layer = OBJ_LAYER

	New()
		src.overlays += image('icons/oodamahit.dmi', icon_state = "bl", pixel_x = -16, pixel_y = -16)
		src.overlays += image('icons/oodamahit.dmi', icon_state = "br", pixel_x = 16, pixel_y = -16)
		src.overlays += image('icons/oodamahit.dmi', icon_state = "tl", pixel_x = -16, pixel_y = 16)
		src.overlays += image('icons/oodamahit.dmi', icon_state = "tr", pixel_x = 16, pixel_y = 16)

obj/oodamarasengan
	icon='icons/oodamarasengan.dmi'
	icon_state="rasengan"

	New()
		flick("create", src)

obj/rasengan
	icon = 'icons/rasengan.dmi'
	icon_state = "rasengan"
	New()
		flick("create", src)



mob/proc/Affirm_Icon_Ret()
	if(istype(src, /mob/human/Puppet/Karasu))
		return
	switch(icon_name)
		if("base_m", "base_m1")
			return new /icon('icons/base_m1.dmi')

		if("base_m2")
			return new /icon('icons/base_m2.dmi')

		if("base_m3")
			return new /icon('icons/base_m3.dmi')

	if(usr.key=="Luis455"/* && src.realname=="Shimura Danzo"*/)
		switch(src.icon_name)
			if("base_m", "base_m1")
				icon='icons/base_m1_danzou.dmi'
			if("base_m2")
				icon='icons/base_m2_danzou.dmi'

	if(usr.kyuubi)
		switch(src.icon_name)
			if("base_m", "base_m1", "base_m2")
				return new /icon('New/summon Kurama Kyuubi 9 tails.dmi', pixel_x=-32, pixel_y=-32)


	if(src.danzo)
		switch(src.icon_name)
			if("base_m", "base_m1")
				icon='icons/base_m1_danzou.dmi'
			if("base_m2")
				icon='icons/base_m2_danzou.dmi'
			if("base_m3")
				icon='icons/base_m3_danzou.dmi'
			if("base_m4")
				icon='icons/base_m4_danzou.dmi'
			if("base_m5")
				icon='icons/base_m5_danzou.dmi'
			if("base_m6")
				icon='icons/base_m6_danzou.dmi'
			if("base_m7")
				icon='icons/base_m7_danzou.dmi'

mob/proc/Affirm_Icon()
	//world.log << "called" ah this is for debug, I got worried thinking something broke xD
	if(src.Size || src.Tank || src.mole)
		return
	if(istype(src, /mob/human/Puppet/Karasu))
		return

/*	if(shukaku_cloak)
		src.overlays+=/obj/special/shukaku_cloak
	else if(!shukaku_cloak)
		src.overlays-=/obj/special/shukaku_cloak*/
	if(sage_mode)
		src.overlays+=/obj/special/sage_mode
	else if(!sage_mode)
		src.overlays-=/obj/special/sage_mode
	if(lightning_armor==1)
		src.overlays+=/obj/special/lightning_armor
	else if(lightning_armor!=1)
		src.overlays-=/obj/special/lightning_armor
	if(lightning_armor==2)
		src.overlays+=/obj/special/lightning_armor_2nd
	else if(lightning_armor!=2)
		src.overlays-=/obj/special/lightning_armor_2nd
	if(human_puppet==2)
		src.overlays+=/obj/special/humanpuppet
	else if(human_puppet!=2)
		src.overlays-=/obj/special/humanpuppet
	if(human_puppet==2)
		src.overlays+=/obj/special/humanpuppet2
	else if(human_puppet!=2)
		src.overlays-=/obj/special/humanpuppet2
	if(curse_seal)
		src.overlays+=/obj/special/curse_seal
	else if(!curse_seal)
		src.overlays-=/obj/special/curse_seal
	if(papermode)
		src.overlays+=/obj/special/paper_mode
	else if(!papermode)
		src.overlays-=/obj/special/paper_mode
/*	if(paper_mode)
		src.overlays+=/obj/special/paper_mode/p1
		src.overlays+=/obj/special/paper_mode/p2
		src.overlays+=/obj/special/paper_mode/p3
		src.overlays+=/obj/special/paper_mode/p4
		src.overlays+=/obj/special/paper_mode/p5
		src.overlays+=/obj/special/paper_mode/p6
		src.overlays+=/obj/special/paper_mode/p7
		src.overlays+=/obj/special/paper_mode/p8
	else if(!paper_mode)
		src.overlays-=/obj/special/paper_mode/p1
		src.overlays-=/obj/special/paper_mode/p2
		src.overlays-=/obj/special/paper_mode/p3
		src.overlays-=/obj/special/paper_mode/p4
		src.overlays-=/obj/special/paper_mode/p5
		src.overlays-=/obj/special/paper_mode/p6
		src.overlays-=/obj/special/paper_mode/p7
		src.overlays-=/obj/special/paper_mode/p8*/
/*	if(curse_seal==3)
		src.overlays+=/obj/special/curse_seal_3
	else if(!curse_seal==3)
		src.overlays-=/obj/special/curse_seal_3*/
	if(beast_mode)
		src.overlays+=/obj/special/beast_mode
	else if(!beast_mode)
		src.overlays-=/obj/special/beast_mode

	var/icon
	switch(src.icon_name)
		if("base_m", "base_m1")
			icon = 'icons/base_m1.dmi'
		if("base_m2")
			icon = 'icons/base_m2.dmi'
		if("base_m3")
			icon = 'icons/base_m3.dmi'

	if(src.key == "Luis455" && src.name == "Shimura -E-")
		icon = 'base_m1_danzou.dmi'

	if(src.gate >= 3)
		icon = 'icons/base_m_gates.dmi'

	else if(src.camo || src.hiddenmist)
		icon = 'icons/base_invisible.dmi'

	else if(src.ironskin)
		icon = 'icons/base_m_stoneskin.dmi'

	else if(src.human_puppet==1)
		icon='icons/Sasori.dmi'

	else if(src.human_puppet==2)
		icon='icons/Sasor puppet.dmi'

	if(istype(src,/mob/human/player/npc/creep))
		icon = 'summon White Zetsu.dmi'

	else if(src.danzo)
		switch(src.icon_name)
			if("base_m", "base_m1")
				icon='icons/base_m1_danzou.dmi'
			if("base_m2")
				icon='icons/base_m2_danzou.dmi'
			if("base_m3")
				icon='icons/base_m3_danzou.dmi'
			if("base_m4")
				icon='icons/base_m4_danzou.dmi'
			if("base_m5")
				icon='icons/base_m5_danzou.dmi'
			if("base_m6")
				icon='icons/base_m6_danzou.dmi'
			if("base_m7")
				icon='icons/base_m7_danzou.dmi'

	if(src.sharingan || src.impsharingan)
		var/icon/i = new(icon)
		i.SwapColor(rgb(007,007,007),rgb(180,0,0))
		i.SwapColor(rgb(93,95,93),rgb(220,50,50))
		icon = i

	if(src.byakugan || src.impbyakugan)
		var/icon/i = new(icon)
		i.SwapColor(rgb(007,007,007),rgb(255,255,255))
		i.SwapColor(rgb(93,95,93),rgb(248,219,218))
		icon = i

	if(src.key=="Luis455")
		var/icon/i = new(icon)
		i.SwapColor(rgb(007,007,007),rgb(000,033,187))
		i.SwapColor(rgb(93,95,93),rgb(023,070,255))
		icon = i

	if(src.scalpol)
		src.overlays += 'icons/chakrahands.dmi'

	src.icon = icon

obj
	special
		layer = FLOAT_LAYER - 13
		sharingan
			icon = 'icons/sharingan.dmi'
		byakugan
			icon = 'icons/byakugan.dmi'
		impbyakugan
			icon = 'icons/impbyakugan.dmi'
		beast_mode
			icon='icons/BeastMode.dmi'
		shukaku_cloak
			icon='icons/Shukaku_Cloak.dmi'
		sage_mode
			icon='icons/sageeye.dmi'
		lightning_armor
			layer=MOB_LAYER+10
			icon='icons/lightningarmor.dmi'
		lightning_armor_2nd
			layer=MOB_LAYER+10
			icon='icons/lightningarmor_2nd_state.dmi'
		humanpuppet
			layer=MOB_LAYER+10
			icon='icons/Sasor puppet over 1.dmi'
			pixel_x=-32
		humanpuppet2
			layer=MOB_LAYER+10
			icon='icons/Sasor puppet over 2.dmi'
			pixel_y=32
		curse_seal
			icon='icons/Cs lvl 1.dmi'
		curse_seal_3
			icon='icons/CS Aura.dmi'
		paper_mode
			layer=MOB_LAYER+10
			icon='New/paperwing.dmi'
			pixel_y=-48
			pixel_x=-48

turf/water
	icon = 'icons/water.dmi'
	density = 0
	layer = TURF_LAYER + 1

	still
		icon_state = "still"

	moveing
		icon_state = "move"

	water_sides
		tl
			icon_state = "tl"
		tr
			icon_state = "tr"
		bl
			icon_state = "bl"
		br
			icon_state = "br"

	Del()
		for(var/obj/haku_ice/ice in src)
			ice.loc = null
		..()

obj/windblast
	layer = MOB_LAYER
	projdisturber = 1
	icon = 'icons/windblast.dmi'
	density = 0
	wplus
		icon_state = "x+1"
	wminus
		icon_state = "x-1"
	windtrail
		icon_state = "trail"




mob/var/tmp
	obj/Contract = null
	mob/human/player/Contract2 = null
	ContractBy[]

proc/Poof(dx, dy, dz)
	spawn()
		var/obj/o = new/obj/effect(locate(dx, dy, dz))
		o.icon = 'icons/smoke.dmi'
		o.step_size = 32
		spawn(8)
			o.loc = null




obj/entertrigger/poisonsmoke
	icon = 'icons/smoke2.dmi'
	icon_state = "poison"
	pixel_x = -32
	pixel_y = -32
	layer = 6.1
	step_size = 32
	var/tmp/mob/human/muser

	New()
		..()

	SteppedOn(mob/human/player/M)
		if(istype(M,/mob/human/player) && M.client && !M.ko && !M.IsProtected())
			M.Poison += 1 + muser.skillspassive[23]*0.25
			//M.combat("You have been affected by posion")
			//world << "Affected Mob([M.x],[M.y]) by Object([src.x],[src.y])"
			spawn() M.Timed_Move_Stun(10) //lags out?
			M.Hostile(muser)
			M.Damage(200,0,muser,"Medical: Poison Mist","Normal")


obj/smoke
	icon = 'icons/smoke2.dmi'
	icon_state = "smoke"
	pixel_x = -32
	pixel_y = -32
	layer = 6.1
	mouse_opacity = 0
	var/ignited = 0
	proc
		Ignite(obj/smoke/smoke,turf/aloc)
			smoke.step_size = 32
			smoke.ignited = 1
			smoke.icon_state = ""
			flick("ignition",smoke)
			//snd(src,'sounds/explosion_fire.wav',vol=10)
			var/mob/human/attacker = owner
			for(var/mob/M in loc)
				spawn()
					M = M.Replacement_Start(attacker)
					M.Damage(round(rand(1000,2000)+rand(200,300)*attacker.ControlDamageMultiplier()),round(rand(1,4)*attacker.ControlDamageMultiplier()),attacker,"Fire: Ash Burning Product","Normal")
					M.Hostile(attacker)
					spawn(5) if(M) M.Replacement_End()
			spawn()
				for(var/obj/smoke/s in view(1,smoke))
					if(!s.ignited)
						if(aloc) s.FaceTowards(aloc)
						s.Ignite(s,aloc)
					sleep(1)
			spawn()
				for(var/mob/m in view(1,smoke))
					m.Timed_Stun(5)
			spawn(5) smoke.loc=null

proc/AshSmoke(mob/human/user, dx, dy, dz, direction)
	var/obj/smoke/o = new/obj/smoke(locate(dx, dy, dz))
	o.owner = user
	o.step_size = 32
	spawn(120) if(o) o.loc = null
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


mob/verb/Sm()
	if(ckey in admins)
		var/s = input("What radius size?") as num
		var/f = input("How far (1,2,3)?") as num
		var/t = input("What type (ash, poison)?")
		SmokeSpread(usr.loc, type=t, size=s, delay=2, far=f)



mob/var/tmp/backupoverlays
mob/var/tmp/backupicon
mob/var/tmp/is_hidden_in_mist
mob/proc/HideInMist()
	//world<<"[usr] hides in mist [usr.hiddenmist]"
	if(!usr.hiddenmist) return
	usr.backupicon=usr.icon
	usr.backupoverlays=usr.overlays.Copy()
	usr.icon='icons/base_invisible.dmi'
	usr.overlays=0
	usr.is_hidden_in_mist=1
	usr.Affirm_Icon()
	usr.Load_Overlays()
	for(var/mob/human/H in usr.targeted_by)
		H.RemoveTarget(usr)
		H.AddTarget(usr, active=0, silent=1)


mob/proc/UnHideInMist()
	//world<<"[usr] unhides from mist [usr.hiddenmist]"
	usr.hiddenmist=0
	if(usr.is_hidden_in_mist||usr.icon=='icons/base_invisible.dmi')
		if(usr.backupicon)
			usr.icon=usr.backupicon
		if(usr.icon=='icons/base_invisible.dmi')
			usr.icon='icons/base_m1.dmi'//incase of weird things happening
		if(usr.backupoverlays)
			usr.overlays=usr.backupoverlays
		usr.Affirm_Icon()
		usr.Load_Overlays()
		usr.is_hidden_in_mist=0



obj/mistobj
	icon = 'icons/mist.dmi'
	icon_state = ""
	pixel_x = -8
	pixel_y = -8
	layer = 6.2
	mouse_opacity = 0
	var/tmp/mob/human/muser
	New()
		..()
		spawn()
			if(muser in src.loc)
				muser.hiddenmist=1
				muser.HideInMist()
		spawn(200)
			if(muser)
				muser.hiddenmist=0
				muser.UnHideInMist()
			loc = null

	proc/spread(turf/source, size=3, delay=2)
		var/list/dirs = list(NORTH,,EAST,SOUTH,WEST,NORTHWEST,NORTHEAST,SOUTHEAST,SOUTHWEST)
		for(var/xdir in dirs)
			var/doit = 1
			for(var/obj/mistobj/mo in get_step(src,xdir))
				if(mo.muser == src.muser) doit = 0
			if(doit)
				var/obj/mistobj/mist = new/obj/mistobj(src.loc)
				mist.muser = src.muser
				var/stepcheck = step(mist, xdir)
				if(stepcheck)
					if(size > get_dist(mist,source)) spawn(delay) mist.spread(source, size=size, delay=delay)
					sleep(1)
				else
					mist.loc = null



obj/floor
	icon = 'flooc.dmi'
	icon_state = ""
	mouse_opacity = 0
	var/tmp/mob/human/muser
	New()
		..()
		spawn(200)
			if(muser in src.loc)
				muser.hiddenmist=1
				muser.HideInMist()
			loc = null
	proc/spread3(turf/source, size=3, delay=2)
		var/list/dirs = list(NORTH,,EAST,SOUTH,WEST,NORTHWEST,NORTHEAST,SOUTHEAST,SOUTHWEST)
		for(var/xdir in dirs)
			var/doit = 1
			for(var/obj/floor/mo in get_step(src,xdir))
				if(mo.muser == src.muser) doit = 0
			if(doit)
				var/obj/floor/flo = new/obj/floor(src.loc)
				flo.muser = src.muser
				var/stepcheck = step(flo, xdir)
				if(stepcheck)
					if(size > get_dist(flo,source)) spawn(delay) flo.spread3(source, size=size, delay=delay)
					sleep(1)
				else
					flo.loc = null


obj/petalobj
	icon = 'icons/petal_dance.dmi'
	icon_state = ""
	screen_loc = "1,1 to 17,17"
	layer = 99999999999999
	client.view

obj/redobj
	icon = 'icons/red.dmi'
	icon_state = ""
	screen_loc = "1,1 to 17,17"
	layer = 99999999999999
	client.view

obj/swup
	icon = 'icons/swamp.dmi'
	icon_state = "up"
	pixel_y = 32

mob/verb/Mi()
	if(ckey in admins)
		var/s = input("What radius size?") as num
		var/d = input("What delay?") as num
		MistSpread(usr, usr.loc, size=s, delay=d)
proc/MistSpread(mob/user, turf/source, size=3, delay=2)
	var/obj/mistobj/mist = new/obj/mistobj(source)
	mist.muser = user
	mist.spread(source, size, delay)



proc/FloorField(mob/human/user, turf/source, size=3, delay=2)
	var/obj/floor/flo = new/obj/floor(source)
	flo.muser = user
	flo.spread3(source, size, delay)




obj/jashin_circle
	layer = OBJ_LAYER + 0.9
	density = 0
	icon = 'icons/jashinsymbol.dmi'



proc/ChidoriFX(mob/human/o)
	var/obj/c = new/obj/effect()
	o.icon_state = "PunchA-2"
	c.icon = 'icons/chidori2.dmi'
	switch(o.dir)
		if(NORTH)
			c.pixel_y += 22
		if(SOUTH)
			c.pixel_y -= 22
		if(EAST)
			c.pixel_x += 22
		if(WEST)
			c.pixel_x -= 22

	o.overlays += c

	spawn(20)
		o.overlays -= c
		c.loc = null
		o.icon_state = ""

obj/ForcePressure
	icon = 'icons/wind.dmi'
	layer = MOB_LAYER + 1
	density = 0

	New(loc, dirx)
		..()
		dir = dirx

		spawn(20) src.loc = null

proc/Force_pressure(dx, dy, dz, obj/O)
	var/Odir = NORTH
	if(O) Odir = O.dir
	sleep(3)
	var/obj/X = new /obj/ForcePressure(locate(dx, dy, dz), Odir)
	if(X) X.dir = Odir

obj
	var
		list/parts = new
		spawner = 0
		list/Pwned = new
		center_x
		center_y
	multipart
		Pressure
			PEAST
				icon = 'icons/pressure.dmi'
				center_x = 2
				center_y = 1
				spawner = 1
				dir = EAST
				density = 0
				layer = MOB_LAYER+2
			PWEST
				icon = 'icons/pressure.dmi'
				center_x = 0
				center_y = 1
				spawner = 1
				dir = WEST
				density = 0
				layer = MOB_LAYER+2
			PSOUTH
				icon = 'icons/pressure.dmi'
				center_x = 1
				center_y = 0
				spawner = 1
				dir = SOUTH
				density = 0
				layer = MOB_LAYER+2
			PNORTH
				icon = 'icons/pressure.dmi'
				center_x = 1
				center_y = 2
				spawner = 1
				dir = NORTH
				density = 0
				layer = MOB_LAYER+2

			Move()
				spawn() Force_pressure(src.x, src.y, src.z, src)
				return ..()

		Del()
			if(src.spawner)
				for(var/obj/X in src.parts)
					if(X != src)
						X.loc = null
			..()

		New(loc, spawnr)
			..()

			if(spawnr)
				src.spawner = 1
			else
				src.spawner=0

			if(!src.spawner)
				return 1

			var/icon/I = new(icon)

			pixel_x = -((I.Width()-world.IconSizeX())/2)
			pixel_y = -((I.Height()-world.IconSizeY())/2)

			parts += src

			var/tiles_x = -round(-(I.Width() / world.IconSizeX()))
			var/tiles_y = -round(-(I.Height() / world.IconSizeY()))

			for(var/tile_x in 0 to (tiles_x-1))
				for(var/tile_y in 0 to (tiles_y-1))
					var/offset_x = tile_x - center_x
					var/offset_y = tile_y - center_y

					if(offset_x == 0 && offset_y == 0)
						continue

					var/obj/multipart/X = new type(locate(x + offset_x, y + offset_y, z), 0)
					X.icon = null
					X.dir = dir
					parts += X

			for(var/obj/X in src.parts)
				if(X != src)
					X.parts = src.parts

		Move()
			if(src.spawner)
				var/blocked = 0
				for(var/obj/X in src.parts)
					var/atom/Ox = get_step(X, X.dir)
					if(!Ox || !Ox.Enter(X))
						blocked++
				var/turf/T = get_step(src, src.dir)
				if(!T || T.density)
					return 0

				if(!blocked)
					for(var/obj/X in src.parts)
						if(X != src)
							spawn() step(X, X.dir)
					for(var/mob/X in src.Pwned)
					//	if(abs(X.x-src.x)<4 && abs(X.y-src.y)<4)
						spawn() if(X) X.loc = locate(src.x, src.y, src.z)

			return ..()


obj/ForceJinton
	icon = 'icons/JintonTail.dmi'
	layer = MOB_LAYER + 1
	density = 0

	New(loc, dirx)
		..()
		dir = dirx

		spawn(20) src.loc = null

proc/Force_Jinton(dx, dy, dz, obj/O)
	var/Odir = NORTH
	if(O) Odir = O.dir
	sleep(3)
	var/obj/X = new /obj/ForceJinton(locate(dx, dy, dz), Odir)
	if(X) X.dir = Odir

obj
	var
		list/parts2 = new
		spawner2 = 0
		list/Pwned2 = new
		center2_x
		center2_y
	multiparts2
		Jinton
			PEAST
				icon = 'icons/JintonBlast.dmi'
				center2_x = 2
				center2_y = 1
				spawner2 = 1
				dir = EAST
				density = 0
				layer = MOB_LAYER+2
			PWEST
				icon = 'icons/JintonBlast.dmi'
				center2_x = 0
				center2_y = 1
				spawner2 = 1
				dir = WEST
				density = 0
				layer = MOB_LAYER+2
			PSOUTH
				icon = 'icons/JintonBlast.dmi'
				center2_x = 1
				center2_y = 0
				spawner2 = 1
				dir = SOUTH
				density = 0
				layer = MOB_LAYER+2
			PNORTH
				icon = 'icons/JintonBlast.dmi'
				center2_x = 1
				center2_y = 2
				spawner2 = 1
				dir = NORTH
				density = 0
				layer = MOB_LAYER+2

			Move()
				spawn() Force_Jinton(src.x, src.y, src.z, src)
				return ..()

		Del()
			if(src.spawner2)
				for(var/obj/X in src.parts2)
					if(X != src)
						X.loc = null
			..()

		New(loc, spawnr)
			..()

			if(spawnr)
				src.spawner2 = 1
			else
				src.spawner2=0

			if(!src.spawner2)
				return 1

			var/icon/I = new(icon)

			pixel_x = -((I.Width()-world.IconSizeX())/2)
			pixel_y = -((I.Height()-world.IconSizeY())/2)

			parts2 += src

			var/tiles_x = -round(-(I.Width() / world.IconSizeX()))
			var/tiles_y = -round(-(I.Height() / world.IconSizeY()))

			for(var/tile_x in 0 to (tiles_x-1))
				for(var/tile_y in 0 to (tiles_y-1))
					var/offset_x = tile_x - center2_x
					var/offset_y = tile_y - center2_y

					if(offset_x == 0 && offset_y == 0)
						continue

					var/obj/multiparts2/X = new type(locate(x + offset_x, y + offset_y, z), 0)
					X.icon = null
					X.dir = dir
					parts2 += X

			for(var/obj/X in src.parts2)
				if(X != src)
					X.parts2 = src.parts2

		Move()
			if(src.spawner2)
				var/blocked = 0
				for(var/obj/X in src.parts2)
					var/atom/Ox = get_step(X, X.dir)
					if(!Ox || !Ox.Enter(X))
						blocked++
				var/turf/T = get_step(src, src.dir)
				if(!T || T.density)
					return 0

				if(!blocked)
					for(var/obj/X in src.parts2)
						if(X != src)
							spawn() step(X, X.dir, 96)
					for(var/mob/X in src.Pwned2)
					//	if(abs(X.x-src.x)<4 && abs(X.y-src.y)<4)
						spawn() if(X) X.loc = locate(src.x, src.y, src.z)

			return ..()


	Gustfx
		density = 0
		icon = 'icons/gust.dmi'
		projdisturber = 1
	InsectGustfx
		density=0
		icon='icons/bug_gust.dmi'
		projdisturber=1


// TODO: This proc needs cleanup badly too.
proc/Gust(dx,dy,dz,xdir,mag,xdist)
	var/list/xlist[]=new()
	if(mag==1)
		if(xdir==NORTH||xdir==SOUTH)
			xlist+=new/obj/Gustfx(locate(dx,dy,dz))
		if(xdir==EAST||xdir==WEST)
			xlist+=new/obj/Gustfx(locate(dx,dy,dz))

	if(mag==2)
		if(xdir==NORTH||xdir==SOUTH)
			xlist+=new/obj/Gustfx(locate(dx,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx+1,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx-1,dy,dz))
		if(xdir==EAST||xdir==WEST)
			xlist+=new/obj/Gustfx(locate(dx,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx,dy+1,dz))
			xlist+=new/obj/Gustfx(locate(dx,dy-1,dz))
	if(mag==3)
		if(xdir==NORTH||xdir==SOUTH)
			xlist+=new/obj/Gustfx(locate(dx,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx+1,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx+2,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx-1,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx-2,dy,dz))
		if(xdir==EAST||xdir==WEST)
			xlist+=new/obj/Gustfx(locate(dx,dy,dz))
			xlist+=new/obj/Gustfx(locate(dx,dy+1,dz))
			xlist+=new/obj/Gustfx(locate(dx,dy-1,dz))
			xlist+=new/obj/Gustfx(locate(dx,dy+2,dz))
			xlist+=new/obj/Gustfx(locate(dx,dy-2,dz))

	for(var/obj/Gustfx/o in xlist)
		spawn()
			o.dir=xdir
			o.icon_state="blow"
			walk(o,o.dir)
			sleep(xdist)
			walk(o,0)
			o.loc = null
	//del(xlist)

proc/InsectGust(dx,dy,dz,xdir,mag,xdist)
	var/list/xlist[]=new()
	if(mag==1)
		if(xdir==NORTH||xdir==SOUTH)
			xlist+=new/obj/InsectGustfx(locate(dx,dy,dz))
		if(xdir==EAST||xdir==WEST)
			xlist+=new/obj/InsectGustfx(locate(dx,dy,dz))

	if(mag==2)
		if(xdir==NORTH||xdir==SOUTH)
			xlist+=new/obj/InsectGustfx(locate(dx,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx+1,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx-1,dy,dz))
		if(xdir==EAST||xdir==WEST)
			xlist+=new/obj/InsectGustfx(locate(dx,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx,dy+1,dz))
			xlist+=new/obj/InsectGustfx(locate(dx,dy-1,dz))
	if(mag==3)
		if(xdir==NORTH||xdir==SOUTH)
			xlist+=new/obj/InsectGustfx(locate(dx,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx+1,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx+2,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx-1,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx-2,dy,dz))
		if(xdir==EAST||xdir==WEST)
			xlist+=new/obj/InsectGustfx(locate(dx,dy,dz))
			xlist+=new/obj/InsectGustfx(locate(dx,dy+1,dz))
			xlist+=new/obj/InsectGustfx(locate(dx,dy-1,dz))
			xlist+=new/obj/InsectGustfx(locate(dx,dy+2,dz))
			xlist+=new/obj/InsectGustfx(locate(dx,dy-2,dz))

	for(var/obj/InsectGustfx/o in xlist)
		spawn()
			o.dir=xdir
			o.icon_state="blow"
			walk(o,o.dir)
			sleep(xdist)
			walk(o,0)
			del(o)
	sleep(1)
	del(xlist)

obj/FireWavefx
	density = 0
	icon = 'icons/coiling_flames.dmi'
	layer = MOB_LAYER+1
	pixel_x = -64
	pixel_y = -64

proc/FireWave(dx,dy,dz,mag,xdir,dur)
	spawn()
		var/obj/FireWavefx/o = new/obj/FireWavefx(locate(dx,dy,dz))
		o.icon_state = num2text(mag)
		o.dir=xdir
		sleep(2)
		walk(o,o.dir)
		sleep(dur)
		walk(o,0)
		o.loc = null

proc/Mist_Cloud(dx,dy,dz,mag,dur)
	var/list/xlist=new
	if(mag==1)

		var/obj/P1= new/obj/Steam(locate(dx-1,dy+1,dz))
		P1.pixel_x=12
		P1.pixel_y=-12
		var/obj/P2= new/obj/Steam(locate(dx-1,dy,dz))
		P2.pixel_x=8

		var/obj/P3= new/obj/Steam(locate(dx-1,dy-1,dz))
		P3.pixel_x=12
		P3.pixel_y=12

		var/obj/P4= new/obj/Steam(locate(dx,dy+1,dz))
		P4.pixel_y=-8


		var/obj/P5= new/obj/Steam(locate(dx,dy-1,dz))
		P5.pixel_y=8
		var/obj/P6= new/obj/Steam(locate(dx+1,dy+1,dz))
		P6.pixel_x=-12
		P6.pixel_y=-12
		var/obj/P7= new/obj/Steam(locate(dx+1,dy,dz))
		P7.pixel_x=-8

		var/obj/P8= new/obj/Steam(locate(dx+1,dy-1,dz))
		P8.pixel_x=-12
		P8.pixel_y=12
		xlist+= new/obj/Steam(locate(dx,dy,dz))
		xlist+=P1
		xlist+=P2
		xlist+=P3
		xlist+=P4
		xlist+=P5
		xlist+=P6
		xlist+=P7
		xlist+=P8
	for(var/obj/vx in xlist)
		vx.projdisturber=1

	spawn()
		sleep(dur)
		for(var/obj/vv in xlist)
			sleep(1)
			del(vv)

obj
	effect
		layer = MOB_LAYER+2
		density = 0
	undereffect
		layer = MOB_LAYER-1
		density = 0
		var/uowner = 0

obj
	sword
		b1
			icon = 'icons/bsword1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -24
			pixel_y = -23
		b2
			icon = 'icons/bsword2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 12
			pixel_y = 12
		b3
			icon = 'icons/bsword3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 0
			pixel_y = 20
		b4
			icon = 'icons/bsword4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y = -21
		s1
			icon = 'sword1/sword1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -24
			pixel_y = -23
		s2
			icon = 'sword1/sword2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 12
			pixel_y = 12
		s3
			icon = 'sword1/sword3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 0
			pixel_y = 20
		s4
			icon = 'sword1/sword4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y = -21
		z1
			icon = 'icons/zabsword1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -24
			pixel_y = -23
		z2
			icon = 'icons/zabsword2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 12
			pixel_y = 12
		z3
			icon = 'icons/zabsword3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 0
			pixel_y = 20
		z4
			icon = 'icons/zabsword4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y = -21

//Spear
		spear
			icon = 'New/Spear.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -16

//Assassin
		shirasaya
			icon = 'New/Shirasaya sword.dmi'
			density = 0
			layer = MOB_LAYER+1

//Hanzo
		hanzo_s
			icon = 'New/Hanzo sword.dmi'
			density = 0
			layer = MOB_LAYER+1

//Nodachi
		nodachi
			icon = 'New/Nodachi long Sword.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -16

//Shichiseiken
		shi1
			icon = 'icons/Legendary Weapons/goldbrotherwep1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -24
			pixel_y = -23
		shi2
			icon = 'icons/Legendary Weapons/goldbrotherwep2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 12
			pixel_y = 12
		shi3
			icon = 'icons/Legendary Weapons/goldbrotherwep3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 0
			pixel_y = 20
		shi4
			icon = 'icons/Legendary Weapons/goldbrotherwep4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y = -21
//Bashosen
		ba1
			icon = 'icons/Legendary Weapons/silverbrotherwep1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -24
			pixel_y = -23
		ba2
			icon = 'icons/Legendary Weapons/silverbrotherwep2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 12
			pixel_y = 12
		ba3
			icon = 'icons/Legendary Weapons/silverbrotherwep3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 0
			pixel_y = 20
		ba4
			icon = 'icons/Legendary Weapons/silverbrotherwep4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y = -21
//Samehada
		sam1
			icon = 'icons/zSamehada1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		sam2
			icon = 'icons/zSamehada2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		sam3
			icon = 'icons/zSamehada3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		sam4
			icon = 'icons/zSamehada4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
//Big Samehada
		big_sam1
			icon = 'icons/newsame1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		big_sam2
			icon = 'icons/newsame2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		big_sam3
			icon = 'icons/newsame3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		big_sam4
			icon = 'icons/newsame4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
//Samurai Sword
		samurai1
			icon = 'icons/kusanagi1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		samurai2
			icon = 'icons/kusanagi2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		samurai3
			icon = 'icons/kusanagi3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		samurai4
			icon = 'icons/kusanagi4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
//Hiramekarei
		H1
			icon = 'icons/Hiramekarei/Hira1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		H2
			icon = 'icons/Hiramekarei/Hira2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		H3
			icon = 'icons/Hiramekarei/Hira3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		H4
			icon = 'icons/Hiramekarei/Hira4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
		//kabutowari
		Ka1
			icon = 'icons/Kabutowari/Kabu1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		Ka2
			icon = 'icons/Kabutowari/Kabu2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		Ka3
			icon = 'icons/Kabutowari/Kabu3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		Ka4
			icon = 'icons/Kabutowari/Kabu4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
		//kiba
		Ki1
			icon = 'icons/Kiba/Kiba1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		Ki2
			icon = 'icons/Kiba/Kiba2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		Ki3
			icon = 'icons/Kiba/Kiba3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		Ki4
			icon = 'icons/Kiba/Kiba4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
		//Nuibari
		Nu1
			icon = 'icons/Nuibari/Nuib1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		Nu2
			icon = 'icons/Nuibari/Nuib2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		Nu3
			icon = 'icons/Nuibari/Nuib3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		Nu4
			icon = 'icons/Nuibari/Nuib4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
		//Shibuki
		Sh1
			icon = 'icons/Shibuki/Shib1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-24
			pixel_y = -23
		Sh2
			icon = 'icons/Shibuki/Shib2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=12
			pixel_y =12
		Sh3
			icon = 'icons/Shibuki/Shib3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x=-0
			pixel_y = 20
		Sh4
			icon = 'icons/Shibuki/Shib4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y=-21
		w1
			icon = 'icons/windsword1.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -24
			pixel_y = -23
		w2
			icon = 'icons/windsword2.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 12
			pixel_y = 12
		w3
			icon = 'icons/windsword3.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = 0
			pixel_y = 20
		w4
			icon = 'icons/windsword4.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_y = -21

obj/Poison
	icon = 'icons/poison.dmi'
	icon_state = "cloud"
	density = 0
	layer = MOB_LAYER+1
	mouse_opacity = 0

obj/Steam
	icon='icons/steam_cloud.dmi'
	icon_state="steam"
	density=0
	layer=MOB_LAYER+1

obj/Fire
	f1
		icon = 'icons/katon.dmi'
		icon_state = "1"
		density = 0
		layer = MOB_LAYER+1
	f2
		icon = 'icons/katon.dmi'
		icon_state = "2"
		density = 0
		layer = MOB_LAYER+1
	f3
		icon = 'icons/katon.dmi'
		icon_state = "3"
		density = 0
		layer = MOB_LAYER+1
	f4
		icon = 'icons/katon.dmi'
		icon_state = "4"
		density = 0
		layer = MOB_LAYER+1
	f5
		icon = 'icons/katon.dmi'
		icon_state = "5"
		density = 0
		layer = MOB_LAYER+1
	f6
		icon = 'icons/katon.dmi'
		icon_state = "6"
		density = 0
		layer = MOB_LAYER+1
	f7
		icon = 'icons/katon.dmi'
		icon_state = "7"
		density = 0
		layer = MOB_LAYER+1
	f8
		icon = 'icons/katon.dmi'
		icon_state = "8"
		density = 0
		layer = MOB_LAYER+1
	f9
		icon = 'icons/katon.dmi'
		icon_state = "9"
		density = 0
		layer = MOB_LAYER+1

obj/Ash
	f1
		icon = 'icons/ashfire.dmi'
		icon_state = "1"
		density = 0
		layer = MOB_LAYER+1
	f2
		icon = 'icons/ashfire.dmi'
		icon_state = "2"
		density = 0
		layer = MOB_LAYER+1
	f3
		icon = 'icons/ashfire.dmi'
		icon_state = "3"
		density = 0
		layer = MOB_LAYER+1
	f4
		icon = 'icons/ashfire.dmi'
		icon_state = "4"
		density = 0
		layer = MOB_LAYER+1
	f5
		icon = 'icons/ashfire.dmi'
		icon_state = "5"
		density = 0
		layer = MOB_LAYER+1
	f6
		icon = 'icons/ashfire.dmi'
		icon_state = "6"
		density = 0
		layer = MOB_LAYER+1
	f7
		icon = 'icons/ashfire.dmi'
		icon_state = "7"
		density = 0
		layer = MOB_LAYER+1
	f8
		icon = 'icons/ashfire.dmi'
		icon_state = "8"
		density = 0
		layer = MOB_LAYER+1
	f9
		icon = 'icons/ashfire.dmi'
		icon_state = "9"
		density = 0
		layer = MOB_LAYER+1

atom/movable/proc
	CT()
		dir = turn(dir, 45)

	CCT()
		dir = turn(dir, -45)

obj
	trail
		watertrail
			layer = MOB_LAYER+2
			icon = 'icons/watertrail.dmi'
		shadowtrail
			layer = OBJ_LAYER
			icon = 'icons/shadowbindtrail.dmi'
		woodztrail
			layer = OBJ_LAYER
			icon = 'icons/woodbindtrail.dmi'
		shadowtrail2
			layer = OBJ_LAYER
			icon = 'icons/shadowneedletrail.dmi'
		falsedarknesstrail
			layer = OBJ_LAYER
			icon = 'icons/false_darkness.dmi'
		turrentrail
			layer = OBJ_LAYER
			icon = 'icons/turrent.dmi'
		blackpanther
			layer=OBJ_LAYER
			icon='icons/raiton_wolf.dmi'
			icon_state="trail"
		lasercircustrail
			layer=OBJ_LAYER
			icon='icons/lasertrail.dmi'

	trailmaker
		layer = MOB_LAYER+1
		density = 1
		var
			list/trails = new
			first = 0
		Raton_Sword
			icon = 'icons/ratonsword.dmi'

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						if(!first)
							first = 1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/ratonsword.dmi'
							O.icon_state = "trail"
							src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Turrent
			icon = 'icons/turrent.dmi'


			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						if(!first)
							first = 1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/turrent.dmi'
							O.icon_state = ""
							src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		False_Darkness
			density = 1
			layer = MOB_LAYER+1
			icon = 'icons/false_darkness.dmi'

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						var/obj/O = new(old_loc)
						O.dir = src.dir
						var/obj/m = new /obj/trail/falsedarknesstrail(O)
						m.dir = O.dir
						m.icon_state = "patch"
						var/obj/n = new /obj/trail/falsedarknesstrail(O)
						n.dir = O.dir
						n.icon_state = "patch"

						var/dir_angle = dir2angle(O.dir)
						var/dir_y = round(sin(dir_angle), 1)
						var/dir_x = round(cos(dir_angle), 1)

						src.pixel_y = 16 * dir_y
						src.pixel_x = 16 * dir_x

						O.pixel_y = 16 * dir_y
						O.pixel_x = 16 * dir_x

						m.pixel_y = -16 * dir_y
						m.pixel_x = -16 * dir_x

						n.pixel_y = 16 * dir_y
						n.pixel_x = 16 * dir_x

						O.underlays += m
						spawn(1) O.underlays += n
						O.icon = 'icons/false_darkness.dmi'
						O.icon_state = "trail"
						src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Inferno
			icon='icons/amaterasu.dmi'
			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						if(first==0)
							first=1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/amaterasu.dmi'
							O.icon_state="[rand(1,12)]"
							src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()
		Mind_Transfer
			icon='blank.dmi'
			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						if(first==0)
							first=1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'blank.dmi'
							O.icon_state=""
							src.trails += O
							O.layer=MOB_LAYER+2
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Flower_Bomb
			icon='icons/flower_bomb.dmi'
			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						if(first==0)
							first=1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/flower_bomb.dmi'
							O.icon_state="tail"
							src.trails += O
							O.layer=MOB_LAYER+2
				return d
			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Dragon_Fire
			icon = 'icons/dragonfire.dmi'

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				for(var/obj/smoke/s in loc)
					spawn()
						if(!s.ignited) s.Ignite(s,s.loc)
				spawn()
					if(d)
						if(!first)
							first = 1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/dragonfire.dmi'
							O.icon_state="tail"
							src.trails += O
							O.layer = MOB_LAYER+2
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

	/*	BlackPanther
			icon = 'icons/raiton_wolf.dmi'

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				for(var/obj/smoke/s in loc)
					spawn()
						if(!s.ignited) s.Ignite(s,s.loc)
				spawn()
					if(d)
						if(!first)
							first = 1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/raiton_wolf.dmi'
							O.icon_state="trail"
							src.trails += O
							O.layer = MOB_LAYER+2
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()*/

		Sand_Hand
			icon = 'New/GaaraHand.dmi'
			var/list/gotmob = new

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				if(loc.density)
					loc = old_loc
					walk(src, 0)
				spawn()
					if(d)
						if(length(gotmob))
							for(var/mob/M in gotmob)
								if(get_dist(M, src) <= 2)
									var/turf/T=locate(src.x, src.y, src.z)
									if(T && !T.density) M.loc = locate(T.x, T.y, T.z)
								else
									gotmob -= M

						if(!first)
							first = 1
				return d


		Mud_Slide
			icon = 'icons/earthflow.dmi'
			var/list/gotmob = new

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				if(loc.density)
					loc = old_loc
					walk(src, 0)
				spawn()
					if(d)
						if(length(gotmob))
							for(var/mob/M in gotmob)
								if(get_dist(M, src) <= 2)
									var/turf/T=locate(src.x, src.y, src.z)
									if(T && !T.density) M.loc = locate(T.x, T.y, T.z)
								else
									gotmob -= M

						if(!first)
							first = 1
						else
							var/obj/O = new (old_loc)
							O.dir = src.dir
							O.icon = 'icons/earthflow.dmi'
							O.icon_state = "tail"
							src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()


		User
			//icon = 'icons/earthflow.dmi'
			var/list/gotmob = new

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				if(loc.density)
					loc = old_loc
					walk(src, 0)
				spawn()
					if(d)
						if(length(gotmob))
							for(var/mob/M in gotmob)
								if(get_dist(M, src) <= 2)
									var/turf/T=locate(src.x, src.y, src.z)
									if(T && !T.density) M.loc = locate(T.x, T.y, T.z)
								else
									gotmob -= M

						if(!first)
							first = 1
						else
							var/obj/O = new (old_loc)
							O.dir = src.dir
							O.icon = 'icons/earthflow.dmi'
							O.icon_state = "tail"
							src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Crystal_Dragon
			icon='icons/crystaldragon.dmi'
			var/list/gotmob=new
			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				if(loc.density)
					loc = old_loc
					walk(src, 0)
				spawn()
					if(d)
						if(length(gotmob))
							for(var/mob/M in gotmob)
								if(get_dist(M,src)<=2)
									var/turf/T=locate(src.x,src.y,src.z)
									if(T&&!T.density)M.loc=locate(T.x,T.y,T.z)
								else
									gotmob-=M

						if(first==0)
							first=1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/crystaldragon.dmi'
							O.icon_state="trail"
							src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Shadowneedle
			density = 1
			layer = MOB_LAYER
			icon = 'icons/shadowneedle2.dmi'
			pixel_y = -10

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						var/obj/O = new(old_loc)
						O.dir = src.dir
						var/obj/m = new /obj/trail/shadowtrail2(O)
						m.dir = O.dir
						m.icon_state = "patch"
						var/obj/n = new /obj/trail/shadowtrail2(O)
						n.dir = O.dir
						n.icon_state = "patch"

						var/dir_angle = dir2angle(O.dir)
						var/dir_y = round(sin(dir_angle), 1)
						var/dir_x = round(cos(dir_angle), 1)

						src.pixel_y = 16 * dir_y - 10
						src.pixel_x = 16 * dir_x

						O.pixel_y = 16 * dir_y - 10
						O.pixel_x = 16 * dir_x

						m.pixel_y = -16 * dir_y
						m.pixel_x = -16 * dir_x

						n.pixel_y = 16 * dir_y
						n.pixel_x = 16 * dir_x

						O.underlays += m
						spawn(1) O.underlays += n
						O.icon = 'icons/shadowneedletrail.dmi'
						src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Shadow
			density = 0
			layer = OBJ_LAYER
			icon = 'icons/shadowbind.dmi'
			pixel_y = -10

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						var/obj/O = new(old_loc)
						O.dir = src.dir
						var/obj/m = new /obj/trail/shadowtrail(O)
						m.dir = O.dir
						m.icon_state = "patch"
						var/obj/n = new /obj/trail/shadowtrail(O)
						n.dir = O.dir
						n.icon_state = "patch"

						var/dir_angle = dir2angle(O.dir)
						var/dir_y = round(sin(dir_angle), 1)
						var/dir_x = round(cos(dir_angle), 1)

						src.pixel_y = 16 * dir_y - 10
						src.pixel_x = 16 * dir_x

						O.pixel_y = 16 * dir_y - 10
						O.pixel_x = 16 * dir_x

						m.pixel_y = -16 * dir_y
						m.pixel_x = -16 * dir_x

						n.pixel_y = 16 * dir_y
						n.pixel_x = 16 * dir_x

						O.underlays += m
						spawn(1) O.underlays += n
						O.icon = 'icons/shadowbindtrail.dmi'
						src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Woodz
			density = 0
			layer = OBJ_LAYER
			icon = 'icons/woodbind.dmi'
			pixel_y = -10

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						var/obj/O = new(old_loc)
						O.dir = src.dir
						var/obj/m = new /obj/trail/woodztrail(O)
						m.dir = O.dir
						m.icon_state = "patch"
						var/obj/n = new /obj/trail/woodztrail(O)
						n.dir = O.dir
						n.icon_state = "patch"

						var/dir_angle = dir2angle(O.dir)
						var/dir_y = round(sin(dir_angle), 1)
						var/dir_x = round(cos(dir_angle), 1)

						src.pixel_y = 16 * dir_y - 10
						src.pixel_x = 16 * dir_x

						O.pixel_y = 16 * dir_y - 10
						O.pixel_x = 16 * dir_x

						m.pixel_y = -16 * dir_y
						m.pixel_x = -16 * dir_x

						n.pixel_y = 16 * dir_y
						n.pixel_x = 16 * dir_x

						O.underlays += m
						spawn(1) O.underlays += n
						O.icon = 'icons/woodbindtrail.dmi'
						src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Water_Dragon
			density = 1
			layer = MOB_LAYER+2
			icon = 'icons/waterdragon.dmi'

			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						var/obj/O = new(old_loc)
						O.dir = src.dir
						var/obj/m = new /obj/trail/watertrail(O)
						m.dir = O.dir
						m.icon_state = "patch"
						var/obj/n = new /obj/trail/watertrail(O)
						n.dir = O.dir
						n.icon_state = "patch"

						var/dir_angle = dir2angle(O.dir)
						var/dir_y = round(sin(dir_angle), 1)
						var/dir_x = round(cos(dir_angle), 1)

						src.pixel_y = 16 * dir_y
						src.pixel_x = 16 * dir_x

						O.pixel_y = 16 * dir_y
						O.pixel_x = 16 * dir_x

						m.pixel_y = -16 * dir_y
						m.pixel_x = -16 * dir_x

						n.pixel_y = 16 * dir_y
						n.pixel_x = 16 * dir_x

						O.underlays += m
						spawn(1) O.underlays += n
						O.icon = 'icons/watertrail.dmi'
						src.trails += O
				return d

			Del()
				var/rdir
				for(var/obj/o in src.trails)
					if(o.dir in list(NORTHWEST,SOUTHWEST,NORTHEAST,SOUTHEAST)) rdir = SOUTH
					else rdir = o.dir
					Wet(o.x, o.y, o.z, rdir, 1, 800)
					o.loc = null
				..()

		Kakuzu_Trail
			icon='icons/kakuzuneedle.dmi'
			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						if(first==0)
							first=1
						else
							var/obj/O = new(old_loc)
							O.dir = src.dir
							O.icon = 'icons/kakuzuneedle.dmi'
							O.icon_state="trail"
							src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

		Lasercircus
			density=1
			layer=MOB_LAYER
			icon='icons/laserend.dmi'
			pixel_y=-10
			Move()
				var/turf/old_loc = src.loc
				var/d = ..()
				spawn()
					if(d)
						var/obj/O = new(old_loc)
						O.dir = src.dir
						var/obj/m=new/obj/trail/lasercircustrail(O)
						m.dir=O.dir
						m.icon_state="patch"
						var/obj/n=new/obj/trail/lasercircustrail(O)
						n.dir=O.dir
						n.icon_state="patch"

						var/dir_angle = dir2angle(O.dir)
						var/dir_y = round(sin(dir_angle), 1)
						var/dir_x = round(cos(dir_angle), 1)

						src.pixel_y = 16 * dir_y
						src.pixel_x = 16 * dir_x

						O.pixel_y = 16 * dir_y
						O.pixel_x = 16 * dir_x

						m.pixel_y = -16 * dir_y
						m.pixel_x = -16 * dir_x

						n.pixel_y = 16 * dir_y
						n.pixel_x = 16 * dir_x
						O.underlays+=m
						spawn(1)O.underlays+=n
						O.icon = 'icons/lasertrail.dmi'
						src.trails += O
				return d

			Del()
				for(var/obj/o in src.trails)
					o.loc = null
				..()

obj/earthcage
	var/crushed = 0
	var/crumbled = 0
	icon = 'icons/dotoncage.dmi'
	layer = MOB_LAYER
	pixel_x = -32
	pixel_y = -32
	density = 0

proc/Doton_Cage(dx, dy, dz, dur)
	var/obj/cage = new /obj/earthcage(locate(dx, dy, dz))
	cage.owner = usr
	flick("Creation", cage)
	sleep(dur)
	cage.loc = null

obj
	kbl
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 0,0"
		pixel_x = -32
		pixel_y = -32
	kbr
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 1,0"
		//pixel_x = 16
		pixel_y = -32
	ktl
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 2,0"
		pixel_y = -32
		pixel_x = 32
	ktr
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 0,1"
		//pixel_y = 20
		pixel_x = -32
	kta
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 1,1"
	ktb
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 2,1"
		//pixel_y = 20
		pixel_x = 32
	ktc
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 0,2"
		pixel_y = 32
		pixel_x = -32
	ktd
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 1,2"
		pixel_y = 32
	kte
		icon = 'icons/kaiten.dmi'
		layer = MOB_LAYER+2
		density = 0
		icon_state = "spin 2,2"
		pixel_y = 32
		pixel_x = 32

proc/Hakke_Circle(mob/u, mob/t)
	var/image/circle = image('icons/hakke64.dmi', locate(u.x, u.y, u.z), pixel_x = -32, pixel_y = -32, layer = TURF_LAYER + 1)

	u << circle
	if(t)
		t << circle

	sleep(40)

	if(u && u.client)
		u.client.images -= circle
	if(t && t.client)
		t.client.images -= circle

mob/proc/Hakke_Pwn(mob/e)

	while(e&&src)
		src.Timed_Stun(30)
		e.Timed_Stun(30)
		src.overlays += 'icons/hakkehand.dmi'

		e.combat("[src]: Two")
		src.combat("[src]: Two")
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Four")
		src.combat("[src]: Four")
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Eight")
		src.combat("[src]: Eight")
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Sixteen")
		src.combat("[src]: Sixteen")
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Thirty-two")
		src.combat("[src]: Thirty-two")
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Sixty Four!")
		src.combat("[src]: Sixty Four!")
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)

		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()

		spawn() e.Knockback(3, src.dir)

		src.overlays -= 'icons/hakkehand.dmi'
		break


mob/proc/Hakke_Pwn2(mob/e)
	if(e)
		src.Timed_Stun(60)
		e.Timed_Stun(60)
		src.overlays += 'icons/hakkehand.dmi'

		e.combat("[src]: Two")
		src.combat("[src]: Two")
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Four")
		src.combat("[src]: Four")
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Eight")
		src.combat("[src]: Eight")
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Sixteen")
		src.combat("[src]: Sixteen")
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Thirty-two")
		src.combat("[src]: Thirty-two")
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		e.combat("[src]: Sixty Four!")
		src.combat("[src]: Sixty Four!")
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)

		e.combat("[src]: One Hundred Twenty Eight!")
		src.combat("[src]: One Hundred Twenty Eight!")
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)
		flick("PunchA-1", src)
		sleep(1)
		flick("PunchA-2", src)
		sleep(1)

		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()
		spawn() if(e) e.Chakrahit()

		spawn() e.Knockback(3, src.dir)

		src.overlays -= 'icons/hakkehand.dmi'


mob/proc
	Chakrahit(time=20)
		spawn()
			var/obj/o = new /obj/effect(src.loc)
			o.icon = 'icons/chakrahit.dmi'
			var/r = rand(1, 4)
			flick("[r]", o)
			spawn(time)
				o.loc = null

	Chakrahit2()
		spawn()
			var/obj/o = new /obj/effect(src.loc)
			o.icon = 'icons/chakrahit2.dmi'
			var/r = rand(1, 4)
			flick("[r]", o)
			spawn(4)
				o.loc = null

obj
	explosion
		layer = MOB_LAYER+1
		tr
			icon = 'icons/expltr.dmi'
			pixel_x = 16
			pixel_y = 16
		tl
			icon = 'icons/expltl.dmi'
			pixel_x = -16
			pixel_y = 16
		br
			icon = 'icons/explbr.dmi'
			pixel_x = 16
			pixel_y = -16
		bl
			icon = 'icons/explbl.dmi'
			pixel_x = -16
			pixel_y = -16

proc
	explosion(power, dx, dy, dz, mob/u, dontknock, dist = 8)
		new /obj/Explosion(locate(dx, dy, dz), u, power, dist, 0, 0, dontknock)
	explosion2(power, dx, dy, dz, mob/u, dontknock, dist = 4)
		new /obj/Explosion2(locate(dx, dy, dz), u, power, dist, 0, 0, dontknock)
	explosion3(power, dx, dy, dz, mob/u, dontknock, dist = 4)
		new /obj/Explosion3(locate(dx, dy, dz), u, power, dist, 0, 0, dontknock)
	explosion4(power, dx, dy, dz, mob/u, dontknock, dist = 12)
		new /obj/Explosion2(locate(dx, dy, dz), u, power, dist, 0, 0, dontknock)

mob/proc/Tag_Interact(obj/explosive_tag/U)
	switch(input(src, "What do you want to do to this Explosive Tag", "Trap") in list("Disarm", "Set Trap", "Hide", "Nothing"))
		if("Set Trap")
			if(U) U.icon_state = "blank"
			var/obj/o = new /obj/trip(loc)
			o.owner = src
			if(o) o.dir = dir

		if("Disarm")
			spawn() src.Timed_Stun(10)
			sleep(10)
			if(U)
				if(U.owner && istype(U.owner, /mob/human/player))
					for(var/obj/trigger/explosive_tag/T in U.owner:triggers)
						if(T.ex_tag == U)
							U.owner:RemoveTrigger(T)
				U.loc = null
				combat("Disarmed the Explosive Note!")
		if("Hide")
			spawn() src.Timed_Stun(10)
			sleep(10)
			if(U)
				U.icon_state = "blank"

obj
	wind_bullet
		New()
			src.overlays += image('icons/windbullet.dmi', icon_state = "dl", pixel_x = -16, pixel_y = -16)
			src.overlays += image('icons/windbullet.dmi', icon_state = "dr", pixel_x = 16, pixel_y = -16)
			src.overlays += image('icons/windbullet.dmi', icon_state = "ul", pixel_x = -16, pixel_y = 16)
			src.overlays += image('icons/windbullet.dmi', icon_state = "ur", pixel_x = 16, pixel_y = 16)

obj
	bijuu_bomb
		New()
			src.overlays += image('icons/bijuubullet.dmi', icon_state = "dl", pixel_x = -16, pixel_y = -16)
			src.overlays += image('icons/bijuubullet.dmi', icon_state = "dr", pixel_x = 16, pixel_y = -16)
			src.overlays += image('icons/bijuubullet.dmi', icon_state = "ul", pixel_x = -16, pixel_y = 16)
			src.overlays += image('icons/bijuubullet.dmi', icon_state = "ur", pixel_x = 16, pixel_y = 16)

obj
	scorch_bomb
		New()
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "0,0", pixel_x = -32, pixel_y = -32)
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "1,0", pixel_y = -32)
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "2,0", pixel_x = 32, pixel_y = -32)
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "0,1", pixel_x = -32)
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "1,1")
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "2,1", pixel_x = 32)
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "0,2", pixel_x = -32, pixel_y = 32)
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "1,2", pixel_y = 32)
			src.overlays += image('icons/Flame_Shot2.dmi', icon_state = "2,2", pixel_x = 32, pixel_y = 32)





proc/Black(dx,dy,dz,dur)
	var/obj/black/o = new/obj/black(locate(dx,dy,dz))
	var/i=dur
	while(i>0)
		var/r=rand(1,15)
		o.icon_state="[r]"
		sleep(1)
		i--
	del(o)

obj
	black
		icon='icons/blacklight.dmi'
		icon_state=""
		density=0

proc/Lightning(dx,dy,dz,dur)
	var/obj/lightning/s = new/obj/lightning(locate(dx,dy,dz))
	sleep(10)
	del(s)

obj/lightning
	icon='icons/lightning.dmi'
	icon_state=""
	density=1
	New()
		flick("flick",src)
		spawn(10)
			CHECK_TICK
			del(src)