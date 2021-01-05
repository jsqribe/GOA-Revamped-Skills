skill
	medic
		face_nearest = 1

		copyable = 1

		heal
			id = MEDIC
			name = "Medical: Heal"
			description = "Heals your ally's internal damage."
			icon_state = "medical_jutsu"
			default_chakra_cost = 60
			default_cooldown = 5
			cost = 2000

			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/etarget = user.MainTarget()
					if((etarget && etarget.chambered) || (etarget && etarget.mole))
						Error(user, "No Valid Target")
						return 0

			Use(mob/user)
				var/mob/human/player/etarget = user.NearestTarget()
				if(!etarget)
					for(var/mob/human/M in get_step(user,user.dir))
						if(!M.chambered && !M.mole) etarget=M
						break

				if(etarget&&(etarget in ohearers(user,1)))
					var/turf/p=etarget.loc
					var/turf/q=user.loc
					user.icon_state="Throw2"
					user.Begin_Stun()
					user.usemove=1
					//while(user.usemove && etarget.curwound && etarget && etarget.x==p.x && etarget.y==p.y && user.x==q.x && user.y==q.y)
					var/conroll=rand((user.con+user.conbuff-user.conneg),1.5*(user.con+user.conbuff-user.conneg))
					var/woundroll=rand(round((etarget.curwound)/2),(etarget.curwound))
					var/medicz = 50
					medicz += (user.skillspassive[23] * 50 / 20)
					if(medicz >= rand(1,100))
				//	if(conroll>woundroll && woundroll)
						var/effect=round(conroll/(woundroll))//*pick(1,2,3)
						if(user.skillspassive[23])effect*=(1 + 0.05*user.skillspassive[23])
						if(effect>etarget.curwound)
							effect=etarget.curwound

						if(effect>etarget.curwound)
							effect=etarget.curwound

						if(effect<0)
							effect=0

						etarget.curwound-=effect
						user.overlays+='icons/Healing.dmi'
						etarget.overlays+='icons/base_chakra.dmi'
						user.combat("Healed [etarget] [effect] Wound")
						etarget.combat("You have been healed by [user], [effect] Wound")

						if(etarget.curwound<=0)
							etarget.curwound=0

						user.curchakra-=default_chakra_cost
						spawn(15)
							user.icon_state=""
							user.overlays-='icons/Healing.dmi'
							etarget.overlays-='icons/base_chakra.dmi'



					else
						user.combat("You failed to do any healing!")
						user.curchakra-=default_chakra_cost
						spawn(10)
							user.icon_state=""
							user.overlays-='icons/Healing.dmi'
							etarget.overlays-='icons/base_chakra.dmi'
							user.icon_state=""


					if(!etarget.curwound)
						user.combat("[etarget] has no wounds")
						user.curchakra-=default_chakra_cost
						spawn(10)
							user.icon_state=""
							user.overlays-='icons/Healing.dmi'
							etarget.overlays-='icons/base_chakra.dmi'


					if(!(etarget.x==p.x && etarget.y==p.y && user.x==q.x && user.y==q.y))
						user.combat("Your healing was interrupted!")
						spawn(10)
							user.icon_state=""
							user.overlays-='icons/Healing.dmi'
							etarget.overlays-='icons/base_chakra.dmi'

				else
					user.combat("No Valid Target!")
					user.icon_state=""
					user.overlays-='icons/Healing.dmi'
					if(etarget) etarget.overlays-='icons/base_chakra.dmi'

				spawn(10)
					user.End_Stun()
					user.icon_state = ""


		delicate_extraction
			id = DELICATE_EXTRACTION
			name = "Medical: Delicate Extraction"
			description = "Removes any debuffs from your body."
			icon_state = "delicate_extraction"
			default_chakra_cost = 80
			default_cooldown = 30
			cost = 500
			skill_reqs = list(MEDIC)
			/*
			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/etarget = user.MainTarget()
					if(etarget && etarget.chambered || etarget && etarget.mole)
						Error(user, "No Valid Target")
						return 0
			*/
			Use(mob/user)
				var/mob/human/player/etarget = user

				if(etarget)
					user.icon_state="Throw2"

					user.Begin_Stun()
					user.usemove=1

					if(!etarget.Poison)
						user.combat("You're not poisoned")
						user.icon_state=""
						etarget.overlays-='icons/base_chakra.dmi'
						etarget.End_Stun()
						return
					else
						etarget.overlays+='icons/base_chakra.dmi'
						sleep(3)
						user.icon_state=""
						if(etarget) etarget.overlays-='icons/base_chakra.dmi'
						if(!etarget || !user.usemove)
							user.combat("Your extraction was interrupted!")
							user.icon_state=""
							if(etarget) etarget.overlays-='icons/base_chakra.dmi'
							return

						var/poisonroll=rand(round((etarget.Poison)/3),(etarget.Poison))

						if(user.skillspassive[23])
							var/effect = 1 + ((user.skillspassive[23]/50) * poisonroll) //at most you can remove half your poison at full med passives

							if(effect>etarget.Poison)
								effect=etarget.Poison

							etarget.Poison-=effect
							if(etarget.Poison<=0)
								etarget.Poison=0
							if(etarget.Poison)
								user.combat("Extracted some of [etarget]'s poison")
								etarget.combat("[user] extracted some of your poison")
							else
								user.combat("Extracted all of [etarget]'s poison")
								etarget.combat("[user] extracted all of your poison")
						else
							user.combat("You failed to extract any poison!")
						user.icon_state=""
				spawn(10)
					etarget.End_Stun()
					etarget.icon_state = ""



		poison_mist
			id = POISON_MIST
			name = "Medical: Poison Mist"
			icon_state = "poisonbreath"
			default_chakra_cost = 420
			default_cooldown = 60
			cost = 1500
			skill_reqs = list(MEDIC)


			Use(mob/human/user)
				user.icon_state = "Seal"

				user.Begin_Stun()


				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					user.dir = get_dir(user,etarget)

				if (user.dir==NORTHEAST || user.dir==SOUTHEAST) user.dir = EAST
				if (user.dir==NORTHWEST || user.dir==SOUTHWEST) user.dir = WEST


				var/poison_size=0

				if(user.skillspassive[23]<=9) //lvl 0-9

					poison_size=3

				if(user.skillspassive[23]>9 && user.skillspassive[23]<=15 ) //lvl 9-15

					poison_size=6

				if(user.skillspassive[23]>15 ) //lvl 15+

					poison_size=9

				var/turf/source
				if(user.dir==NORTH)
					source = locate(usr.x,usr.y+1,usr.z)
				if(user.dir==SOUTH)
					source = locate(usr.x,usr.y-1,usr.z)
				if(user.dir==EAST)
					source = locate(usr.x+1,usr.y,usr.z)
				if(user.dir==WEST)
					source = locate(usr.x-1,usr.y,usr.z)

				spawn() SmokeSpread(source, "poison", poison_size, 2, 1,user)

				spawn(10)
					user.End_Stun()
					user.icon_state = ""





		chakra_scalpel
			id = MYSTICAL_PALM
			name = "Medical: Chakra Scalpel"
			description = "Uses chakra to create a sharp blade around your hands, allowing you to deal heavy damage with precise strikes."
			icon_state = "mystical_palm_technique"
			default_chakra_cost = 80
			default_cooldown = 30
			cost = 1000
			skill_reqs = list(MEDIC)

			//ORIG VALUES
			//var/critdamx=round((con + conbuff) * rand(20, 60) / 10)
			//var/critdamx = round((con + conbuff) * rand(50, 100) / 100) no crit
			//var/wounddam=round(((rand(1, 4) / 2) * (con + conbuff - conneg)) / 200)


			EstimateStaminaCritDamage(mob/user)
				var/medic_passive = user.skillspassive[23]
				return list(round(user.con + user.conbuff * (1+((0.2*medic_passive) / 10))), round(user.con + user.conbuff * (1+((4*medic_passive) / 10))))

			EstimateStaminaDamage(mob/user)
				var/medic_passive = user.skillspassive[23]
				return list(round(user.con + user.conbuff * (1+((3.5*medic_passive) / 100))), round(user.con + user.conbuff * (1+((6*medic_passive) / 100))))


			EstimateWoundDamage(mob/user)
				var/medic_passive = user.skillspassive[23]
				return list( 1 , 1 + (0.2*medic_passive) )



			Cooldown(mob/user)
				if(!user.scalpol)
					return ..(user)
				else
					return 0


			Use(mob/human/user)
				if(user.scalpol)
					user.special=0
					user.scalpol=0
					user.weapon=new/list()
					user.Load_Overlays()
					ChangeIconState("mystical_palm_technique")
				else
					user.combat("This skill requires precison. Wait between attacks for critical damage!")
					user.scalpol=1
					user.overlays+='icons/chakrahands.dmi'
					user.special=/obj/chakrahands
					user.removeswords()
					user.weapon=list('icons/chakraeffect.dmi')
					user.Load_Overlays()
					ChangeIconState("mystical_palm_technique_cancel")




		cherry_blossom_impact
			id = CHAKRA_TAI_RELEASE
			name = "Medical: Cherry Blossom Impact"
			description = "Enhances your strength with chakra, allowing you break bones with one big punch."
			icon_state = "chakra_taijutsu_release"
			default_chakra_cost = 100
			default_cooldown = 30
			cost = 1700
			skill_reqs = list(MEDIC)


			EstimateStaminaDamage(mob/user)
				return list(round((user.con+user.conbuff)*2+0.5*user.skillspassive[23]) + 400, round((user.con+user.conbuff)*2+0.5*user.skillspassive[23]) * 2 + 400)


			Use(mob/human/user)
				user.Begin_Stun()
				user.overlays+='icons/sakurapunch.dmi'
				user.combat("Attack Quickly! Your chakra will drain until you attack.")
				sleep(3)
				user.overlays-='icons/sakurapunch.dmi'
				user.End_Stun()
				user.sakpunch=1
			//	FloorField(user, user.loc, size=3, delay=0)
				user.RecalculateStats()
				sleep(10)
				if(user.naturechakra > 0)
					while(user && user.sakpunch && user.naturechakra>0)
						sleep(10)
				else
					while(user && user.sakpunch && user.curchakra>0)
						sleep(10)
				if(user)
					user.sakpunch=0
					user.RecalculateStats()


		chakra_enhancement
			id = CHAKRA_ENHANCEMENT
			name = "Medical: Chakra Enhancement"
			description = "Enhances your strength with chakra, allowing you break bones with multiple punches. Lasts for 15 seconds. Can be canceled."
			icon_state = "chakra_enhancement"
			default_chakra_cost = 150
			default_cooldown = 100
			cost = 1800
			skill_reqs = list(MEDIC,CHAKRA_TAI_RELEASE)

			Activate(mob/human/user)
				if(user.tsupunch)
					user.tsupunch = 0
					return
				..(user)

			EstimateStaminaDamage(mob/user)
				return list(round((user.con+user.conbuff)*2+0.5*user.skillspassive[23]) + 400, round((user.con+user.conbuff)*2+0.5*user.skillspassive[23]) * 2 + 400)

			Use(mob/human/user)
				user.Begin_Stun()
				user.overlays+='icons/sakurapunch.dmi'
				sleep(3)
				user.overlays-='icons/sakurapunch.dmi'
				user.End_Stun()
				user.tsupunch=1
				var/dur = 15
				while(user && user.tsupunch && dur)
					sleep(10)
					dur--
				if(user) user.tsupunch=0




		body_disruption_stab
			id = IMPORTANT_BODY_PTS_DISTURB
			name = "Medical: Body Disruption Stab"
			description = "Scrambles your enemy's nerves with a precise injection of chakra."
			icon_state = "important_body_ponts_disturbance"
			default_chakra_cost = 100
			default_cooldown = 180
			cost = 1000
			skill_reqs = list(MYSTICAL_PALM)


			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.NearestTarget()
				if(.)
					if(!target)
						Error(user, "No Target")
						return 0
					if(target.kaiten || target.sandshield || target.chambered || target.mole)
						Error(user, "No Valid Target")
						return 0
					var/distance = get_dist(user, target)
					if(distance > 2)
						Error(user, "Target too far ([distance]/2 tiles)")
						return 0


			Use(mob/human/user)
				var/mob/human/player/etarget = user.NearestTarget()
				var/CX=rand(1,((user.con+user.conbuff-user.conneg)*user.skillspassive[23]))
				var/Cx=rand(1,((etarget.con+etarget.conbuff-etarget.conneg)*etarget.skillspassive[23]))
				if(CX>Cx)
					etarget = etarget.Replacement_Start(user)
					user.combat("Nervous system disruption succeeded!")
					etarget.combat("Your nervous system has been attacked, you are unable to control your muscles!")
					etarget.overlays+='icons/disturbance.dmi'
					spawn(20)
						etarget.overlays-='icons/disturbance.dmi'
					spawn(5) if(etarget) etarget.Replacement_End()
					etarget.movement_map = list()
					var/list/dirs = list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
					var/list/dirs2 = dirs.Copy()
					for(var/orig_dir in dirs)
						var/new_dir = pick(dirs2)
						dirs2 -= new_dir
						etarget.movement_map["[orig_dir]"] = new_dir
					spawn(300)
						if(etarget) etarget.movement_map = null
				else
					user.combat("Nervous system disruption failed!")




		creation_rebirth
			id = PHOENIX_REBIRTH
			name = "Medical: Creation Rebirth"
			description = "Heals you almost completely with a large infusion of chakra."
			icon_state = "pheonix_rebirth"
			default_chakra_cost = 800
			default_cooldown = 1200
			copyable = 0
			cost = 2500
			skill_reqs = list(IMPORTANT_BODY_PTS_DISTURB)

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.inarena)
						Error(user, "Rebirth is disabled for arena competitions!")
						return 0

			Use(mob/human/user)
				user.icon_state="hurt"
				user.overlays+='icons/rebirth.dmi'
				spawn(30)
					user.overlays-='icons/rebirth.dmi'
					user.icon_state=""
				user.Timed_Stun(30)
				var/oldstam=user.curstamina
				user.curstamina=round(user.stamina*1.25)
				user.combat("[user.curstamina - oldstam] stamina healed!")
				sleep(30)
				if(!user.ko)
					var/oldwound=user.curwound
					user.curwound-=user.skillspassive[23]*5
					if(user.curwound < 0) user.curwound=0
					user.combat("[oldwound-user.curwound] wounds healed!")




		poisoned_needles
			id = POISON_NEEDLES
			name = "Medical: Poisoned Needles"
			description = "Throws poisoned needles at your enemy."
			icon_state = "poison_needles"
			default_supply_cost = 5
			default_cooldown = 60
			face_nearest = 0
			stamina_damage_fixed = list(500, 500)
			stamina_damage_con = list(0, 0)
			cost = 1500
			skill_reqs = list(POISON_MIST)


			Use(mob/human/user)
				user.icon_state="Throw1"
				user.Begin_Stun()
				sleep(5)
				var/list/hit=new
				var/oX=0
				var/oY=0
				var/devx=0
				var/devy=0
				var/mob/human/player/etarget = user.NearestTarget()
				if(etarget)
					user.dir = angle2dir_cardinal(get_real_angle(user, etarget))
				if(user.dir==NORTH)
					oY=1
					devx=8
				if(user.dir==SOUTH)
					oY=-1
					devx=8
				if(user.dir==EAST)
					oX=1
					devy=8
				if(user.dir==WEST)
					oX=-1
					devy=8
				spawn()
					if(user)
						var/turf/T=advancedprojectile_returnloc(/obj/needle,user,(32*oX),(32*oY),5,100,user.x,user.y,user.z)
						if(T)
							for(var/mob/human/mX in locate(T.x,T.y,T.z))
								if(!mX.IsProtected() && !mX.chambered)
									mX = mX.Replacement_Start(user)
									hit+=mX
									spawn(5) if(mX) mX.Replacement_End()
				spawn()
					if(user)
						var/turf/T=advancedprojectile_returnloc(/obj/needle,user,32*oX +devx,32*oY + devy,5,100,user.x,user.y,user.z)
						if(T)
							for(var/mob/human/mX in locate(T.x,T.y,T.z))
								if(!mX.IsProtected() && !mX.chambered)
									mX = mX.Replacement_Start(user)
									hit+=mX
									spawn(5) if(mX) mX.Replacement_End()
				spawn()
					if(user)
						var/turf/T=advancedprojectile_returnloc(/obj/needle,user,32*oX +1.5*devx,32*oY + 1.5*devy,5,100,user.x,user.y,user.z)
						if(T)
							for(var/mob/human/mX in locate(T.x,T.y,T.z))
								if(!mX.IsProtected() && !mX.chambered)
									mX = mX.Replacement_Start(user)
									hit+=mX
									spawn(5) if(mX) mX.Replacement_End()
				spawn()
					if(user)
						var/turf/T=advancedprojectile_returnloc(/obj/needle,user,32*oX +-1*devx,32*oY + -1*devy,5,100,user.x,user.y,user.z)
						if(T)
							for(var/mob/human/mX in locate(T.x,T.y,T.z))
								if(!mX.IsProtected() && !mX.chambered)
									mX = mX.Replacement_Start(user)
									hit+=mX
									spawn(5) if(mX) mX.Replacement_End()
				spawn()
					if(user)
						var/turf/T=advancedprojectile_returnloc(/obj/needle,user,32*oX +-1.5*devx,32*oY + -1.5*devy,5,100,user.x,user.y,user.z)
						if(T)
							for(var/mob/human/mX in locate(T.x,T.y,T.z))
								if(!mX.IsProtected() && !mX.chambered)
									mX = mX.Replacement_Start(user)
									hit+=mX
									spawn(5) if(mX) mX.Replacement_End()
				sleep(5)
				if(user)
					user.End_Stun()
					user.icon_state=""
				spawn(20)
					for(var/mob/human/M in hit)
						spawn()
							if(M && !M.ko && M!=user)
								M.Poison+=rand(4,8)
								M.Damage(500,0,user,"Medical: Poison Needles","Normal")
								//M.Poison+=rand(max(1,0.2*user.skillspassive[23]),max(1,0.4*user.skillspassive[23]))
								//M.Damage(max(1,25*user.skillspassive[23]),0,user,"Medical: Poison Needles","Normal")
								M.Hostile(user)


	menacing_palm
		id = MENACING_PALM
		name = "Menacing Palm"
		description = "Infuse your enemy with an explosion of chakra, dealing moderate stamina damage and minor wounds."
		icon_state = "mystical_palm_technique2"
		default_chakra_cost = 300
		default_cooldown = 80
		stamina_damage_fixed = list(500, 500)
		stamina_damage_con = list(140, 140)
		wound_damage_fixed = list(4, 4)
		cost = 1200
		skill_reqs = list(MEDIC)

		IsUsable(mob/user)
			. = ..()
			var/mob/human/target = user.NearestTarget()
			if(. && target)
				var/distance = get_dist(user, target)
				if(distance > 3)
					Error(user, "Target too far ([distance]/3 tiles)")
					return 0


		Use(mob/human/player/user)
			viewers(user) << output("[user]: Medic: Menacing Palms!", "combat_output")


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


			sleep(1)


			if(etarget)
				etarget=etarget.Replacement_Start(user)
				user.Timed_Stun(10)
				etarget.Timed_Stun(10)
				user.icon_state="Throw2"
				user.overlays+='icons/menacing_palm.dmi'
				etarget.overlays+='icons/menacing_palm.dmi'
				sleep(10)
				etarget.overlays-='icons/menacing_palm.dmi'
				user.overlays-='icons/menacing_palm.dmi'
				user.icon_state=""
				spawn(5) if(etarget) etarget.Replacement_End()
				explosion(50,etarget.x,etarget.y,etarget.z,user,1)
				etarget.Knockback(5,get_dir(user,etarget))
				etarget.Damage(round(12*dmg_mult*user.skillspassive[23] + 70*dmg_mult*(user.con/150)*(1+0.4*user.skillspassive[23])),4,user,"Medical: Menacing Palm","Internal")






//TROLL MOVES BELOW


mob/var/tooksharingans=0
mob/var/tookbyakugans=0
mob/var/gotsharingans=0
mob/var/gotbyakugans=0
mob/var/givenbyakugans=0
mob/var/givensharingans=0
mob/var/impsharingan=0
mob/var/impbyakugan=0

skill
	dmedic
		copyable = 0


		eye_extract
			id = EYE_EXTRACT
			name = "Eye Extraction"
			icon_state = "extract"
			default_chakra_cost = 700
			description = "A jutsu that allows the user to take Uchihas and Hyuugas Corpses Eyes(this jutsu success is based on healing passives)"
			default_cooldown = 60

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.carrying.len)
						Error(user, "You have to be carrying a corpse to use this Jutsu")
						return 0

			Use(mob/user)
				for(var/mob/corpse/C in oview(1,user))
					if(user.carrying.Find(C))
						user.dir=get_dir(user,C)
						flick("Throw2",user)
						sleep(50)
						if(C.clan=="Uchiha")
							if(user.skillspassive[23]>= rand(1,20))
								world << "[user] has succeded in extract [C]'s Sharingan!"
								user.gotsharingans=1
								C.carriedme=0
								C.carryingme=null
								if(C)del(C)
								break
							else
								world << "[user] has failed in extract [C]'s Sharingan!"
								C.carriedme=0
								C.carryingme=null
								if(C)del(C)
								break

						if(C.clan=="Hyuuga")
							if(user.skillspassive[23]>= rand(1,20))
								world << "[user] has succeded in extract [C]'s Byakugan!"
								user.gotbyakugans=1
								C.carriedme=0
								C.carryingme=null
								if(C)del(C)
								break
							else
								world << "[user] has failed to extract [C]'s Byakugan!"
								C.carriedme=0
								C.carryingme=null
								if(C)del(C)
								break

		sharingan_implant
			id = SHARINGAN_IMPLANT
			name = "Sharingan Implant"
			icon_state = "simplant"
			default_chakra_cost = 750
			description = "A jutsu that allows the user to implant sharingan on someone, including himself (this jutsu is based on Healing Passives)"
			default_cooldown = 150

			IsUsable(mob/user)
				. = ..()
				var/mob/human/player/etarget = user.NearestTarget()
				if(.)
					if(user.gotsharingans==0)
						Error(user, "You have no more eyes to give.")
						return 0
					if(etarget.givensharingans>=1)
						Error(user, "[etarget] already has a sharingan implanted in them!")
						return 0
					if(etarget.givenbyakugans>=1)
						Error(user, "[etarget] already has a byakugan implanted in them!")
						return 0
					if(etarget.clan=="Hyuuga")
						Error(user, "[etarget] already has a doujutsu!")
						return 0


			Use(mob/user)
				flick("Throw2",user)
				var/mob/human/player/etarget = user.NearestTarget()
				var/medicz = (user.skillspassive[23] * 25 / 20)
				if(etarget in oview(1, user))
					sleep(50)
					if(etarget.clan=="Uchiha" && etarget.mangekyouU>=50)
						if(medicz >= rand(1,100))
							user.gotsharingans-=1
							etarget.mangekyouU=0
							etarget.givensharingans+=1
							view(user) << "[user] has succeded in implanting Sharingan into  [etarget]!"
						else
							view(user) << "[user] has failed to implant Sharingan into [etarget]!"
							user.gotsharingans-=1
							etarget.curwound=200
							etarget.curstamina=0
					if(etarget.clan!="Uchiha")
						if(medicz >= rand(1,100))
							user.gotsharingans-=1
							etarget.givensharingans+=25
							etarget.AddSkill(LEFT_SHARINGAN)
							etarget.AddSkill(SHARINGAN_COPY)
							view(user) << "[user] has succeded in implanting Sharingan into  [etarget]!"

						else
							view(user) << "[user] has failed to implant Sharingan into [etarget]!"
							user.gotsharingans-=1
							etarget.curwound=200
							etarget.curstamina=0
				if(!etarget && user.clan!="Uchiha")
					sleep(50)
					if(medicz >= rand(1,100))
						user.gotsharingans-=1
						user.givensharingans+=25
						user.AddSkill(LEFT_SHARINGAN)
						user.AddSkill(SHARINGAN_COPY)
						view(user) << "[user] has succeded in implanting Sharingan into  himself!"

					else
						view(user) << "[user] has failed to implant Sharingan into himself!"
						user.curwound=200
						user.curstamina=0
						user.gotsharingans-=1

				if(!etarget && user.clan=="Uchiha" && user.mangekyouU>=50)
					sleep(50)
					if(medicz >= rand(1,100))
						user.gotsharingans-=1
						user.givensharingans+=1
						view(user) << "[user] has succeded in implanting Sharingan into  himself!"

					else
						view(user) << "[user] has failed to implant Sharingan into himself!"
						user.curwound=200
						user.curstamina=0
						user.gotsharingans-=1

		byakugan_implant
			id = BYAKUGAN_IMPLANT
			name = "Byakugan Implant"
			icon_state = "bimplant"
			default_chakra_cost = 750
			description = "A jutsu that allows the user to implant sharingan on someone, including himself (this jutsu is based on Healing Passives)"
			default_cooldown = 150

			IsUsable(mob/user)
				. = ..()
				var/mob/human/player/etarget = user.NearestTarget()
				if(.)
					if(user.gotbyakugans==0)
						Error(user, "You have no more eyes to give.")
						return 0
					if(etarget.givensharingans>=1)
						Error(user, "[etarget] already has a sharingan implanted in them!")
						return 0
					if(etarget.givenbyakugans>=1)
						Error(user, "[etarget] already has a byakugan implanted in them!")
						return 0
					if(etarget.clan=="Uchiha")
						Error(user, "[etarget] already has a doujutsu!")
						return 0
					if(etarget.clan=="Hyuuga")
						Error(user, "[etarget] already has a doujutsu!")
						return 0


			Use(mob/user)
				flick("Throw2",user)
				var/mob/human/player/etarget = user.NearestTarget()
				var/medicz = (user.skillspassive[23] * 25 / 20)
				if((etarget in oview(1, user)))
					sleep(50)
					if(medicz >= rand(1,100))
						user.gotbyakugans-=1
						etarget.givenbyakugans+=25
						etarget.AddSkill(LEFT_BYAKUGAN)
						view(user) << "[user] has succeded in implanting Byakugan into  [etarget]!"

					else
						view(user) << "[user] has failed to implant Byakugan into [etarget]!"
						user.curwound=200
						user.curstamina=0
						user.gotbyakugans-=1

				if(!etarget)
					sleep(50)
					if(medicz >= rand(1,100))
						if(user.clan!="Uchiha" || user.clan!="Hyuuga")
							user.gotbyakugans-=1
							user.givenbyakugans+=25
							user.AddSkill(LEFT_BYAKUGAN)
							view(user) << "[user] has succeded in implanting Byakugan into  himself!"

					else
						view(user) << "[user] has failed to implant Byakugan into himself!"
						user.curwound=200
						user.curstamina=0
						user.gotbyakugans-=1


		left_sharingan
			id = LEFT_SHARINGAN
			name = "Left Eye Sharingan"
			icon_state = "sharingan2"
			default_chakra_cost = 200
			default_cooldown = 3


			Use(mob/user)
				var/buffrfx=round(user.rfx*0.08)
				var/buffint=round(user.int*0.08)
				if(user.impsharingan)
					if(user.givensharingans <= 0)
						user.RemoveSkill(LEFT_SHARINGAN)
					user.special = 0
					user.see_infrared = 0
					user.impsharingan = 0
					user.rfxbuff-=round(buffrfx)
					user.intbuff-=round(buffint)
					user.combat("Your Sharingan deactivates.")
					user.Affirm_Icon()
					ChangeIconState("sharingan2")
				else
					viewers(user) << output("[user]: Sharingan!", "combat_output")
					user.givensharingans--
					user.impsharingan=1
					user.see_infrared = 1
					if(user.key=="Luis455")
						user.rfxbuff+=buffrfx*10
						user.intbuff+=buffint*10
					else
						user.rfxbuff+=buffrfx
						user.intbuff+=buffint
					user.Affirm_Icon()
					ChangeIconState("sharingan2_cancel")
					user.ChakraDrains()


		left_byakugan
			id = LEFT_BYAKUGAN
			name = "Left Eye Byakugan"
			icon_state = "byakugan"
			default_chakra_cost = 200
			default_cooldown = 3


			Use(mob/user)
				if(user.impbyakugan==1)
					if(user.givenbyakugans <= 0)
						user.RemoveSkill(LEFT_BYAKUGAN)
					user.see_infrared = 0
					user.impbyakugan = 0
					user.combat("Your Byakugan deactivates.")
					ChangeIconState("byakugan")

					user.Affirm_Icon()

				else
					viewers(user) << output("[user]: Byakugan!", "combat_output")
					user.givenbyakugans--
					user.impbyakugan=1
					user.see_infrared = 1
					ChangeIconState("byakugan_cancel")
					user.Affirm_Icon()
					user.ChakraDrains()



obj
	chakrahands
		icon='icons/chakrahands.dmi'
		layer=FLOAT_LAYER




	Poison_Poof
		proc
			PixelMove(dpixel_x, dpixel_y, list/smogs)
				var/new_pixel_x = pixel_x + dpixel_x
				var/new_pixel_y = pixel_y + dpixel_y


				while(abs(new_pixel_x) > 16)
					var/kloc = loc
					if(new_pixel_x > 16)
						new_pixel_x -= 32
						var/Phail=0

						for(var/obj/Poison_Poof/x in oview(0,src))
							Phail=1
							break

						x++

						if(!Phail)
							smogs+=new/obj/Poison_Poof(kloc)

					else if(new_pixel_x < -16)
						new_pixel_x += 32

						var/Phail=0
						for(var/obj/Poison_Poof/x in oview(0,src))
							Phail=1
							break

						x--

						if(!Phail)
							smogs+=new/obj/Poison_Poof(kloc)

				while(abs(new_pixel_y) > 16)
					var/kloc = loc
					if(new_pixel_y > 16)
						new_pixel_y -= 32

						var/Phail=0
						for(var/obj/Poison_Poof/x in oview(0,src))
							Phail=1
							break

						y++

						if(!Phail)
							smogs+=new/obj/Poison_Poof(kloc)

					else if(new_pixel_y < -16)
						new_pixel_y += 32

						var/Phail=0
						for(var/obj/Poison_Poof/x in oview(0,src))
							Phail=1
							break

						y--

						if(!Phail)
							smogs+=new/obj/Poison_Poof(kloc)

				pixel_x = new_pixel_x
				pixel_y = new_pixel_y


			Spread(motx,moty,mom,list/smogs)
				while(mom>0)
					PixelMove(motx/3, moty/3, smogs)
					sleep(1)

					PixelMove(motx/3, moty/3, smogs)
					sleep(1)

					PixelMove(motx/3, moty/3, smogs)
					sleep(1)

					mom -= (abs(motx)+abs(moty))




//OLd heal formula

/*
		var/conroll=rand(1,2*(user.con+user.conbuff-user.conneg))
					var/woundroll=rand(round((etarget.curwound)/3),(etarget.curwound))
					if(conroll>woundroll && woundroll)
						var/effect=round(conroll/(woundroll))//*pick(1,2,3)

						if(user.skillspassive[23]<=5) //lvl 0-5

							effect = (effect*(1 + 0.10*user.skillspassive[23])/4) //Quarter Heals

						if(user.skillspassive[23]>5 && user.skillspassive[23]<=10 ) //lvl 5-10

							effect = (effect*(1 + 0.15*user.skillspassive[23])/2) //Half Heals

						if(user.skillspassive[23]>10 ) //lvl 10+

							effect = effect*(1 + 0.20*user.skillspassive[23]) //Full Heals

*/