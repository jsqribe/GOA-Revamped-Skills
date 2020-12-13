skill
	wind
		copyable = 1

		pressure_damage
			id = FUUTON_PRESSURE_DAMAGE
			name = "Wind: Pressure Damage"
			description = "Blows away enemies with a massive blast of air!"
			icon_state = "futon_pressure_damage"
			base_charge = 50
			default_chakra_cost = 300
			default_cooldown = 120
			stamina_damage_fixed = list(500, 500)
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
						P=new/obj/multipart/Pressure/PNORTH(locate(user.x,user.y+1,user.z),1)
					if(SOUTH)
						P=new/obj/multipart/Pressure/PSOUTH(locate(user.x,user.y-1,user.z),1)
					if(EAST,NORTHEAST,SOUTHEAST)
						P=new/obj/multipart/Pressure/PEAST(locate(user.x+1,user.y,user.z),1)
					if(WEST,NORTHWEST,SOUTHWEST)
						P=new/obj/multipart/Pressure/PWEST(locate(user.x-1,user.y,user.z),1)
					else
						return
				var/damage=500 + charge * 1.5 + round(250*user.ControlDamageMultiplier())
				var/partial_damage
				var/distance_moved=0
				var/distance=10
				while(P && distance>0)
					//this allows people to trigger kawarimi and escape, while taking
					//partial damage based on how far pressure damage has moved
					for(var/mob/M in P.Pwned)
						if((M.x!=P.x)||(M.y!=P.y) && M.pressured==1)

							P.Pwned-=M
							if(!M.ko && !M.IsProtected())
								if(user.shukaku==1)
									partial_damage=(damage * 0.7) + (damage * 0.07 * distance_moved)
								else
									partial_damage=(damage * 0.5) + (damage * 0.05 * distance_moved)
								user.combat("[src]: Hit [M] for [partial_damage] damage!")
								M.Damage(partial_damage,0,user,"Wind: Pressure Damage","Normal")
								spawn()if(M) M.Hostile(user)

					for(var/obj/p in P.parts)
						for(var/mob/M in p.loc)
							if(!M.pressured && M!=user && !M.kaiten && !M.sandshield && !M.chambered && !M.IsProtected() && !(istype(M, /mob/corpse)))
								M = M.Replacement_Start(user)
								M.pressured=1
								spawn(100)
									if(M&&M.pressured)
										M.pressured=0
								P.Pwned+=M
								M.Timed_Stun(distance*2)
								M.animate_movement=2

					step(P,P.dir)

					sleep(2)

					distance_moved++
					distance--


				for(var/mob/OP in P.Pwned)
					OP.pressured=0
					OP.animate_movement=1
					if(!OP.ko && !OP.IsProtected())

						user.combat("[src]: Hit [OP] for [damage] damage!")
						OP.Damage(damage,0,user,"Wind: Pressure Damage","Normal")
						//spawn()if(OP) OP.Dec_Stam(damage,0,user)
						spawn()if(OP) OP.Hostile(user)
						spawn(5) if(OP) OP.Replacement_End()

				CHECK_TICK
				P.Del()



		blade_of_wind
			id = FUUTON_WIND_BLADE
			name = "Wind: Blade of Wind"
			description = "Slashes your enemy with a sword made of air!"
			icon_state = "blade_of_wind"
			default_chakra_cost = 450
			default_cooldown = 90
			face_nearest = 1
			stamina_damage_fixed = list(0, 1000)
			stamina_damage_con = list(0, 500)
			wound_damage_fixed = list(0, 20)
			wound_damage_con = list(0, 0)



			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.NearestTarget()
				if(. && target)
					var/distance = get_dist(user, target)
					if(distance > 3)
						Error(user, "Target too far ([distance]/3 tiles)")
						return 0


			Use(mob/human/user)
				user.removeswords()
				user.overlays+=/obj/sword/w1
				user.overlays+=/obj/sword/w2
				user.overlays+=/obj/sword/w3
				user.overlays+=/obj/sword/w4

				viewers(user) << output("[user]: Wind: Blade of Wind!", "combat_output")

				user.Timed_Stun(10)

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.NearestTarget()

				var/dmg_mult = 1
				if(etarget)
					var/dist = get_dist(user, etarget)
					if(dist == 2)
						dmg_mult = 0.5
					else if(dist != 1)
						etarget = null
				else
					for(var/mob/human/X in get_step(user,user.dir))
						if(!X.ko && !X.IsProtected())
							etarget=X

				flick("w-attack",user)
				sleep(1)

				if(etarget)
					etarget = etarget.Replacement_Start(user)
					if(dmg_mult == 1) etarget.Timed_Move_Stun(30)
					else etarget.Timed_Move_Stun(15)
					var/result=Roll_Against(user.rfx+user.rfxbuff-user.rfxneg,etarget.rfx+etarget.rfxbuff-etarget.rfxneg,100)
					if(result>=5)
						user.combat("[user] Critically hit [etarget] with the Wind Sword")
						etarget.combat("[user] Critically hit [etarget] with the Wind Sword")

						if(user.shukaku==1)
							etarget.Damage(round(rand(1400,(1400+700*conmult))*dmg_mult),round(rand(10,20)*dmg_mult),user,"Wind Sword","Normal")
						else
							etarget.Damage(round(rand(1000,(1000+500*conmult))*dmg_mult),round(rand(10,20)*dmg_mult),user,"Wind Sword","Normal")
					if(result==4||result==3)
						user.combat("[user] Managed to partially hit [etarget] with the Wind Sword")
						etarget.combat("[user] Managed to partially hit [etarget] with the Wind Sword")

						if(user.shukaku==1)
							etarget.Damage(round(rand(700,(700+250*conmult))*dmg_mult),round(rand(5,15)*dmg_mult),user,"Wind Sword","Normal")
						else
							etarget.Damage(round(rand(500,(500+350*conmult))*dmg_mult),round(rand(5,15)*dmg_mult),user,"Wind Sword","Normal")
					if(result>=3)

						spawn()Blood2(etarget,user)
						spawn()etarget.Hostile(user)
					if(result<3)

						user.combat("You Missed!!!")
						if(!user.icon_state)
							flick("hurt",user)
					spawn(5) if(etarget) etarget.Replacement_End()

				user.overlays-=/obj/sword/w1
				user.overlays-=/obj/sword/w2
				user.overlays-=/obj/sword/w3
				user.overlays-=/obj/sword/w4
				//user.removeswords()
				//user.addswords()




		great_breakthrough
			id = FUUTON_GREAT_BREAKTHROUGH
			name = "Wind: Great Breakthrough"
			description = "Pushes enemies away with a wave of air."
			icon_state = "great_breakthrough"
			default_chakra_cost = 70
			default_cooldown = 15
			default_seal_time = 3
			stamina_damage_fixed = list(250, 250)
			stamina_damage_con = list(150, 150)



			Use(mob/human/user)
				viewers(user) << output("[user]: Wind: Great Breakthrough!", "combat_output")

				user.icon_state="HandSeals"
				user.Begin_Stun()

				if (user.dir==NORTHEAST || user.dir==SOUTHEAST) user.dir = EAST
				if (user.dir==NORTHWEST || user.dir==SOUTHWEST) user.dir = WEST
				var/dir = user.dir
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					dir = angle2dir_cardinal(get_real_angle(user, etarget))
					user.dir = dir
				if(user.shukaku==1)
					spawn() WaveDamage(user,3,(350+210*user.ControlDamageMultiplier()),3,14)
				else
					spawn() WaveDamage(user,3,(250+150*user.ControlDamageMultiplier()),3,14)
				spawn() Gust(user.x,user.y,user.z,user.dir,3,14)

				user.End_Stun()
				user.icon_state=""




		air_bullet
			id = FUUTON_AIR_BULLET
			name = "Wind: Refined Air Bullet"
			description = "Blasts enemies with a ball of compressed air."
			icon_state = "fuuton_air_bullet"
			default_chakra_cost = 350
			default_cooldown = 30
			default_seal_time = 10
			stamina_damage_fixed = list(750, 750)
			stamina_damage_con = list(500, 500)



			Use(mob/human/user)
				var/ux=user.x
				var/uy=user.y
				var/uz=user.z
				var/startdir=user.dir

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()

				if(!etarget)
					var/ex=ux
					var/ey=uy
					var/ez=uz
					var/angle = dir2angle(startdir)
					var/exmod = 8 * round(cos(angle), 1)
					var/eymod = 8 * round(sin(angle), 1)

					etarget=straight_proj(/obj/wind_bullet,8,user,1)
					if(etarget)
						ex=etarget.x
						ey=etarget.y
						ez=etarget.z
						if(user.shukaku==1)
							spawn()explosion((1050+700*conmult),ex,ey,ez,user,0,6)
						else
							spawn()explosion((750+500*conmult),ex,ey,ez,user,0,6)
					else
						if(user.shukaku==1)
							spawn()explosion((1050+700*conmult),ex+exmod,ey+eymod,ez,user,0,6)
						else
							spawn()explosion((750+500*conmult),ex+exmod,ey+eymod,ez,user,0,6)
				else
					var/ex=etarget.x
					var/ey=etarget.y
					var/ez=etarget.z

					projectile_to2(/obj/wind_bullet,user,locate(ex,ey,ez))
					if(user.shukaku==1)
						spawn()explosion((1050+700*conmult),ex,ey,ez,user,0,6)
					else
						spawn()explosion((750+500*conmult),ex,ey,ez,user,0,6)


		vacuum_blade_rush
			id = FUUTON_VACUUM_BLADE_RUSH
			name = "Vacuum Blade Rush"
			description = "Hurl a flurry of sharp wind bursts at an enemy, causing stamina and wound damage."
			icon_state = "vacuum_blade_rush"
			default_chakra_cost = 500
			default_cooldown = 120
			default_seal_time = 8
			stamina_damage_fixed = list(180, 180)
			stamina_damage_con = list(50, 50)
			wound_damage_fixed = list(1,5)
			wound_damage_con = list(1,1)

			Use(mob/human/player/user)
				viewers(user) << output("[user]: Wind: Vacuum Blade Rush!", "combat_output")
				var/damage = 180+50*user.ControlDamageMultiplier()
				var/wounds = rand(1,5) + 1*user.ControlDamageMultiplier()

				var/eicon='icons/vacuum_blade_rush.dmi'
				var/estate="medium"

				var/mob/human/player/etarget = user.NearestTarget()

				var/speed = 48
				var/angle

				var/times = 3
				user.icon_state="Seal"
				spawn(times*2) user.icon_state=""
				user.Timed_Stun(times*2)
				for(var/i=0,i < times, i++)
					if(etarget)
						angle = get_real_angle(user, etarget)
						user.dir = angle2dir_cardinal(angle)
					else angle = dir2angle(user.dir)
					if(user.shukaku==1)
						spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+1*rand(-4,4), distance=10, damage=damage*1.4, wounds=wounds)
					else
						spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+1*rand(-4,4), distance=10, damage=damage, wounds=wounds)
					sleep(2)



		rasenshuriken
			id = FUUTON_RASENSHURIKEN
			name = "Wind: Rasenshuriken"
			description = "Creates a highly concentrated spinning mass of miniature needles made of wind chakra."
			icon_state = "rasenshuriken"
			default_chakra_cost = 1000
			default_cooldown = 300
			copyable = 0
			stamina_damage_fixed = list(0, 20000)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(0, 100)
			wound_damage_con = list(0, 0)



			Use(mob/human/player/user)
				viewers(user) << output("[user]: Wind: Rasenshuriken!", "combat_output")
				show_skill_name("rasenshuriken", 30, user)
				user.Begin_Stun()
				/*var/obj/x = new(locate(user.x,user.y,user.z))
				x.layer=MOB_LAYER-1
				x.icon='icons/oodamarasengan.dmi'
				x.dir=user.dir
				flick("create",x)
				user.overlays+=/obj/oodamarasengan
				spawn(30)
					x.loc = null*/
				sleep(30)
				if(user)
					user.rasengan=3
					user.End_Stun()
					user.combat("Press <b>A</b> before the Rasenshuriken dissapates to use it on someone. If you take damage it will dissipate!")
					spawn(100)
						if(user && user.rasengan==3)
							user.Rasenshuriken_Fail()




mob/proc
	Rasenshuriken_Fail()
		rasengan = 0

		overlays -= /obj/rasengan
		overlays -= /obj/rasengan2

		var/obj/O = new /obj(loc)
		O.layer = MOB_LAYER + 1
		O.icon = 'icons/rasengan.dmi'
		flick("failed", O)
		spawn(50)
			O.loc = null

	Rasenshuriken_Hit(mob/x, mob/human/u, xdir)
		overlays -= /obj/rasengan
		overlays -= /obj/rasengan2
		rasengan = 0

		var/conmult=u.ControlDamageMultiplier()

		var/obj/O = new /obj(x.loc)
		O.icon = 'icons/rasengan.dmi'
		O.layer = MOB_LAYER + 1

		flick("hit", O)

		spawn(50)
			O.loc = null

		for(var/mob/M in range(x, 1))
			M = M.Replacement_Start(u)
			M.cantreact = 1
			spawn(30)
				if(M) M.cantreact = 0

			if(!M.icon_state)
				M.icon_state = "hurt"

			spawn() M.Timed_Stun(100)
			M.Earthquake(50)
			spawn()
				for(var/i in 1 to 50)
					if(prob(50 + 5*conmult))
						M.Damage(rand(100,400),rand(1,2),u,"Rasenshuriken","Normal")
						//M.Dec_Stam(rand(100, 400),0,u, internal=1)
						//M.Wound(rand(1,2),3,u)
					sleep(1)

				if(!M.ko)
					M.icon_state = ""
				M.Hostile(u)
				M.Replacement_End()

