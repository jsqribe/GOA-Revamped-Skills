skill
	water

		copyable = 1

		giant_vortex
			id = SUITON_VORTEX
			name = "Water: Giant Vortex"
			description = "Creates a small pool of water."
			icon_state = "giant_vortex"
			default_chakra_cost = 200
			default_cooldown = 60
			default_seal_time = 15
			stamina_damage_fixed = list(250, 250)
			stamina_damage_con = list(750, 750)



			Use(mob/human/user)
				viewers(user) << output("[user]: Water: Giant Vortex!", "combat_output")

				var/conmult = user.ControlDamageMultiplier()

				spawn() user.Timed_Stun(15)
				spawn()wet_proj(user.x,user.y,user.z,'icons/watervortex.dmi',"",user,9,(225*conmult+700),2)
				if(user.dir==NORTH||user.dir==SOUTH)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watervortex.dmi',"",user,9,(250+750*conmult),0)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watervortex.dmi',"",user,9,(250+750*conmult),0)
				if(user.dir==EAST||user.dir==WEST)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watervortex.dmi',"",user,9,(250+750*conmult),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watervortex.dmi',"",user,9,(250+750*conmult),0)




		bursting_water_shockwave
			id = SUITON_SHOCKWAVE
			name = "Water: Bursting Water Shockwave"
			description = "Creates a large pool of water."
			icon_state = "exploading_water_shockwave"
			default_chakra_cost = 500
			default_cooldown = 120
			default_seal_time = 20
			stamina_damage_fixed = list(500, 500)
			stamina_damage_con = list(1000, 1000)



			Use(mob/human/user)
				viewers(user) << output("[user]: Water: Bursting Water Shockwave!", "combat_output")

				var/conmult = user.ControlDamageMultiplier()

				spawn() user.Timed_Stun(30)
				spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),6)
				if(user.dir==NORTH||user.dir==SOUTH)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
				if(user.dir==EAST||user.dir==WEST)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,14,(500+1000*conmult),0)


		syrup_capture
			id = SUITON_SYRUP_CAPTURE
			name = "Water: Starch Syrup Capture Field"
			description = "Creates a small pool of water that is infused with chakra, slowing or stopping your opponents in their tracks."
			icon_state = "syrup_capture"
			default_chakra_cost = 500
			default_cooldown = 60
			default_seal_time = 15



			Use(mob/human/user)
				viewers(user) << output("[user]: Water: Starch Syrup Capture Field!", "combat_output")

				spawn() user.Timed_Stun(10)
				spawn()wet_proj(user.x,user.y,user.z,'icons/watervortex2.dmi',"",user,9,0,2,1,dur=150)
				if(user.dir==NORTH||user.dir==SOUTH)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watervortex2.dmi',"",user,9,0,0,1,dur=150)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watervortex2.dmi',"",user,9,0,0,1,dur=150)
				if(user.dir==EAST||user.dir==WEST)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watervortex2.dmi',"",user,9,0,0,1,dur=150)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watervortex2.dmi',"",user,9,0,0,1,dur=150)


		water_dragon
			id = SUITON_DRAGON
			name = "Water: Water Dragon Projectile"
			description = "Creates a dragon of water that follows your enemy."
			icon_state = "water_dragon_blast"
			default_chakra_cost = 100
			default_cooldown = 90
			default_seal_time = 20
			stamina_damage_fixed = list(1250, 1250)
			stamina_damage_con = list(1500, 1500)



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!Iswater(user.loc))
						Error(user, "You must be standing on water to use this technique.")
						return 0

			DoSeals(mob/human/user)
				..()

			Use(mob/human/user)
				viewers(user) << output("[user]: Water: Water Dragon Projectile!", "combat_output")

				//user.Begin_Stun()
				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()

				if(etarget)
					var/obj/trailmaker/o=new/obj/trailmaker/Water_Dragon()
					var/mob/result=Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,etarget)
					if(result)
						result = result.Replacement_Start(user)
						result.Knockback(2,o.dir)
						spawn(1)
							o.loc = null
						result.Damage((1250+1500*conmult),0,user,"Water Dragon","Normal")
						spawn()result.Hostile(user)
						spawn(5) if(result) result.Replacement_End()
				else
					var/obj/trailmaker/o=new/obj/trailmaker/Water_Dragon()
					var/mob/result=Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,8)
					if(result)
						result = result.Replacement_Start(user)
						result.Knockback(2,o.dir)
						spawn(1)
							o.loc = null
						result.Damage((1250+1500*conmult),0,user,"Water Dragon","Normal")
						spawn()result.Hostile(user)
						spawn(5) if(result) result.Replacement_End()
				//user.End_Stun()




		collision_destruction
			id = SUITON_COLLISION_DESTRUCTION
			name = "Water: Collision Destruction"
			description = "Traps your enemy in a ball of turbulent water."
			icon_state = "watercollision"
			default_chakra_cost = 450
			default_cooldown = 70
			default_seal_time = 15
			stamina_damage_fixed = list(750, 750)
			stamina_damage_con = list(750, 750)


			DoSeals(mob/human/user)
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget) etarget.overlays+='icons/watersurround.dmi'
				spawn(40) if(etarget) etarget.overlays-='icons/watersurround.dmi'
				..()

			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/player/etarget = user.MainTarget()
					if(!etarget || (etarget && (etarget.sandshield || etarget.ko)))
						Error(user, "No Valid Target")
						return 0
					if(!user.NearWater(4))
						Error(user, "Must be near water")
						return 0


			Use(mob/human/user)
				user.Timed_Stun(20)
				spawn(20) user.icon_state=""
				viewers(user) << output("[user]: Water: Collision Destruction!", "combat_output")

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					user.icon_state="Seal"
					var/turf/L=etarget.loc
					sleep(3)
					etarget.overlays-='icons/watersurround.dmi'
					var/hit=0
					if(L && L==etarget.loc)
						etarget = etarget.Replacement_Start(user)
						hit=1
						etarget.Begin_Stun()

					var/obj/O =new(locate(L.x,L.y,L.z))
					O.layer=MOB_LAYER+3
					O.overlays+=image('icons/watercollisiondestruction.dmi',pixel_x=-16,pixel_y=-16)
					var/found=0

					for(var/obj/water/X in oview(4,user))
						found++
						break
					if(found>20)found=20
					if(hit && etarget)
						etarget.Damage(750+750*conmult+found*50,0,user,"Water Collision Destruction","Normal")
						spawn()etarget.Hostile(user)
					//half damage to those adjacent to the jutsu that aren't bunshins owned by the user,
					//or owned by the same owner as the bunshin using the jutsu
					for(var/mob/human/M in ohearers(1,O))
						var/bunshinimmune
						if(istype(M, /mob/human/player/npc/kage_bunshin))
							var/mob/human/player/npc/kage_bunshin/K = M
							if(user == K.owner)
								bunshinimmune = 1
							else if(istype(user, /mob/human/player/npc/kage_bunshin))
								var/mob/human/player/npc/kage_bunshin/B = user
								if(K.owner == B.owner)
									bunshinimmune = 1
						if(M != user && !bunshinimmune && !(M == etarget && hit))
							M = M.Replacement_Start(user)
							M.Damage(375+375*conmult+found*25,0,user,"Water Collision Destruction","Normal")
							M.Timed_Move_Stun(30)
							spawn(5) if(M) M.Replacement_End(user)
					spawn(50)
						if(etarget) etarget.End_Stun()
						spawn(5) if(etarget) etarget.Replacement_End()

						if(O) O.loc = null

		hidden_mist
			id = SUITON_HIDDEN_MIST
			name = "Water: Hidden Mist"
			description = "Create a dense mist which causes your enemies to have difficulty tracking you. This costs 200 less chakra if the user is near water."
			icon_state = "hidden_mist"
			default_chakra_cost = 650
			default_cooldown = 180
			default_seal_time = 15

			ChakraCost(mob/user)
				var/cost = default_chakra_cost
				if(user.NearWater(4))
					cost -= 200
				if(user.skillspassive[5])
					return round(cost * (1 - user.skillspassive[5] * 0.04))
				else
					return cost




			Use(mob/human/user)
				viewers(user) << output("[user]: Water: Hidden Mist! (not the final icon)", "combat_output")
				user.icon_state="Seal"
				user.Timed_Stun(20)
				spawn(20)
					user.icon_state=""
					user.hiddenmist=1
					user.HideInMist()

				var/size = 4

				if(user.con < 100) size = 3
				else if(user.con < 140) size = 4
				else if(user.con < 180) size = 5
				else if(user.con < 220) size = 6
				else if(user.con < 260) size = 7
				else if(user.con < 300) size = 8
				else if(user.con < 340) size = 9
				else if(user.con < 380) size = 10
				else if(user.con < 420) size = 11
				else if(user.con < 460) size = 12
				else if(user.con < 500) size = 13
				else if(user.con < 540) size = 14
				else if(user.con < 580) size = 15
				else if(user.con >= 620) size = 16
				MistSpread(user, user.loc, size=size, delay=3)



	water_prison
		id = SUITON_WATER_PRISON
		name = "Water Prison"
		description = "Traps your enemy in a prison of water so dense it has been compaired to steel."
		icon_state = "water_prison"
		default_chakra_cost = 100
		default_cooldown = 150
		default_seal_time = 2

		IsUsable(mob/user)
			. = ..()
			if(.)
				if(!Iswater(user.loc))
					Error(user, "You must be standing on water to use this technique.")
					return 0
				if(user.keys["shift"]) //x modifies this jutsu to have it target yourself, so having no target is OK
					modified = 1
					return 1
				var/mob/human/etarget = user.MainTarget()
				var/distance = get_dist(user, etarget)
				if(etarget && !etarget.ko && distance > 1)
					Error(user, "Target too far ([distance]/1 tiles)")
					return 0
				if(!etarget || (etarget && etarget.ko || etarget.chambered))
					for(var/mob/human/eX in get_step(user,user.dir))
						if(!eX.ko && !eX.IsProtected() && !eX.chambered)
							return 1 //target found
					Error(user, "No Valid Target")
					return 0

		Use(mob/human/player/user)
			viewers(user) << output("[user]: Water: Water Prison! (icon not complete)", "combat_output")
			if(modified)
				modified = 0
				var/obj/wp = new/obj
				wp.icon = 'icons/water_prison.dmi'
				wp.icon_state = "captured"
				flick("capturing",wp)
				wp.pixel_x -= 32
				wp.pixel_y -= 32
				wp.layer = MOB_LAYER
				wp.loc = user.loc
				user.icon_state = "Seal"
				user.Protect(50)
				user.Timed_Stun(50)
				sleep(50)
				user.icon_state = ""
				wp.loc = null
				return

			user.Timed_Stun(20)
			user.icon_state="Throw1"
			var/mob/human/gotcha
			var/turf/getloc

			var/mob/human/etarget = user.MainTarget()
			if(etarget && !etarget.ko && !(get_dist(user, etarget) > 1))
				user.FaceTowards(etarget)
			else
				for(var/mob/human/eX in get_step(user,user.dir))
					if(!eX.ko && !eX.IsProtected() && !eX.chambered)
						etarget = eX
						break

			var/obj/wp = new/obj
			wp.dir = user.dir
			wp.icon = 'icons/water_prison.dmi'
			wp.icon_state = "start"
			spawn(4)
				wp.icon_state = "capturing"
				spawn(5)
					wp.icon_state = "captured"
			wp.pixel_x -= 32
			wp.pixel_y -= 32
			wp.layer = MOB_LAYER

			gotcha=etarget.Replacement_Start(user)
			wp.loc = gotcha.loc
			gotcha.Timed_Move_Stun(30)
			if(gotcha != etarget)
				wp.loc = null
				user.icon_state=""
				spawn(5) if(gotcha) gotcha.Replacement_End()
				return
			getloc=locate(etarget.x,etarget.y,etarget.z)

			user.FaceTowards(gotcha)
			user.Timed_Stun(5)
			user.water_prison = 1
			user.usemove = 1
			user.FaceTowards(gotcha)
			gotcha.water_prison = 2
			gotcha.Begin_Stun()
			gotcha.icon_state = "Hurt"
			gotcha.Hostile(user)
			var/turf/q=user.loc
			while(user && user.usemove && user.curchakra > 15 && gotcha && !gotcha.ko && gotcha.loc==getloc && (abs(user.x-gotcha.x)*abs(user.y-gotcha.y))<=1 && user.x==q.x && user.y==q.y)
				gotcha.Protect(5)
				if(gotcha.staminaregen > -100)
					if(gotcha.staminaregen <= -97)
						gotcha.staminaregen = -100
					else
						gotcha.staminaregen -= 4
				if(gotcha.curstamina<=0)
					gotcha.curstamina=0
					spawn() gotcha.KO()
				user.curchakra -= 50
				sleep(5)
			if(gotcha)
				wp.loc = null
				if(!gotcha.ko) icon_state = ""
				gotcha.water_prison = 0
				gotcha.RecalculateStats()
				gotcha.End_Stun()
			user.icon_state=""
			user.water_prison = 0

	water_bullet
		id = SUITON_WATER_BULLET
		name = "Water Bullet"
		description = "Fires a water projectile at your opponent"
		icon_state = "water_bullet"
		default_chakra_cost = 250
		base_charge = 50
		default_cooldown = 30
		default_seal_time = 10
		stamina_damage_fixed = list(120, 120)
		stamina_damage_con = list(40, 40)

		Use(mob/human/player/user)
			viewers(user) << output("[user]: Water: Water Bullet!", "combat_output")
			var/damage = 120+40*user.ControlDamageMultiplier()

			var/eicon='icons/water_bullet.dmi'
			var/estate="small"

			//snd(user,'sounds/chidori_static1sec.wav',vol=30)
			var/mob/human/player/etarget = user.NearestTarget()

			var/speed = 40
			var/angle

			var/times = charge/200
			user.icon_state="Seal"
			spawn(times*2) user.icon_state=""
			//user.Timed_Stun(times*2)
			for(var/i=0,i <= times, i++)
				if(etarget)
					angle = get_real_angle(user, etarget)
					user.dir = angle2dir_cardinal(angle)
				else angle = dir2angle(user.dir)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+1*rand(-4,4), distance=10, damage=damage, wounds=0)
				sleep(2)
