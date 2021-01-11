skill
	kaguya
		copyable = 0

		kaguya_clan
			id = KAGUYA_CLAN
			icon_state = "doton"
			name = "Kaguya"
			description = "Kaguya Clan Jutsu."
			stack = "false"//don't stack
			clan=1
			canbuy=0


		finger_bullets
			id = BONE_BULLETS
			name = "Piercing Finger Bullets"
			description = "Creates bullets from your finger bones."
			icon_state = "bonebullets"
			default_chakra_cost = 100
			default_cooldown = 20
			stamina_damage_fixed = list(200, 200)
			stamina_damage_con = list(75, 75)
			wound_damage_fixed = list(1, 1)
			wound_damage_con = list(0, 0)
			cost = 1500
			skill_reqs = list(KAGUYA_CLAN)

			Use(mob/human/user)
				viewers(user) << output("[user]: Piercing Finger Bullets!", "combat_output")
				var/eicon='icons/bonebullets.dmi'
				var/estate=""

				if(!user.icon_state)
					user.icon_state="Throw2"
					spawn(20)
						user.icon_state=""

				var/angle
				var/speed = 32
				var/spread = 18
				if(user.MainTarget()) angle = get_real_angle(user, user.MainTarget())
				else angle = dir2angle(user.dir)

				var/damage = 200+75*user.ControlDamageMultiplier()

				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*2, distance=10, damage=damage, wounds=1)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread, distance=10, damage=damage, wounds=1)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=1)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=1)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*2, distance=10, damage=damage, wounds=1)
				//advancedprojectile_ramped(i,estate,mob/efrom,xvel,yvel,distance,damage,wnd,vel,pwn,daze,radius)//daze as percent/100
				//spawn()advancedprojectile_ramped(eicon,estate,user,speed*cos(angle+spread*2),speed*sin(angle+spread*2),10,(500+200*conmult),1,100,0)
				//spawn()advancedprojectile_ramped(eicon,estate,user,speed*cos(angle+spread),speed*sin(angle+spread),10,(500+200*conmult),1,100,0)
				//spawn()advancedprojectile_ramped(eicon,estate,user,speed*cos(angle),speed*sin(angle),10,(500+200*conmult),1,100,1)
				//spawn()advancedprojectile_ramped(eicon,estate,user,speed*cos(angle-spread),speed*sin(angle-spread),10,(500+200*conmult),1,100,0)
				//spawn()advancedprojectile_ramped(eicon,estate,user,speed*cos(angle-spread*2),speed*sin(angle-spread*2),10,(500+200*conmult),1,100,0)




		bone_harden
			id = BONE_HARDEN
			name = "Bone Harden"
			description = "Creates a layer of hardened bone, blocking most sources of damage."
			icon_state = "bone_harden"
			default_chakra_cost = 20
			default_cooldown = 80
			cost = 1000
			skill_reqs = list(KAGUYA_CLAN)

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.ironskin)
						Error(user, "Cannot be used with Iron Skin active")
						return 0


			ChakraCost(mob/user)
				if(!user.boneharden)
					return ..(user)
				else
					return 0


			Cooldown(mob/user)
				if(!user.boneharden)
					return ..(user)
				else
					return 0


			Use(mob/user)
				if(!user.boneharden)
					user.combat("Your Bones Harden")
					user.boneharden=1
					user.RecalculateStats()
					ChangeIconState("bone_harden_cancel")
				else
					user.combat("You halt the chakra flow to your bones, they become soft again")
					user.boneharden=0
					user.RecalculateStats()
					ChangeIconState("bone_harden")




		camellia_dance
			id = BONE_SWORD
			name = "Camellia Dance"
			description = "Creates a fast sword out of your bone."
			icon_state = "bone_sword"
			default_chakra_cost = 100
			default_cooldown = 200
			cost = 1000
			skill_reqs = list(KAGUYA_CLAN)


			Use(mob/user)
				viewers(user) << output("[user]: Camellia Dance!", "combat_output")
				user.hasbonesword = 1
				user.boneuses=40
				var/o=new/obj/items/weapons/melee/sword/Bone_Sword(user)
				o:Use(user)




		young_bracken_dance
			id = SAWARIBI
			name = "Young Bracken Dance"
			description = "Creates spikes from bone, damaging anyone caught in them and making it harder for your enemies to move."
			icon_state = "sawarabi"
			max_charge = 1000
			base_charge = 100
			default_chakra_cost = 200
			default_cooldown = 120
			default_seal_time = 15
			stamina_damage_fixed = list(2000, 3000)
			stamina_damage_con = list(700, 700)
			wound_damage_fixed = list(10, 10)
			wound_damage_con = list(0, 0)
			cost = 2000
			skill_reqs = list(BONE_BULLETS)


			Use(mob/user)
				viewers(user) << output("[user]: Young Bracken Dance!", "combat_output")
				var/range=1 //200
				while(charge>base_charge && range<10)
					range+=1
					charge-=base_charge
				spawn()SpireCircle(user.x,user.y,user.z,range,user)




		larch_dance
			id = BONE_SPINES
			name = "Larch Dance"
			description = "Creates spikes on your body from bone, damaging anyone who tries to use physical attacks on you. Disables all nonkaguya skills during its duration."
			icon_state = "bone_spines"
			default_chakra_cost = 100
			default_cooldown = 45
			stamina_damage_fixed = list(100, 500)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(5, 10)
			wound_damage_con = list(0, 0)
			cost = 800
			skill_reqs = list(BONE_SWORD)

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.ironskin)
						Error(user, "Cannot be used with Iron Skin active")
						return 0

			Use(mob/user)
				user.Timed_Stun(5)
				sleep(2)
				viewers(user) << output("[user]: Larch Dance!", "combat_output")
				var/obj/o=new(locate(user.x,user.y,user.z))
				o.icon='icons/Dance of the Larch.dmi'
				flick("flick",o)
				spawn()
					for(var/mob/human/M in ohearers(1,user))
						M = M.Replacement_Start(user)
						Blood2(M)
						M.Damage(rand(100,500),rand(5,10),user,"Dance of the Larch","Normal")
						spawn()M.Hostile(user)
						M.Timed_Move_Stun(30)
						spawn(5) if(M) M.Replacement_End()
				sleep(4)
				o.loc = null
				user.overlays+='icons/Dance of the Larch.dmi'
				user.larch=1
				//user.ironskin=2
				spawn(100)
					if(user)
						//user.ironskin=0
						user.larch=0
						user.Timed_Stun(5)
						user.overlays-='icons/Dance of the Larch.dmi'
						var/obj/x=new(locate(user.x,user.y,user.z))
						x.icon='icons/Dance of the Larch.dmi'
						flick("unflick",x)
						sleep(4)
						x.loc = null


		dance_flower
			id = BONE_FLOWER
			name = "Dance Of the Clematis: Flower"
			icon_state = "flower"
			default_chakra_cost = 800
			default_cooldown = 100
			cost = 1800
			skill_reqs = list(BONE_HARDEN)
			
			Use(mob/user)
		/*		if(user.bonedrill)
					user << "You retract your bone drill."
					user.bonedrill = 0
					user.Load_Overlays()
					return*/
				viewers(user) << output("[user]: Dance Of the Clematis: Flower!", "combat_output")
				user.bonedrilluses = rand(4, 10)
				user.bonedrill=1
				user.combat("You have [user.bonedrilluses] uses")
				user.Load_Overlays()
				user<<"You have sculpted your arm into a massive drill! Press A to drill the guts out of anyone within punching range!"



