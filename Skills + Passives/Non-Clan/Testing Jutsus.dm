skill
	test
		copyable = 0

//WOOD-------------------------------

		wood_move
			id = wood_move
			name = "Wood Release: Forest Creation"
			description = "Binds your enemies with shadows."
			icon_state = "shadow_imitation"
			default_chakra_cost = 100
			default_cooldown = 5

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.MainTarget()
				if(.)
					if(!target || (target && target.ko))
						Error(user, "No Valid Target")
						return 0

			Use(mob/user)
				charge2 = 1
				var/hitinnocent
				var/modx
				var/mody
				var/lag=1
			//	var/obj/trailmaker/proj=new/obj/trailmaker/Woodz()
				var/mob/human/target = user.MainTarget()
				for(var/obj/SenjuuTree/ST in view(usr,5))
					if(ST.OwnedBy==user)
						ST.proj=new/obj/trailmaker/Woodz()
						spawn()
							//user.Begin_Stun()
							while(charge2)
								ST.proj.loc = locate(ST.x, ST.y, ST.z)
								ST.proj.dir = ST.dir
								ST.proj.density = 0

								if(modx == -1)
									ST.proj.dir = WEST
								else if(modx==1)
									ST.proj.dir=EAST
								if(mody==-1)
									ST.proj.dir |= SOUTH
								else if(mody==1)
									ST.proj.dir |= NORTH

								if(modx || mody)
									step(ST.proj, ST.proj.dir)
									CHECK_TICK
									step(ST.proj, ST.proj.dir)
									sleep(3)

								ST.proj.density = 1
							//	var/mob/hit 02/02/16
								while(target && ST.proj && charge2 > 0)// && !hit)
									ST.proj.dir = angle2dir(get_real_angle(ST.proj, target))

							//		var/hit_human = 0
									for(var/mob/human/R in get_step(ST.proj, ST.proj.dir))
										if(R && !R.mole)
										//	hit_human = 1
											R.Timed_Move_Stun(10)
											//R.move_stun += 10

							/*		if(hit_human)
										proj.density = 0*/

									step(ST.proj, ST.proj.dir)

								/*	if(hit_human)
										proj.density = 1*/

									for(var/mob/human/F in ST.proj.loc)
										if(F == target || (hitinnocent && F != user))
											//var/mob/hit = F 2016
											break

									sleep(1+lag)


						/*		if(hit)
									return hit*/

								if(charge2 == 0)
									del (ST.proj)
									return 0
							if(charge2 == 0)
								del (ST.proj)
								return 0
						if(charge2 == 0)
							del (ST.proj)
							return 0
					if(charge2 == 0)
						del (ST.proj)
						return 0

//STORM-------------------------------------------------------------

		laser_circus
			id = LASER_CIRCUS
			name = "Storm Release: Laser Circus"
			description = "Throws a barrage of beams at the enemie."
			icon_state = "katon_phoenix_immortal_fire"
			default_chakra_cost = 100
			default_cooldown = 10
			stamina_damage_fixed = list(200, 200)
			stamina_damage_con = list(60, 60)

			Use(mob/human/user)
				user.icon_state="Seal"
				charge2=1

				viewers(user) << output("[user]: Laser Circus!", "combat_output")

				spawn()
					var/estate=""
					var/angle
					var/mob/human/player/etarget = user.NearestTarget()
					var/eicon='icons/laserend.dmi'
					var/ewoundmod=200+60*user.ControlDamageMultiplier()
					if(etarget)
						angle = get_real_angle(user, etarget)
						user.dir = angle2dir_cardinal(angle)
					else angle = dir2angle(user.dir)
					var/spread = 8
					user.Begin_Stun()
					while(charge2==1 && user.curchakra >= 50)
						user.curchakra -= 100
						user.icon_state="Throw2"
						if(etarget)
							user.dir = turn(angle2dir_cardinal(angle),0)
						spawn() advancedprojectile_angle(eicon, estate, user, rand(32,64), pick(angle+spread*2,angle+spread,angle,angle-spread,angle-spread*2), distance=10, damage=ewoundmod, wounds=0)
						CHECK_TICK
					user.icon_state=""
					user.End_Stun()

		storm_beam
			id = RANTON_BEAM
			name = "Storm Release: Ranton Beam"
			description = "Creates a dragon of water that follows your enemy."
			icon_state = "water_dragon_blast"
			default_chakra_cost = 600
			default_cooldown = 5
			stamina_damage_fixed = list(500, 500)
			stamina_damage_con = list(250, 250)



			Use(mob/human/user)
				viewers(user) << output("[user]: Storm Release: Ranton Beam!", "combat_output")

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()

				if(etarget)
					var/obj/trailmaker/o=new/obj/trailmaker/BlackPanther()
					var/mob/result=Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,etarget)
					if(result)
						result = result.Replacement_Start(user)
						result.Knockback(2,o.dir)
						spawn(1)
							o.loc = null
						result.Damage((500+250*conmult),0,user,"Ranton Beam","Normal")
						spawn()result.Hostile(user)
						spawn(5) if(result) result.Replacement_End()
				else
					var/obj/trailmaker/o=new/obj/trailmaker/BlackPanther()
					var/mob/result=Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,6)
					if(result)
						result = result.Replacement_Start(user)
						result.Knockback(2,o.dir)
						spawn(1)
							o.loc = null
						result.Damage((500+250*conmult),0,user,"Ranton Beam","Normal")
						spawn()result.Hostile(user)
						spawn(5) if(result) result.Replacement_End()

//DUST ---------------------------------------------------------------------------------------

		Jinton_Beam
			id = JINTON_BEAM
			name = "Dust Release: Jinton Blast"
			description = "Blows away enemies with a massive blast of air!"
			icon_state = "futon_pressure_damage"
			default_chakra_cost = 500
			default_cooldown = 220
			stamina_damage_fixed = list(1500, 1500)
			stamina_damage_con = list(250, 250)


			EstimateStaminaDamage(mob/human/user)
				var/conmult = user.ControlDamageMultiplier()
				if(stamina_damage_fixed && stamina_damage_con)
					return list(stamina_damage_fixed[1] + stamina_damage_con[1]*conmult, stamina_damage_fixed[2] + stamina_damage_con[2]*conmult + round(user.curchakra/300)*300*1.5)
				return null



			Use(mob/human/user)
				user.Timed_Stun(20)
				var/obj/multipart/P
				var/dir = user.dir
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					dir = angle2dir_cardinal(get_real_angle(user, etarget))
					user.dir = dir
				switch(dir)
					if(NORTH)
						P=new/obj/multiparts2/Jinton/PNORTH(locate(user.x,user.y+1,user.z),1)
					if(SOUTH)
						P=new/obj/multiparts2/Jinton/PSOUTH(locate(user.x,user.y-1,user.z),1)
					if(EAST,NORTHEAST,SOUTHEAST)
						P=new/obj/multiparts2/Jinton/PEAST(locate(user.x+1,user.y,user.z),1)
					if(WEST,NORTHWEST,SOUTHWEST)
						P=new/obj/multiparts2/Jinton/PWEST(locate(user.x-1,user.y,user.z),1)
					else
						return
				var/damage=1500 * 1.5 + round(500*user.ControlDamageMultiplier())
				var/partial_damage
				var/distance_moved=0
				var/distance=20
				while(P && distance>0)
					//this allows people to trigger kawarimi and escape, while taking
					//partial damage based on how far pressure damage has moved
					for(var/mob/M in P.Pwned2)
						if((M.x!=P.x)||(M.y!=P.y) && M.pressured==1)

							P.Pwned2-=M
							if(!M.ko && !M.IsProtected())
								partial_damage=(damage * 0.5) + (damage * 0.05 * distance_moved)
								user.combat("[src]: Hit [M] for [partial_damage] damage!")
								M.Damage(partial_damage,0,user,"Wind: Pressure Damage","Normal")
								spawn()if(M) M.Hostile(user)

					for(var/obj/p in P.parts2)
						for(var/mob/M in p.loc)
							if(!M.pressured && M!=user && !M.kaiten && !M.sandshield && !M.chambered && !M.IsProtected() && !(istype(M, /mob/corpse)))
								M = M.Replacement_Start(user)
								M.pressured=1
								spawn(100)
									if(M&&M.pressured)
										M.pressured=0
								P.Pwned2+=M
								M.Timed_Stun(distance*2)
								M.animate_movement=2

					step(P,P.dir)

					sleep(2)

					distance_moved++
					distance--


				for(var/mob/OP in P.Pwned2)
					OP.pressured=0
					OP.animate_movement=1
					if(!OP.ko && !OP.IsProtected())

						user.combat("[src]: Hit [OP] for [damage] damage!")
						OP.Damage(damage,0,user,"Wind: Pressure Damage","Normal")
						//spawn()if(OP) OP.Dec_Stam(damage,0,user)
						spawn()if(OP) OP.Hostile(user)
						spawn(5) if(OP) OP.Replacement_End()

				P.Del()

//MAGNET -----------------------------------------------------------------------------

		iron_world
			id = IRON_WORLD
			name = "Magnet Release: Iron World"
			icon_state = "paper_chasm"
			default_chakra_cost = 600
			default_cooldown = 5

			Use(mob/user)
				viewers(user) << output("[user]: Magnet Release: Iron World!", "combat_output")
				var/range=15 //200
				spawn()MagnetWorld(user.x,user.y,user.z,range,user)
/*				var/mob/human/player/etarget = user.MainTarget()
				var/con_mod=user.con+user.conbuff-user.conneg/150
				var/timer=con_mod*60
				var/list/Metal = new
				var/Max = 5
				for(var/turf/t in view(6,etarget ? etarget : user))
					if(!t.density)
						var/obj/metalthing/p = new(locate(t.x,t.y,t.z))
						p.owner = user
						Metal.Add(p)

				while(timer > 0)
					for(var/i = 0, i < Max, ++i)
						var/n = rand(1, Metal.len)
						var/obj/metalthing/p = Metal[n]
						while (p.Modified)
							n++
							if (n > Metal.len)
								n = 1
							p = Metal[n]
						animate(p, transform = matrix()*2)
						for(var/mob/M)
							if(M.loc == p.loc)
								if(M != user)
									M.Poison+=rand(4,8)
									M.movepenalty=25
						p.Modified = 1



					timer --
					CHECK_TICK
					for(var/obj/metalthing/p in Metal)
						animate(p, transform = matrix()*1)
						p.Modified = 0
					sleep(10)

				for(var/obj/metalthing/p in Metal)
					del(p)*/

//LAVA -------------------------------------------------------------------------------------

	lava_globs
		id = LAVA_GLOBS
		name = "Lava Release: Lava Globs"
		description = "Fires a water projectile at your opponent"
		icon_state = "water_bullet"
		default_chakra_cost = 250
		default_cooldown = 130
		default_seal_time = 10
		stamina_damage_fixed = list(120, 120)
		stamina_damage_con = list(80, 80)

		Use(mob/human/player/user)
			charge2=1
			viewers(user) << output("[user]: Lava Release: Lava Globs!", "combat_output")
			var/damage = 120+80*user.ControlDamageMultiplier()

			var/eicon='icons/lava_bullet.dmi'
			var/estate="medium"

			//snd(user,'sounds/chidori_static1sec.wav',vol=30)
			var/mob/human/player/etarget = user.NearestTarget()

			var/speed = 40
			var/angle

			user.icon_state="Seal"

			//user.Timed_Stun(times*2)
			while(charge2==1 || user.curchakra>=80)
				user.curchakra-=80
				if(etarget)
					angle = get_real_angle(user, etarget)
					user.dir = angle2dir_cardinal(angle)
				else angle = dir2angle(user.dir)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+1*rand(-4,4), distance=10, damage=damage, wounds=0)
				sleep(2)
			user.icon_state=""

//SCORCH --------------------------------------------------------------------------------

		scorch_mode
			id = SCORCH_MODE
			name = "Scorch Release: Scorch Spheres"
			icon_state = "shukaku"
			default_chakra_cost = 300
			default_cooldown = 310

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				user.overlays+=image('icons/Scorch_Balls.dmi')
				user.scorch_modo=3
				user.RecalculateStats()
				user.ChakraDrains()
				if(user.curchakra<=0)
					user.scorch_modo=0
					user.overlays-=image('icons/Scorch_Balls.dmi')
					user.overlays-=image('icons/Scorch_Balls2.dmi')
					user.overlays-=image('icons/Scorch_Balls3.dmi')
					user.RecalculateStats()


		scorch_flare
			id = SCORCH_FLARE
			name = "Scorch Release: Incinerating Flare Technique"
			description = "Blasts enemies with a ball of compressed air."
			icon_state = "fuuton_air_bullet"
			default_chakra_cost = 350
			default_cooldown = 60
			default_seal_time = 10
			stamina_damage_fixed = list(500, 500)
			stamina_damage_con = list(500, 500)

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.scorch_modo < 3)
						Error(user, "You must be holding 3 Scorch Balls to be able to use this technique.")
						return 0

			Use(mob/human/user)
				var/ux=user.x
				var/uy=user.y
				var/uz=user.z
				var/startdir=user.dir

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()

				user.overlays-=image('icons/Scorch_Balls.dmi')
				user.scorch_modo=0

				if(!etarget)
					var/ex=ux
					var/ey=uy
					var/ez=uz
					var/angle = dir2angle(startdir)
					var/exmod = 8 * round(cos(angle), 1)
					var/eymod = 8 * round(sin(angle), 1)

					etarget=straight_proj(/obj/scorch_bomb,8,user,1)

					spawn()explosion4((500+500*conmult),ex+exmod,ey+eymod,ez,user,0,6)

mob/var/scorch_modo=0


mob/proc
	StatDebuff()
		//var/dfAC = src.AC
		src.strneg = src.str*0.25
		src.rfxneg = src.rfx*0.25
		src.AC -= 50
		spawn(300)
			src.strneg = 0
			src.rfxneg = 0
			src.AC +=50
		src.RecalculateStats()