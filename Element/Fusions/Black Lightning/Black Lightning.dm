skill
	storm
		copyable = 0


		black_current
			id = BLACK_CURRENT
			name = "Black Lightning: Lightning Surge!"
			icon_state = "black"
			default_chakra_cost = 300
			default_cooldown = 45
			face_nearest = 2

			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning: Chidori Current!", "combat_output")

				var/conmult = user.ControlDamageMultiplier()

				if(!user.waterlogged)
					spawn()
						spawn()Black(user.x,user.y,user.z,30)
						spawn()Black(user.x+1,user.y,user.z,30)
						spawn()Black(user.x-1,user.y,user.z,30)
						spawn()Black(user.x,user.y+1,user.z,30)
						spawn()Black(user.x,user.y-1,user.z,30)
						spawn()Black(user.x+1,user.y+1,user.z,30)
						spawn()Black(user.x-1,user.y+1,user.z,30)
						spawn()Black(user.x+1,user.y-1,user.z,30)
						spawn()Black(user.x-1,user.y-1,user.z,30)
						spawn()Black(user.x+2,user.y,user.z,30)
						spawn()Black(user.x-2,user.y,user.z,30)
						spawn()Black(user.x,user.y+2,user.z,30)
						spawn()Black(user.x,user.y-2,user.z,30)
						spawn()Black(user.x+2,user.y+2,user.z,30)
						spawn()Black(user.x-2,user.y+2,user.z,30)
						spawn()Black(user.x+2,user.y-2,user.z,30)
						spawn()Black(user.x-2,user.y-2,user.z,30)
						spawn()Black(user.x+2,user.y+1,user.z,30)
						spawn()Black(user.x-1,user.y+2,user.z,30)
						spawn()Black(user.x+1,user.y-2,user.z,30)
						spawn()Black(user.x-2,user.y-1,user.z,30)
						spawn()Black(user.x+2,user.y-1,user.z,30)
						spawn()Black(user.x-2,user.y+1,user.z,30)
						spawn()Black(user.x+1,user.y+2,user.z,30)
						spawn()Black(user.x-1,user.y-2,user.z,30)
					spawn()AOExk(user.x,user.y,user.z,2,(300+550*conmult),30,user,0,1.5,1)
					Black(user.x,user.y,user.z,30)

				user.stunned=0
				user.icon_state=""

		/*laser_circus
			id = LASER_CIRCUS
			name = "Chidori Current"
			icon_state = "laser"
			default_chakra_cost = 200
			default_cooldown = 10
			stamina_damage_fixed = list(100, 100)
			stamina_damage_con = list(50, 50)


			Use(mob/human/user)
				//var/obj/b1=new/obj/chidori_current(locate(user.x,user.y,user.z))
	//			var/time = 4
				var/eicon = 'laserend.dmi'
				var/estate
				var/speed = 96
				var/angle
				var/dmgz = 100+150*user.ControlDamageMultiplier()

				charge2 = 1
				spawn()
					user.Begin_Stun()
					while(charge2 && user.curchakra >= 200)
						user.curchakra-=200
						//user.Begin_Stun()
						user.icon_state="Throw2"
						spawn() advancedprojectile_angle(eicon, estate, user, speed, angle, distance=10, damage=dmgz, wounds=1)
					//	AOEcc(user.x,user.y,user.z,2,100+150*user.ControlDamageMultiplier(),(50+25*user.ControlDamageMultiplier()),1,user,0,1,0)
						//time--
						CHECK_TICK
					if(!charge2 || user.curchakra < 200)
						user.End_Stun()
					//	b1.loc=null
						user.icon_state=""*/

/*		laser_circus
			id = LASER_CIRCUS
			name = "Storm Release: Laser Circus"
			icon_state = "laser"
			default_cooldown = 100

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				viewers(user) << output("[user]: Storm Release: Laser Circus!", "combat_output")

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					user.overlays+=image('icons/lasercircus.dmi')
					user.icon_state="Throw2"
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Lasercircus(locate(user.x,user.y,user.z))
						var/mob/result = Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,etarget,1,1,0,0,1,user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(600,(900+300*conmult)),user,"Laser Circus","Normal")
							o.loc = null
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(100)
								spawn()Blood2(result,user)
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Lasercircus(locate(user.x+16,user.y+16,user.z))
						var/mob/result = Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,etarget,1,1,0,0,1,user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(600,(900+300*conmult)),user,"Laser Circus","Normal")
							o.loc = null
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(100)
								spawn()Blood2(result,user)
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Lasercircus(locate(user.x-16,user.y-16,user.z))
						var/mob/result = Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,etarget,1,1,0,0,1,user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(600,(900+300*conmult)),user,"Laser Circus","Normal")
							o.loc = null
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(100)
								spawn()Blood2(result,user)
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
							user.overlays-=image('icons/lasercircus.dmi')
				else
					user.overlays+=image('icons/lasercircus.dmi')
					user.icon_state="Throw2"
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Lasercircus(locate(user.x,user.y,user.z))
						var/mob/result = Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,14,user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(600,(900+300*conmult)),user,"Laser Circus","Normal")
							o.loc = null
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(100)
								spawn()Blood2(result,user)
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Lasercircus(locate(user.x+16,user.y+16,user.z))
						var/mob/result = Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,14,user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(600,(900+300*conmult)),user,"Laser Circus","Normal")
							o.loc = null
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(100)
								spawn()Blood2(result,user)
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Lasercircus(locate(user.x-16,user.y-16,user.z))
						var/mob/result = Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,14,user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(600,(900+300*conmult)),user,"Laser Circus","Normal")
							o.loc = null
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(100)
								spawn()Blood2(result,user)
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
							user.overlays-=image('icons/lasercircus.dmi')
*/

		black_panther
			id = BLACK_PANTHER
			name = "Black Lightning: Black Panther"
			icon_state = "panther"
			default_chakra_cost = 800
			default_cooldown = 100
			default_seal_time = 3
			var/used_chakra = 0

			ChakraCost(mob/user)
				used_chakra = user.curchakra
				if(used_chakra > default_chakra_cost)
					return used_chakra
				else
					return default_chakra_cost

			Use(mob/human/user)
				var/mob/human/player/etarget = user.MainTarget()
				var/conmult = user.ControlDamageMultiplier()
				user.icon_state="Chakra"
				user.overlays+=('icons/blackpantheraura.dmi')
				spawn(15)
				user.icon_state="Seal"
				user.Timed_Stun(15)
				spawn(5)
				user.icon_state=""
				if(etarget)
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/BlackPanther(locate(user.x,user.y,user.z))
						var/panther_result=Roll_Against(user.con+user.conbuff-user.conneg,etarget.con+etarget.conbuff-etarget.conneg,60)
						var/mob/result = Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,etarget,1,1,0,0,1,user)
						if(result)
							if(panther_result>=3)
								result.Damage(900, (rand(1000,1500)+600*conmult), 0, user)
								result.Wound(rand(0, 15), 0, user)
								spawn()result.Hostile(user)
							if(panther_result==2)
								result.Damage(900, (rand(450,700)+500*conmult), 0, user)
								result.Wound(rand(0, 10), 0, user)
								spawn()result.Hostile(user)
							if(panther_result==2)
								result.Damage(900, (rand(250,500)+400*conmult), 0, user)
								result.Wound(rand(0, 5), 0, user)
								spawn()result.Hostile(user)
						del(o)

						user.overlays-=('icons/blackpantheraura.dmi')


/*obj
	lasercircus
		Move()
			return
		New(mob/human/user,charge)
			var/conmult = user.ControlDamageMultiplier()
			var/mob/human/player/etarget = user.MainTarget()
			while(user&&charge>=500)
				user.Timed_Stun(15)
				charge-=500
				spawn()
					var/obj/trailmaker/o=new/obj/trailmaker/Lasercircus(locate(user.x,user.y,user.z))
					CHECK_TICK
					var/mob/result = Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,etarget,1,1,0,0,1,user)
					if(result)
						del(o)
						result.Damage(rand(500, (1250+650*conmult)), 0, user)
						result.Wound(rand(2, 5), 0, user)
						if(!result.ko && !result.protected)
							spawn()Blood2(result,user)
							//o.icon_state="still"
							spawn()result.Hostile(user)
				sleep(rand(3,5))*/


obj/trailmaker
	BlackPanther
		density=1
		layer=MOB_LAYER
		icon='icons/raiton_wolf.dmi'
		icon_state="trail"
		pixel_y=-10
		Move()
			var/turf/old_loc = src.loc
			var/d = ..()
			spawn()
				if(d)
					var/obj/O = new(old_loc)
					O.dir = src.dir
			/*		var/obj/m=new/obj/trail/blackpanther(O)
					m.dir=O.dir
					m.icon_state="patch"
					var/obj/n=new/obj/trail/blackpanther(O)
					n.dir=O.dir
					n.icon_state="patch"*/
					var/dir_angle = dir2angle(O.dir)
					var/dir_y = round(sin(dir_angle), 1)
					var/dir_x = round(cos(dir_angle), 1)

					src.pixel_y = 32 * dir_y
					src.pixel_x = 32 * dir_x

					O.pixel_y = 16 * dir_y
					O.pixel_x = 16 * dir_x

			/*		m.pixel_y = -32 * dir_y
					m.pixel_x = -32 * dir_x

					n.pixel_y = 32 * dir_y
					n.pixel_x = 32 * dir_x*/
				//	O.underlays+=m
				//	spawn(1)O.underlays+=n
					O.icon = 'icons/raiton_wolf.dmi'
					O.icon_state = "trail"
					src.trails += O
			return d

		Del()
			for(var/obj/o in src.trails)
				o.loc = null
			..()