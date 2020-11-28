mob/var
	Transfered = 0
	petals=0
	mind_attack=0
	controlling_yamanaka=0
	cursing = 0

skill
	yamanaka
		copyable = 0

		mind_transfer
			id = MIND_TRANSFER
			name = "Yamanaka: Mind Transfer"
			icon_state = "mindtransfer"
			default_chakra_cost = 300
			default_cooldown = 40

			Use(mob/user)
				if(user.Transfered)
					user.combat("Remove!")
					user.client:Controling=0
					user.client:hellno=0
					ChangeIconState("mindtransfer")
					return
				user.icon_state="Seal"
				user.stunned=10
				sleep(5)
				viewers(user) << output("[user]: Mind Transfer!", "combat_output")
				var/mob/human/etarget=user.NearestTarget()
				if(etarget)
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Mind_Transfer()
						var/mob/result=Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,8,etarget)
						if(result)
							spawn(1)
								o.loc=null
								//result.Begin_Stun()
								flick("Knockout",user)
								user.icon_state="Dead"
								user.client.eye = result
								user.controlmob= result
							//	user.client:perspective = etarget
								result.controlmob = user
								result.client.Controling=result
								user.controlling_yamanaka=1
								sleep(100 + (user.int/4))
								user.client:eye = user
								user.controlmob = user
								result.controlmob = result
							//	user.client:perspective = user
								result.client.Controling=0
								user.controlling_yamanaka=0
								user.icon_state=""
								result.Reset_Stun()
								user.Reset_Stun()
						else
							user.Reset_Stun()
							user.icon_state=""
				else
					user.Reset_Stun()
					user.icon_state=""


		mind_disturbance
			id = MIND_DISTURBANCE
			name = "Yamanaka: Mind Disturbance"
			icon_state = "minddisturbance"
			default_chakra_cost = 140
			default_cooldown = 50

			Use(mob/user)
				viewers(user) << output("[user]: Mind Disturbance!", "combat_output")
				user.icon_state="Seal"
				spawn(20)
					user.icon_state=""
				var/mob/human/etarget = user.MainTarget()
				var/user_effective_int = (user.int+user.intbuff-user.intneg)*(1 + 0.3*user.skillspassive[20])
				if(etarget)
					var/result=Roll_Against(user_effective_int,(etarget.int+etarget.intbuff-etarget.intneg)*(1 + 0.3*etarget.skillspassive[20]),80)
					var/d=0
					if(result>=6)
						d=15
					if(result==5)
						d=12
					if(result==4)
						d=10
					if(result==3)
						d=8
					if(result==2)
						d=5
					if(result==1)
						d=2
					if(d > 0)
						spawn()
							etarget.Drunk(d)


		flower_bomb
			id = FLOWER_BOMB
			name = "Flower Bomb"
			icon_state = "flower_bomb"
			default_chakra_cost = 500
			default_cooldown = 95

			Use(mob/human/user)
				viewers(user) << output("[user]: Flower Bomb!", "combat_output")

				var/eicon='icons/note.dmi'
				var/estate="flower"

				spawn()
					user.overlays+='icons/senpuu.dmi'
					spawn(8)
						user.overlays-='icons/senpuu.dmi'
					sleep(4)
					user.dir=turn(user.dir,90)
					sleep(4)
					user.dir=turn(user.dir,90)

				var/angle
				var/speed = 48
				var/spread = 18
				if(user.MainTarget()) angle = get_real_angle(user, user.MainTarget())
				else angle = dir2angle(user.dir)

				var/damage = 50


				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*4, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*3, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*2, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*2, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*3, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*4, distance=10, damage=damage, wounds=0)

				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*7, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*6, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*5, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*5, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*6, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*7, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*10, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*8, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*9, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*9, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*8, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*10, distance=10, damage=damage, wounds=0)


		wolfbane
			id = WOLFBANE
			name = "Wolfbane"
			icon_state = "petals"
			default_chakra_cost = 300
			default_cooldown = 65

			Use(mob/user)
				viewers(user) << output("[user]: Wolfbane!", "combat_output")

				var/eicon='note.dmi'
				var/estate="wolfbane"

				////user,'sounds/chidori_static1sec.wav',vol=30)
				var/mob/human/player/etarget = user.NearestTarget()
				if(etarget)
					user.dir = angle2dir_cardinal(get_real_angle(user, etarget))

				var/angle
				var/speed = 48
				var/spread = 9
				if(etarget) angle = get_real_angle(user, etarget)
				else angle = dir2angle(user.dir)

				var/damage = 50

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+1*rand(0,4), distance=10, damage=damage, wounds=rand(1,2))
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-1*rand(0,4), distance=10, damage=damage, wounds=rand(1,2))

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(10,14)/10, distance=10, damage=damage, wounds=rand(1,2))
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(10,14)/10, distance=10, damage=damage, wounds=rand(1,2))

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(12,16)/10, distance=10, damage=damage, wounds=rand(1,2))
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(12,16)/10, distance=10, damage=damage, wounds=rand(1,2))

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(18,22)/10, distance=10, damage=damage, wounds=rand(1,2))
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(18,22)/10, distance=10, damage=damage, wounds=rand(1,2))

				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*rand(21,25)/10, distance=10, damage=damage, wounds=rand(1,2))
				spawn(rand(0,2)) advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*rand(21,25)/10, distance=10, damage=damage, wounds=rand(1,2))





		mind_read
			id = MIND_READ
			name = "Yamanaka: Sensing Transmission"
			icon_state="mindtag"
			default_chakra_cost=100
			default_cooldown = 120

			Use(mob/user)
				viewers(user) << output("[user]: Sensing Transmission!", "combat_output")
				var/targets[] = user.NearestTargets(num=3)
				spawn()
					if(targets && targets.len)
						for(var/mob/human/player/etarget in targets)
							if(etarget in oview(1,user))
								if(!etarget.byakugan)
									etarget.byakugan = 1
									sleep((100 + (user.int/4))/2)
									etarget.byakugan = 0
				if(!user.byakugan)
					user.byakugan = 1
					spawn(100 + (user.int/4))
						user.byakugan = 0




		cursed_doll
			id = CURSED_DOLL
			name = "Yamanaka: Cursed Doll"
			icon_state="cursed_doll"
			default_chakra_cost=700
			default_cooldown = 200

			Use(mob/user)
				user.cursing = 1
				spawn(50)
					user.cursing = 0











