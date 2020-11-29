mob/proc
	ORasengan_Fail()
		src.rasengan=0
		src.overlays-=/obj/oodamarasengan
		src.overlays-=/obj/oodamarasengan2
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER-1
		o.icon='icons/oodamarasengan.dmi'
		flick("failed",o)
		src.jutsu_overlay=null
		src.Load_Overlays()
		spawn(50)
			o.loc = null

	ORasengan_Hit(mob/x,mob/human/u,xdir)
		x = x.Replacement_Start(u)
		u.overlays-=/obj/oodamarasengan
		u.overlays-=/obj/oodamarasengan2
		u.rasengan=0
		var/conmult= u.ControlDamageMultiplier()
		x.cantreact=1
		spawn(30)
			x.cantreact=0
		var/obj/o=new/obj/oodamaexplosion(locate(x.x,x.y,x.z))
		o.layer=MOB_LAYER-1
		if(!x.icon_state)
			x.icon_state="hurt"
		x.Timed_Stun(20)
		u.Timed_Stun(20)
		x.Damage(1125+1125*conmult, rand(15,20), u, "Oodama Rasengan", "Normal")
		x.Earthquake(20)
		sleep(20)
		o.loc = null
		x.Knockback(10,xdir)
		explosion(50,x.x,x.y,x.z,u,1)
		if(x)
			x.Timed_Stun(30)
			if(!x.ko) x.icon_state=""
			x.Hostile(u)
		spawn(5) if(x) x.Replacement_End()

	Rasengan_Fail()
		src.rasengan=0
		src.overlays-=/obj/rasengan
		src.overlays-=/obj/rasengan2
		src.jutsu_overlay=null
		src.Load_Overlays()
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER+1
		o.icon='icons/rasengan.dmi'
		flick("failed",o)
		spawn(50)
			o.loc = null

	Rasengan_Hit(mob/x,mob/human/u,xdir)
		x = x.Replacement_Start(u)
		u.overlays-=/obj/rasengan
		u.overlays-=/obj/rasengan2
		u.rasengan=0
		var/conmult= u.ControlDamageMultiplier()
		x.cantreact=1
		spawn(30)	// Can we please not forget to make sure things are still valid after any sleep or spawn call.
			if(x)	x.cantreact=0
		var/obj/o=new/obj(locate(x.x,x.y,x.z))
		o.icon='icons/rasengan.dmi'
		o.layer=MOB_LAYER+1
		if(!x.icon_state)
			x.icon_state="hurt"

		flick("hit",o)

		x.Earthquake(10)
		x.Damage(750+750*conmult, 0, u, "Rasengan", "Normal")
		spawn(50)
			o.loc = null
		sleep(10)
		if(x)
			x.Knockback(10,xdir)
			if(x)	// Knockback sleeps, I think. It really shouldn't though.
				explosion(50,x.x,x.y,x.z,u,1)
				x.Timed_Stun(30)
				if(!x.ko)
					x.icon_state=""
				x.Hostile(u)
			spawn(5) if(x) x.Replacement_End()


	SRasengan_Fail()
		src.rasengan=0
		src.overlays-=/obj/rasengan
		src.overlays-=/obj/rasengan2
		src.jutsu_overlay=null
		src.Load_Overlays()
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER+1
		o.icon='icons/rasengan.dmi'
		flick("failed",o)
		spawn(50)
			o.loc = null

	SRasengan_Hit(mob/x,mob/human/u,xdir)
		x = x.Replacement_Start(u)
		u.overlays-=/obj/rasengan
		u.overlays-=/obj/rasengan2
		u.rasengan=0
		var/conmult= u.ControlDamageMultiplier()
		x.cantreact=1
		spawn(30)	// Can we please not forget to make sure things are still valid after any sleep or spawn call.
			if(x)	x.cantreact=0
		var/obj/o=new/obj(locate(x.x,x.y,x.z))
		o.icon='icons/rasengan.dmi'
		o.layer=MOB_LAYER+1
		if(!x.icon_state)
			x.icon_state="hurt"

		flick("hit",o)

		x.Earthquake(10)
		x.Damage(375+375*conmult, 0, u, "Space-Time Rasengan", "Normal")
		spawn(50)
			o.loc = null
		sleep(10)
		if(x)
			x.Knockback(10,xdir)
			if(x)	// Knockback sleeps, I think. It really shouldn't though.
				explosion(50,x.x,x.y,x.z,u,1)
			//	x.Timed_Stun(30)
				if(!x.ko)
					x.icon_state=""
				x.Hostile(u)
			spawn(5) if(x) x.Replacement_End()