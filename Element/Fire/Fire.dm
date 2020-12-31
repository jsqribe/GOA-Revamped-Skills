skill
	fire
		face_nearest = 1
		copyable = 1
		element_reqs = list("Fire")

		katon_element
			id = KATON_ELEMENT
			icon_state = "katon"
			name = "Fire: Element Control"
			description = "Allows you to control the fire element and use explosive jutsu."
			stack = "false"//don't stack
			element=1

		grand_fireball
			id = KATON_FIREBALL
			name = "Fire: Grand Fireball"
			description = "Creates a large fireball, dealing burst damage and damage over time to anyone caught in it."
			icon_state = "grand_fireball"
			default_chakra_cost = 150
			default_cooldown = 60
			default_seal_time = 5
			stamina_damage_fixed = list(200, 300)
			stamina_damage_con = list(100, 150)
			wound_damage_fixed = list(2, 3)
			wound_damage_con = list(1, 1)
			skill_reqs = list(KATON_ELEMENT)

			Use(mob/human/user)
				viewers(user) << output("[user]: Fire: Grand Fireball!", "combat_output")
				var/conmult = user.ControlDamageMultiplier()

				user.Timed_Stun(5)
				user.icon_state = "Seal"
				spawn(5) user.icon_state = ""
				var/mob/human/player/etarget = user.NearestTarget()
				if(etarget) user.FaceTowards(etarget)
				var/dir = user.dir
				var/xmod = 0
				var/ymod = 0
				switch(dir)
					if(NORTH)
						ymod = 3
					if(SOUTH)
						ymod = -3
					if(EAST)
						xmod = 3
					if(WEST)
						xmod = -3
					if(NORTHEAST)
						ymod = 3
						xmod = 3
					if(NORTHWEST)
						ymod = 3
						xmod = -3
					if(SOUTHWEST)
						ymod = -3
						xmod = -3
					if(SOUTHEAST)
						ymod = -3
						xmod = 3

				var/obj/x = new/obj
				x.loc = locate(user.x + xmod, user.y + ymod, user.z)
				x.dir = user.dir
				x.icon = 'icons/Gouk.dmi'
				x.layer = MOB_LAYER+2
				x.pixel_x = -64
				x.pixel_y = -64
				flick("fireball",x)
				//snd(x,'sounds/fireball.wav',vol=30)
				spawn(10) x.loc = null
				//var/turf/x= locate(user.x + xmod, user.y + ymod, user.z)
				for(var/mob/human/M in hearers(2,x))
					spawn(2)
						if(M)
							M = M.Replacement_Start(user)
							if(M.yonbi==1)
								M.Damage(round(rand(280,420)+rand(140,210)*conmult),rand(0,1)+conmult,user,"Fire:Grand Fireball","Normal")
							else
								M.Damage(round(rand(200,300)+rand(100,150)*conmult),rand(0,1)+conmult,user,"Fire:Grand Fireball","Normal")
							M.BurnDOT(user,15*conmult)
							M.Hostile(user)
							spawn(5) if(M) M.Replacement_End()
				for(var/obj/smoke/s in view(2,x))
					spawn()
						if(!s.ignited) s.Ignite(s,s.loc)



		hosenka
			id = KATON_PHOENIX_FIRE
			name = "Fire: Hôsenka"
			description = "Throws a small fireball, dealing burst damage and damage over time."
			icon_state = "katon_phoenix_immortal_fire"
			default_chakra_cost = 50
			default_cooldown = 10
			stamina_damage_fixed = list(200, 300)
			stamina_damage_con = list(60, 90)
			wound_damage_fixed = list(1, 2)
			wound_damage_con = list(0.5, 0.5)
			skill_reqs = list(KATON_ELEMENT)


			Use(mob/human/user)
				user.icon_state="Seal"

				viewers(user) << output("[user]: Fire: Hôsenka!", "combat_output")

				spawn()
					var/eicon='icons/fireball.dmi'
					var/estate=""
					var/conmult = user.ControlDamageMultiplier()
					var/mob/human/player/etarget = user.NearestTarget()

					if(!etarget)
						etarget=straight_proj(eicon,estate,8,user,1,1)
						if(etarget)
							var/ex=etarget.x
							var/ey=etarget.y
							var/ez=etarget.z
							//spawn()AOE(ex,ey,ez,1,(100 +30*conmult),20,user,3,1)
							//Fire(ex,ey,ez,1,4)
							var/obj/h = new/obj(locate(ex,ey,ez))
							h.icon = 'icons/hosenka.dmi'
							h.icon_state = "Explosion"
							//snd(h,'sounds/explosion_fire.wav',vol=30)
							h.layer = MOB_LAYER + 0.1
							h.pixel_x -= 16
							h.pixel_y -= 16
							spawn(10) h.loc = null
							for(var/mob/human/M in hearers(1,etarget))
								spawn()
									M = M.Replacement_Start(user)
									if(M.yonbi==1)
										M.Damage(round(rand(280,420)+rand(84,126)*conmult),rand(0,1)+round(conmult*0.5),user,"Fire: Hosenka","Normal")
									else
										M.Damage(round(rand(200,300)+rand(60,90)*conmult),rand(0,1)+round(conmult*0.5),user,"Fire: Hosenka","Normal")
									M.BurnDOT(user,10*conmult)
									M.Hostile(user)
									spawn(5) if(M) M.Replacement_End()
							for(var/obj/smoke/s in view(1,etarget))
								spawn()
									if(!s.ignited) s.Ignite(s,s.loc)
					else
						/*var/ex=etarget.x
						var/ey=etarget.y
						var/ez=etarget.z*/
						var/turf/x=etarget.loc

						projectile_to(eicon,estate,user,x)
						var/obj/h = new/obj(locate(x.x,x.y,x.z))
						h.icon = 'icons/hosenka.dmi'
						h.icon_state = "Explosion"
						//snd(h,'sounds/explosion_fire.wav',vol=30)
						h.layer = MOB_LAYER + 0.1
						h.pixel_x -= 16
						h.pixel_y -= 16
						spawn(10) h.loc = null
						for(var/mob/human/M in hearers(1,x))
							spawn()
								M = M.Replacement_Start(user)
								if(M.yonbi==1)
									M.Damage((420+90*conmult),rand(0,1)+round(conmult*0.5),user,"Fire: Hosenka","Normal")
								else
									M.Damage(300+90*conmult,rand(0,1)+round(conmult*0.5),user,"Fire: Hosenka","Normal")
								M.BurnDOT(user,10*conmult)
								M.Hostile(user)
								spawn(5) if(M) M.Replacement_End()
						for(var/obj/smoke/s in view(1,etarget))
							spawn()
								if(!s.ignited) s.Ignite(s,s.loc)
					user.icon_state=""



		burning_ash
			id = KATON_ASH_BURNING
			name = "Fire: Ash Accumulation Burning"
			description = "Creates a huge cloud of ash, slowing anyone caught in it. Igniting the ash will create rapid explosions across the ash dealing stamina and wound damage."
			icon_state = "katon_ash_product_burning"
			default_chakra_cost = 450
			default_cooldown = 120
			default_seal_time = 10
			stamina_damage_fixed = list(1000, 2000)
			stamina_damage_con = list(200, 300)
			wound_damage_fixed = list(0, 0)
			wound_damage_con = list(1, 4)
			skill_reqs = list(KATON_FIREBALL)


			Use(mob/human/user)
				viewers(user) << output("[user]: Fire: Ash Accumulation Burning!", "combat_output")

				user.icon_state="Seal"
				spawn(20) user.icon_state=""
				user.Timed_Stun(20)
				//snd(user,'sounds/blowing_ash.wav',vol=30)
				SmokeSpread(usr.loc, type="ash", size=4, delay=2, far=3)
				var/obj/trigger/ash_burning_product/T = new(user)
				user.AddTrigger(T)
				spawn(120) if(user) user.RemoveTrigger(T)


		fire_dragon_flaming_projectile
			id = KATON_DRAGON_FIRE
			name = "Fire: Fire Dragon Flaming Projectile"
			description = "Blows a small column of fire, dealing heavy damage to whoever it hits!"
			icon_state = "dragonfire"
			default_chakra_cost = 500
			default_cooldown = 70
			default_seal_time = 7
			stamina_damage_fixed = list(250, 2000)
			stamina_damage_con = list(1000, 1400)
			wound_damage_fixed = list(5, 40)
			wound_damage_con = list(1.5, 1.5)
			skill_reqs = list(KATON_PHOENIX_FIRE)


			Use(mob/human/user)
				user.icon_state="Seal"
				viewers(user) << output("[user]: Fire: Fire Dragon Flaming Projectile!", "combat_output")
				user.Begin_Stun()
				var/image/I2=image('icons/dragonfire.dmi',icon_state="overlay")
				user.overlays+=I2
				var/obj/trailmaker/o=new/obj/trailmaker/Dragon_Fire()
				o.layer=MOB_LAYER+2
				var/mob/result=Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,14,user)
				if(result)
					result = result.Replacement_Start(user)
					result.Timed_Move_Stun(45)

					spawn(45)
						o.loc = null
						user.overlays-=I2
						user.End_Stun()
					o.overlays+=image('icons/dragonfire.dmi',icon_state="hurt")
					var/turf/T=result.loc
					var/conmult = user.ControlDamageMultiplier()
					if(user.yonbi==1)
						result.Damage(round((rand(350,700))+1400*conmult),rand(2,5)+round(conmult),user,"Fire Dragon","Normal")
					else
						result.Damage(round(rand(250,500))+1000*conmult,rand(2,5)+round(conmult),user,"Fire Dragon","Normal")
					var/ie=3
					while(result&&T==result.loc && ie>0)
						ie--
						if(user.yonbi==1)
							result.Damage((rand(350,700)+140*conmult),rand(2,5)+round(conmult/2),user,"Fire Dragon","Normal")
						else
							result.Damage(rand(250,500)+100*conmult,rand(2,5)+round(conmult/2),user,"Fire Dragon","Normal")
						spawn()result.Hostile(user)
						sleep(15)
					spawn(5) if(result) result.Replacement_End()

				else
					user.End_Stun()
					user.overlays-=I2
				user.icon_state=""
		coiling_flame
			id = KATON_COILING_FLAME
			name = "Fire: Coiling Flame"
			description = "Sends a wave of fire forward from your weapon, burning enemies in its path."
			icon_state = "coiling_flame"
			default_chakra_cost = 110
			default_cooldown = 15
			default_seal_time = 2
			stamina_damage_fixed = list(350, 350)
			stamina_damage_con = list(150, 150)
			wound_damage_fixed = list(1, 2)
			wound_damage_con = list(0.3, 0.3)
			cost = 800
			skill_reqs = list(KATON_PHOENIX_FIRE)

			Use(mob/human/user)
				viewers(user) << output("[user]: Fire: Coiling Flame!", "combat_output")
				user.Timed_Stun(1)

				var/xdir

				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					xdir = angle2dir_cardinal(get_real_angle(user, etarget))
					user.dir = xdir
				else
					xdir = user.dir

				if(xdir==NORTHEAST || xdir==SOUTHEAST) xdir = EAST
				if(xdir==NORTHWEST || xdir==SOUTHWEST) xdir = WEST

				flick("w-attack",user)
				sleep(2)

				var/etype
				var/mag = 1
				for(var/obj/items/weapons/O in usr.contents)
					if(O.equipped==1&&O.weapon==1)
						etype = O.itype
				if(etype=="melee2")//knife
					mag = 2
				if(etype=="melee")//sword
					mag = 3

				var/conmult = user.ControlDamageMultiplier()
				spawn() FireWave(user.x,user.y,user.z,mag,xdir,8)
				if(user.yonbi==1)
					spawn(2) WaveDamage(user,mag,(490+210*conmult),rand(0,1)+conmult*0.3,6,burn=1)
				else
					spawn(2) WaveDamage(user,mag,(350+150*conmult),rand(0,1)+conmult*0.3,6,burn=1)

		katon_phoenix_nail_flower
			id = KATON_PHOENIX_NAIL_FLOWER
			name = "Fire: Phoenix Nail Flower"
			description = "Imbues shuriken with fire, setting your foes ablaze."
			icon_state = "katon_phoenix_nail_flower"
			default_chakra_cost = 200
			default_supply_cost = 1
			default_seal_time = 3
			default_cooldown = 30
			face_nearest = 1
			stamina_damage_fixed = list(50, 50)
			stamina_damage_con = list(20, 20)
			wound_damage_fixed = list(1, 2)
			wound_damage_con = list(0, 0)
			skill_reqs = list(KATON_COILING_FLAME)


			Use(mob/human/user)
				viewers(user) << output("[user]: Fire: Phoenix Nail Flower!", "combat_output")
				var/eicon='icons/chidorisenbon.dmi'
				var/estate="k-shuriken"

				//snd(user,'sounds/chidori_static1sec.wav',vol=30)
				user.Timed_Stun(3)
				user.icon_state="Seal"
				spawn(5)
					user.icon_state=""
				var/mob/human/player/etarget = user.NearestTarget()
				if(etarget)
					user.dir = angle2dir_cardinal(get_real_angle(user, etarget))

				var/angle
				var/speed = 32
				var/spread = 9
				if(etarget) angle = get_real_angle(user, etarget)
				else angle = dir2angle(user.dir)

				var/damage = 50+20*user.ControlDamageMultiplier()

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+1*rand(0,4), distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-1*rand(0,4), distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(10,14)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(10,14)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(12,16)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(12,16)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(18,22)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(18,22)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(21,25)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(21,25)/10, distance=10, damage=damage, wounds=rand(1,2), burn=damage/12)
