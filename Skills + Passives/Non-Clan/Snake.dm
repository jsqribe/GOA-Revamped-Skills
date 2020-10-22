skill
	manda
		copyable = 0

		snake_ambush
			id = SNAKE_AMBUSH
			name = "Snake: Serpent Ambush"
			icon_state = "snake_ambush"
			default_chakra_cost = 500
			default_cooldown = 70
			default_seal_time = 7




			Use(mob/human/user)
				user.Timed_Stun(10)
				viewers(user) << output("[user]: Snake: Serpent Ambush!", "combat_output")

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					user.icon_state="Seal"
					var/turf/L=etarget.loc
					sleep(5)
					var/hit=0
					if(L && L==etarget.loc)
						hit=1
						etarget.Timed_Stun(30)

					var/obj/O =new(locate(L.x,L.y,L.z))
					O.layer=MOB_LAYER+3
					O.overlays+=image('icons/oro_snake_attack.dmi',pixel_x=0,pixel_y=0)
					var/found=0

					for(var/obj/water/X in oview(4,user))
						found++
						break
					if(found>10)found=10
					if(hit && etarget)
						etarget.Dec_Stam((1400 + 400*conmult + found*50),0,user)
						spawn()etarget.Hostile(user)
					sleep(50)

					if(O)del(O)

		snake_bind
			id = SNAKE_BIND
			name = "Snake: Shadow Snake Bind"
			icon_state = "snake_wrap"
			default_chakra_cost = 200
			default_cooldown = 150
			default_seal_time = 6


			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/player/etarget = user.MainTarget()
					if(!etarget)
						Error(user, "No Target")
						return 0
					var/distance = get_dist(user, etarget)
					if(distance > 10)
						Error(user, "Target too far ([distance]/10 tiles)")
						return 0

			Use(mob/human/user)
				var/mob/human/player/etarget = user.MainTarget()
				user.stunned=0
				viewers(user) << output("[user]: Snake: Shadow Snake Bind!", "combat_output")

				etarget.overlays+='icons/snakebind.dmi'

				etarget.Timed_Stun(50)
				spawn(50)

					Blood2(etarget)
					etarget.overlays-='icons/snakebind.dmi'
					etarget.curwound+=5
					//etarget.move_stun+=2

		snake_hands
			id = SNAKE_HANDS
			name = "Snake: Hidden Shadow Snake Hands"
			icon_state = "snake_hands"
			default_chakra_cost = 300
			default_cooldown = 65
			default_seal_time = 8

			Use(mob/human/user)

				viewers(user) << output("[user]: Snake: Hidden Shadow Snake Hands!", "combat_output")

			/*	spawn()
					var/eicon='icons/snakehands.dmi'
					var/estate=""
					var/mob/human/player/etarget = user.NearestTarget()

					var/numOfHosenkas = 1

					for (var/i = 0; i < numOfHosenkas; i++)
						if(!etarget)
							etarget=straight_proj2(eicon,estate,8,user)
							if(etarget)
								Poof(etarget.x, etarget.y, etarget.z)

						else
							var/ex=etarget.x
							var/ey=etarget.y
							var/ez=etarget.z
							var/mob/x=new/mob(locate(ex,ey,ez))

							projectile_to(eicon,estate,user,x)
							Poof(etarget.x, etarget.y, etarget.z)
							etarget.Knockback(1,user.dir)
							etarget.Dec_Stam(1000,0,user)
							etarget.curwound+=1
							Blood2(etarget)
							del(x)*/

				spawn()
					var/eicon='icons/snakehands.dmi'
					var/estate=""
					var/conmult = user.ControlDamageMultiplier()
					var/mob/human/player/etarget = user.NearestTarget()

					if(!etarget)
						etarget=straight_proj(eicon,estate,8,user)
						if(etarget)
							var/ex=etarget.x
							var/ey=etarget.y
							var/ez=etarget.z
							spawn()Poof(etarget)
							spawn()AOE(ex,ey,ez,1,(1000 +0*conmult),20,user,3,.3)
						//	spawn()Fire(ex,ey,ez,1,20)
						//	spawn()Knockback(1,etarget.dir)
							spawn()Blood2(etarget)
					else
						var/ex=etarget.x
						var/ey=etarget.y
						var/ez=etarget.z
						var/mob/x=new/mob(locate(ex,ey,ez))

						projectile_to(eicon,estate,user,x)
						del(x)
						spawn()Poof(etarget)
						spawn()AOE(ex,ey,ez,1,(1000 +0*conmult),20,user,3,.3)
					//	spawn()Fire(ex,ey,ez,1,20)
					//	spawn()Knockback(1,etarget.dir)
						spawn()Blood2(etarget)
					user.icon_state=""

		many_snake_hands
			id = MANY_SNAKE_HANDS
			name = "Snake: Many Hidden Shadow Snake Hands"
			icon_state = "snake_hands2"
			default_chakra_cost = 450
			default_cooldown = 55
			default_seal_time = 10

			Use(mob/human/user)

				viewers(user) << output("[user]: Snake: Many Hidden Shadow Snake Hands!", "combat_output")

				spawn()
					var/eicon='icons/snakehands.dmi'
					var/estate=""
					var/conmult = user.ControlDamageMultiplier()
					var/mob/human/player/etarget = user.NearestTarget()

					var/numOfHosenkas = 5

					for (var/i = 0; i < numOfHosenkas; i++)
						if(!etarget)
							etarget=straight_proj(eicon,estate,8,user)
							if(etarget)
								Poof()
						else
							var/ex=etarget.x
							var/ey=etarget.y
							var/ez=etarget.z
							var/mob/x=new/mob(locate(ex,ey,ez))

							projectile_to(eicon,estate,user,x)
							del(x)
							spawn()Poof(etarget)
							spawn()AOE(ex,ey,ez,1,(1000 +0*conmult),20,user,3,.3)
						//	spawn()Fire(ex,ey,ez,1,20)
						//	spawn()Knockback(1,etarget.dir)
							spawn()Blood2(etarget)


		skin_shedding
			id = SKIN_SHEDDING
			name = "Snake: Skin Shedding"
			icon_state = "skin_shed"
			default_chakra_cost = 2000
			default_cooldown = 400
			default_seal_time = 25

			Use(mob/human/user)
				if(!user.skinowner)
					return
				else
					viewers(user) << output("[user]: Snake: Skin Shedding!", "combat_output")
					Poof(user.x, user.y, user.z)
					new/mob/corpse(user.loc,user)
					user.curwound=0
					user.icon = user.icon
					user.name = user.name
					user.overlays= user.overlays
					user.mouse_over_pointer = user.mouse_over_pointer
				//	user.henged = 1


					user.transform_chat_icon = user.faction.chat_icon


					user.CreateName(255, 255, 255)
					user.skinowner=0

		skin_wear
			id = SKIN_WEAR
			name = "Snake: Skin Pick Up"
			icon_state = "skin_wear"
			default_chakra_cost = 1000
			default_cooldown = 150
			default_seal_time = 10

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.carrying.len)
						Error(user, "You have to be carrying a discarded skin or corpse to use this jutsu")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Snake: Skin Pick Up!", "combat_output")

		//		var/mob/human/player/etarget = user.MainTarget()

				for(var/mob/corpse/C in oview(10,user))
					if(user.carrying.Find(C))
						Poof(user.x, user.y, user.z)
					//	new/mob/corpse(user.loc,user)

						user.icon = C.icon
						user.name = C.name
						user.overlays= C.overlays
						user.mouse_over_pointer = C.mouse_over_pointer
				//		user.henged = 1

						user.CreateName(255, 255, 255)
						user.skinowner=1