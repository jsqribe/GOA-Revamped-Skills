obj/projectile
	landed(atom/movable/O,pow,wnd,daze,burn)
		..()

		if(src.landed)
			return
		src.landed=1
		if(!O)
			if(src.icon=='icons/projectiles.dmi')
				if(src.icon_state=="shuriken-m")src.icon_state=pick("shuriken-m-clashed1","shuriken-m-clashed2","shuriken-m-clashed3") //sets the projectile to its landed in a turf icon state
				if(src.icon_state=="needle-m")src.icon_state=pick("needle-m-clashed1","needle-m-clashed2","needle-m-clashed3")
				if(src.icon_state=="kunai-m")src.icon_state=pick("kunai-m-clashed1","kunai-m-clashed2","kunai-m-clashed3")
				if(src.icon_state=="knife-m")src.icon_state="knife-m-clashed1"
				if(src.icon_state=="windmill-m")src.icon_state="windmill-m-clashed1"
			else
				src.icon=null
				src.overlays=null

			src.landed=2

			sleep(50)
			src.loc=null  //go away invisible
		if(istype(O,/mob/human))
			var/mob/human/H = O
			var/turf/hitloc = H.loc
			if(!H.mole)
				if(H.ironskin && !H.sandarmor)
					src.loc=null
					return
				var/mob/human/Oc=O:Replacement_Start(src.powner)
				if(daze&& prob(daze))
					Oc.icon_state="hurt"
					var/dazed=3
					Oc.Timed_Move_Stun(round(dazed,0.1))

					spawn() Oc.Graphiked('icons/dazed.dmi')

				if(wnd) Blood(O.x,O.y,O.z)  //ew blood
				Oc.Damage(pow, wnd, src.powner, "Projectile", "Normal")
				if(Oc && burn) Oc.BurnDOT(src.powner,burn,"nail")


				Oc.Hostile(src.powner)
				spawn(5) if(Oc) Oc.Replacement_End()
				if(src.icon == 'icons/water_bullet.dmi')
					var/obj/hit = new/obj(hitloc)
					hit.density = 0
					hit.layer = MOB_LAYER+0.1
					hit.icon = src.icon
					flick("hit",hit)
					spawn(4) Wet(hitloc.x, hitloc.y, hitloc.z, hitloc.dir, 0, 800)
					spawn(10) hit.loc = null

				if(src.icon == 'icons/lava_bullet.dmi')
					var/obj/hit = new/obj(hitloc)
					hit.density = 0
					hit.layer = MOB_LAYER+0.1
					hit.icon = src.icon
					flick("hit",hit)
					spawn(2) LavaHit(hitloc)
					spawn(10) hit.loc = null


				src.loc=null  //go away invisible

		if(istype(O,/obj/projectile))
			var/obj/projectile/Oc=O
			if(Oc.landed!=2)  //dont clash with projectiles that are sticking in turfs!
				Clash(O,src) //clash O and src together