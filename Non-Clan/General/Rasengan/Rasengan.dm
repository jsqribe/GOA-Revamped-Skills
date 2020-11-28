skill
	rasengan
		id = RASENGAN
		name = "Rasengan"
		description = "Creates a small ball of highly concentrated chakra that rapidly expands when punched into an enemy."
		icon_state = "rasengan"
		default_chakra_cost = 300
		default_cooldown = 90
		stamina_damage_fixed = list(750, 750)
		stamina_damage_con = list(750, 750)



		Use(mob/human/player/user)
			viewers(user) << output("[user]: Rasengan!", "combat_output")
			user.Timed_Stun(10)
			var/obj/x = new(locate(user.x,user.y,user.z))
			x.layer=MOB_LAYER+1
			x.icon='icons/rasengan.dmi'
			x.dir=user.dir
			flick("create",x)
			user.jutsu_overlay=/obj/rasengan
			spawn(30)
				x.loc = null
			sleep(10)
			if(user && !user.ko)
				user.rasengan=1
				user.combat("Press <b>A</b> to use Rasengan on someone. If you take damage it will dissipate!")
				user.Load_Overlays()
				while(user.rasengan)
					sleep(world.tick_lag)




	oodama_rasengan
		id = OODAMA_RASENGAN
		name = "Large Rasengan"
		description = "Creates a ball of highly concentrated chakra that rapidly expands when punched into an enemy."
		icon_state = "oodama_rasengan"
		default_chakra_cost = 500
		default_cooldown = 140
		stamina_damage_fixed = list(1125, 1125)
		stamina_damage_con = list(1125, 1125)
		wound_damage_fixed = list(15, 20)
		wound_damage_con = list(0, 0)



		Use(mob/human/player/user)
			viewers(user) << output("[user]: Large Rasengan!", "combat_output")
			user.Timed_Stun(30)
			var/obj/x = new(locate(user.x,user.y,user.z))
			x.layer=MOB_LAYER-1
			x.icon='icons/oodamarasengan.dmi'
			x.dir=user.dir
			flick("create",x)
			user.jutsu_overlay=/obj/oodamarasengan
			spawn(30)
				x.loc = null
			sleep(30)
			if(user && !user.ko)
				user.rasengan=2
				user.combat("Press <b>A</b> before the Oodama Rasengan dissapates to use it on someone. If you take damage it will dissipate!")
				user.Load_Overlays()
				// This is a nice candidate for a task system
				// Make it get removed when the rasengan is used/failed
				while(user.rasengan)
					sleep(100)
					user.rasengan=0

				user.jutsu_overlay=null
				user.Load_Overlays()
