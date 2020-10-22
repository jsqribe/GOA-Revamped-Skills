mob/var
	sage_mode = 0
skill
	wof
		copyable=0
		sage_mode
			id = SAGE_MODE
			name = "Sennin Mode"
			icon_state = "sage"
			default_chakra_cost = 400
			default_cooldown = 460

			IsUsable(mob/user)
				.=..()
				if(.)
					if(user.sage_mode)
						Error(user, "You already have sage mode on.")
						return 0

			Use(mob/user)
				viewers(user) << output("[user] has activated sage mode!")
				var/buffrfx=round(user.rfx*0.12)
				var/buffstr=round(user.str*0.15)
				var/buffcon=round(user.con*0.20)

				user.naturechakra=10000
				user.rfxbuff+=buffrfx
				user.strbuff+=buffstr
				user.conbuff+=buffcon
				user.overlays+=/obj/special/sage_mode
				user.sage_mode = 1

				//spawn(Cooldown(user)*7)
				if(user.naturechakra<=0)
					user.sage_mode = 0
					user.rfxbuff-=round(buffrfx)
					user.strbuff-=round(buffstr)
					user.conbuff-=round(buffcon)
					user.overlays-=/obj/special/sage_mode

	rasenshuriken_sage
		id = FUUTON_RASENSHURIKEN_SAGE
		name = "Wind Style: Rasenshuriken"
		icon_state = "rasenshuriken"
		default_chakra_cost = 1000
		default_cooldown = 200
		copyable=0

		IsUsable(mob/user)
			. = ..()
			if(.)
				if(!user.sage_mode)
					Error(user, "Sage Mode must be activated to use this jutsu")
					return 0

		Use(mob/human/player/user)
			viewers(user) << output("[user]: Wind Style: Rasenshuriken!", "combat_output")
			user.Begin_Stun()
			var/list/B = new
			B+=new/mob/human/player/npc/kage_bunshin(locate(user.x-1,user.y,user.z))
			for(var/mob/human/player/npc/kage_bunshin/O in B)
				O.Squad=B
				//tricks+=O
				spawn(2)
					O.icon=user.icon
					O.faction=user.faction
					O.mouse_over_pointer=user.mouse_over_pointer
					O.temp=1200
					O.overlays+=user.overlays
					O.name=user.name
					O.dir=EAST
					O.skillsx=list(user.skills)
					spawn(1)O.CreateName(255, 255, 255)
					spawn()O.AIinitialize()

				O.owner=user

				O.killable=1

				user.pet=1

			user.BunshinTrick(B)
			sleep(30)
			if(user)
				user.rasengan=4
				user.End_Stun()
				user.combat("Press <b>A</b> before the Rasenshuriken dissapates to use it on someone or press F to throw it. If you take damage it will dissipate!")
				user.overlays+='icons/rasenshuriken2.dmi'
				spawn(100)
					user.overlays-='icons/rasenshuriken2.dmi'
					if(user && user.rasengan==4)
						user.Rasenshuriken_Fail2()
						user.curwound+=5

obj
	rasenshuriken_projectile
		icon='icons/rasenshuriken2.dmi'
		density=1
		var
			mob/Owner=null
			Damage=0
			hit=0

		New(mob/human/player/p, dx, dy, dz, ddir, conmult)
			..()
			src.Owner=p
			src.Damage=conmult
			src.dir=ddir
			src.loc=locate(dx,dy,dz)
			walk(src,src.dir)
			spawn(300)
				if(src&&!src.hit) del(src)

		Bump(O)
			if(istype(O,/mob))
				src.hit=1
				if(!istype(O,/mob/human/player))
					del(src)
				src.icon=0
				var/mob/p = O
				var/mob/M = src.Owner
				M.Rasenshuriken_Hit2(p,M,src.dir)
				spawn() del(src)

			if(istype(O,/turf))
				var/turf/T = O
				if(T.density)
					src.hit=1
					del(src)

			if(istype(O,/obj))
				var/obj/T = O
				if(T.density)
					src.hit=1
					del(src)


mob/proc
	Rasenshuriken_Fail2()
		src.overlays-='icons/rasenshuriken2.dmi'
		src.overlays-='icons/rasenshuriken2.dmi'
		src.rasengan=0
		src.overlays-=/obj/rasengan
		src.overlays-=/obj/rasengan2
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER+1
		o.icon='icons/rasengan.dmi'
		flick("failed",o)
		spawn(50)
			del(o)

	Rasenshuriken_Hit2(mob/x,mob/u,xdir)
		u.overlays-='icons/rasenshuriken2.dmi'
		u.overlays-='icons/rasenshuriken2.dmi'
		u.overlays-=/obj/rasengan
		u.overlays-=/obj/rasengan2
		u.rasengan=0
		var/conmult=(u.con+u.conbuff-u.conneg)/100
		x.cantreact=1
		spawn(30)	// Can we please not forget to make sure things are still valid after any sleep or spawn call.
			if(x)	x.cantreact=0
		var/obj/o=new/obj(locate(x.x,x.y,x.z))
		o.icon='icons/rasengan.dmi'
		o.layer=MOB_LAYER+1
		if(!x.icon_state)
			x.icon_state="hurt"

		flick("hit",o)

		x.Earthquake(20)
		spawn(50)
			del(o)
		sleep(10)
		if(x)
			x.Knockback(10,xdir)
			if(x)	// Knockback sleeps, I think. It really shouldn't though.
				explosion(50,x.x,x.y,x.z,u,1)
				x.Damage(500+500*conmult,rand(2,5),0,u)
				x.stunned+=3
			//	x.Wound(rand(2,5),0,u)
				if(!x.ko)
					x.icon_state=""
				x.Hostile(u)

