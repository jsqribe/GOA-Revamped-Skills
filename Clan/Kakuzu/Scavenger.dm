skill
	scavenger
		copyable = 0




		heart_extraction
			id = HEART_EXTRACTION
			name = "Heart Extraction"
			icon_state = "heart_extraction"
			default_chakra_cost = 200
			default_cooldown = 40


			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.carrying.len)
						Error(user, "You have to be carrying a corpse to use this Jutsu")
						return 0
					if(user.hearts>=6)
						Error(user, "You have reached your Maximum Capacity on Hearts")
						return 0


			Use(mob/user)
				for(var/mob/corpse/C in oview(1,user))
					if(user.carrying.Find(C))
						user.dir=get_dir(user,C)
						user.icon_state="Throw2"
						user.stunned=3
						sleep(30)
						Blood2(C)
						if(!user) return
						user.hearts+=1
						user.combat("You have taken [C]'s Heart! You now have a Total of [user.hearts] hearts.")
						user.icon_state=""
						spawn(5)
							if(C)del(C)
						user.stunned=0
						if(user.hearts > 6)
							user.hearts = 6
						break

		generate_heart
			id = GENERATE_HEART
			name = "Heart Generation"
			icon_state = "heart_extraction"
			default_chakra_cost = 400
			default_cooldown = 80

			IsUsable(mob/user)
				.=..()
				if(.)
					if(user.hearts>= 5)
						Error(user, "You have reached your Maximum Capacity on Hearts")
						return 0

			Use(mob/user)
				if(user)
					user.stunned = 20
					spawn(200)
						if(user.stunned)
							user.stunned=0
					user.combat("You have successfully generated an artifical heart.")
					user.hearts+= 1
					user.combat("You now have [user.hearts] hearts.")
					if(user.hearts > 6)
						user.hearts = 6




		earth_grudge_needles
			id = KAKUZU_NEEDLE
			name = "Earth Grudge Needle"
			icon_state = "needle"
			default_chakra_cost = 200
			default_cooldown = 50

			Use(mob/human/user)
				viewers(user) << output("[user]: Earth Grudge Needles!", "combat_output")

				user.stunned=3

				user.overlays+='icons/kakuzuoverlay.dmi'
				user.icon_state="Throw1"
				sleep(3)

				var/conmult = user.ControlDamageMultiplier()
				var/obj/trailmaker/o=new/obj/trailmaker/Kakuzu_Trail()
				var/mob/result=Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,20,user)
				if(result)
					del(o)
					result.Damage((780 + 350*conmult),0,user)
					result.stunned = 2
					result.Poison+=rand(0,15)
					spawn()result.Wound(rand(0,10),1,user)
					spawn()Blood2(result,user)
					spawn()result.Hostile(user)
					result.move_stun=50
					spawn(10)
						user.stunned=0
						user.overlays-='icons/kakuzuoverlay.dmi'
						user.icon_state=""
				else
					user.stunned=0
					user.overlays-='icons/kakuzuoverlay.dmi'
					user.icon_state=""


		lightning_mask
			id = LIGHTNING_MASK
			name = "Lightning Mask"
			icon_state = "lm"
			default_chakra_cost = 250
			default_cooldown = 50

			IsUsable(mob/user)
				.=..()
				if(.)
					if(!user.hearts >= 4)
						Error(user, "You need more hearts to be able to use the water mask")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning Mask!", "combat_output")

				var/v=new/obj/masks/lightning(locate(user.x,user.y,user.z))
				for(var/obj/masks/lightning/x in world)
					x.dir=user.dir
					var/obj/trailmaker/o=new/obj/trailmaker/Raton_Sword()
					var/mob/result=Trail_Straight_Projectile(x.x,x.y,x.z,x.dir,o,14,user)
					if(result)
						del(o)
						result.Damage(rand(0,2000),1,user)
						result.stunned = 2
						spawn()result.Wound(rand(0,5),1,user)
						spawn()Blood2(result,user)
						spawn()result.Hostile(user)
						result.move_stun=50
						spawn(50)
							result.stunned=0
							del(v)
							del(x)
					else
						if(!result)
							del(v)
							del(x)
							default_cooldown = 35
							return

		wind_mask
			id = WIND_MASK
			name = "Wind Mask"
			icon_state = "wm"
			default_chakra_cost = 200
			default_cooldown = 50

			IsUsable(mob/user)
				.=..()
				if(.)
					if(!user.hearts >= 3)
						Error(user, "You need more hearts to be able to use the water mask")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Wind Mask!", "combat_output")

				var/random_ability = pick(1,2)
				var/v=new/obj/masks/wind(locate(user.x,user.y,user.z))
				for(var/obj/masks/wind/x in world)

					if(random_ability == 1)
						var/dir = x.dir
						var/mob/human/player/etarget = user.MainTarget()
						if(etarget)
							dir = angle2dir_cardinal(get_real_angle(x, etarget))
							x.dir = dir
						spawn()
							WaveDamage(user,3,(100*user.ControlDamageMultiplier()),3,14)
						Gust(x.x,x.y,x.z,x.dir,3,14)
					else
						spawn()
							var/mob/human/M = user.MainTarget()
							var/obj/Q = new/gale_storm(get_step(x, x.dir))
							Q.owner = x
							Q.dir = x.dir
							spawn()
								var/time = 10
								while(x && M && Q && time > 0)
									step_to(Q, M, 1)
									time--
									sleep(3)
								if(Q)
									Q.overlays = 0
									Q.icon = 0
									Q.loc = null
									del(x)
									del(v)

					spawn(50)
						del(x)
						del(v)

		water_mask
			id = WATER_MASK
			name = "Water Mask"
			icon_state = "wam"
			default_chakra_cost = 250
			default_cooldown = 50
			default_seal_time = 3

			IsUsable(mob/user)
				.=..()
				if(.)
					if(!user.hearts >= 2)
						Error(user, "You need more hearts to be able to use the water mask")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Water Mask!", "combat_output")

				var/v=new/obj/masks/water(locate(user.x,user.y,user.z))
				var/conmult = user.ControlDamageMultiplier()
				var/random = pick(1,2)
				for(var/obj/masks/water/x in world)
					x.dir=user.dir

					if(random == 1)
						spawn()wet_proj(x.x,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),6)
						if(x.dir==NORTH||x.dir==SOUTH)
							spawn()wet_proj(x.x+1,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x-1,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x+2,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x-2,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x+3,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x-3,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x+4,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x-4,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x+5,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x-5,x.y,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
						if(x.dir==EAST||x.dir==WEST)
							spawn()wet_proj(x.x,x.y+1,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y-1,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y+2,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y-2,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y+3,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y-3,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y+4,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y-4,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y+5,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
							spawn()wet_proj(x.x,x.y-5,x.z,'icons/watershockwave.dmi',"",user,14,(1000+200*conmult),0)
					else
						spawn()wet_proj(x.x,x.y,x.z,'icons/watervortex.dmi',"",user,9,(200*conmult+700),2)
						if(user.dir==NORTH||user.dir==SOUTH)
							spawn()wet_proj(x.x+1,x.y,x.z,'icons/watervortex.dmi',"",user,9,(225*conmult+200),0)
							spawn()wet_proj(x.x-1,x.y,x.z,'icons/watervortex.dmi',"",user,9,(225*conmult+200),0)
						if(user.dir==EAST||user.dir==WEST)
							spawn()wet_proj(x.x,x.y-1,x.z,'icons/watervortex.dmi',"",user,9,(225*conmult+200),0)
							spawn()wet_proj(x.x,x.y+1,x.z,'icons/watervortex.dmi',"",user,9,(225*conmult+200),0)

					spawn(50)
						del(x)
						del(v)

		fire_mask
			id = FIRE_MASK
			name = "Fire Mask"
			icon_state = "fm"
			default_chakra_cost = 250
			default_cooldown = 50
			default_seal_time = 4

			IsUsable(mob/user)
				.=..()
				if(.)
					if(!user.hearts >= 5)
						Error(user, "You need more hearts to be able to use the water mask")
						return 0

			Use(mob/human/user)
				var/v=new/obj/masks/fire(locate(user.x,user.y,user.z))
				for(var/obj/masks/fire/x in world)

					x.overlays+='icons/breathfire2.dmi'
					var/dir = x.dir
					var/mob/human/player/etarget = user.NearestTarget()
					if(etarget)
						dir = angle2dir_cardinal(get_real_angle(x, etarget))
						x.dir = dir
					var/conmult = user.ControlDamageMultiplier()

					if(dir==NORTH)
						spawn()AOE(x.x,x.y+5,x.z,4,(80+20*conmult),90,user,2,1)
						spawn()Ash(x.x,x.y+5,x.z,100)
					if(dir==SOUTH)
						spawn()AOE(x.x,x.y-5,x.z,4,(80+20*conmult),90,user,2,1)
						spawn()Ash(x.x,x.y-5,x.z,100)
					if(dir==EAST)
						spawn()AOE(x.x+5,x.y,x.z,4,(80+20*conmult),90,user,2,1)
						spawn()Ash(x.x+5,x.y,x.z,100)
					if(dir==WEST)
						spawn()AOE(x.x-5,x.y,x.z,4,(80+20*conmult),90,user,2,1)
						spawn()Ash(x.x-5,x.y,x.z,100)
					spawn(50)
						x.overlays-='icons/breathfire2.dmi'
						del(x)
						del(v)
obj/masks
	lightning
		icon='icons/lightning_puppet.dmi'
	fire
		icon='icons/fire_puppet.dmi'
	wind
		icon='icons/wind_puppet.dmi'
	water
		icon='icons/water_puppet.dmi'
gale_storm

	parent_type = /obj

	icon = 'icons/gale storm.dmi'
	icon_state = "middle"

	layer = MOB_LAYER + 0.1
	density = 0

	New(loc)
		..(loc)

		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "top_left", pixel_x = -32, pixel_y = 32)
		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "top_middle", pixel_y = 32)
		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "top_right", pixel_x = 32, pixel_y = 32)

		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "middle_left", pixel_x = -32)
		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "middle_right", pixel_x = 32)

		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "bottom_left", pixel_x = -32, pixel_y = -32)
		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "bottom_center", pixel_y = -32)
		overlays += image(icon = 'icons/gale storm.dmi', icon_state = "bottom_right", pixel_x = 32, pixel_y = -32)

		spawn(150)
			if(src)
				loc = null

	Move()
		..()

		spawn()

			for(var/mob/M in view(1, src))
				if(M != src.owner)
					M:Damage(rand(1000, 2100) + rand(300, 500) * src.owner:ControlDamageMultiplier(), 1, src.owner)
					M.Knockback(3, src.dir)