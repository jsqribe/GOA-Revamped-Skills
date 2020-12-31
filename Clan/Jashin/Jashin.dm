skill
	jashin
		copyable = 0

		jashin_clan
			id = JASHIN_CLAN
			icon_state = "doton"
			name = "Jashin"
			description = "Jashin Clan Jutsu."
			stack = "false"//don't stack
			clan=1


		stab_self
			id = MASOCHISM
			name = "Stab Self"
			description = "Stab yourself to do internal damage to a bound enemy."
			icon_state = "masachism"
			default_chakra_cost = 0
			default_cooldown = 5
			wound_damage_fixed = list(10, 10)
			wound_damage_con = list(0, 0)


			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.gate)
						Error(user, "Cannot use Masochism in gates")
						return 0


			Use(mob/user)
				oviewers(user) << output("[user] stabbed himself!", "combat_output")
				user.combat("You stabbed yourself!")
				user.Damage(150, 10, user, "Stab Self", "Internal")
				Blood2(user)




		blood_possession
			id = BLOOD_BIND
			name = "Sorcery: Death-Ruling Possession Blood"
			description = "Binds an enemy to you, transferring all internal damage you take to them as well."
			icon_state = "blood contract"
			default_chakra_cost = 450
			default_cooldown = 200


			IsUsable(mob/user)
				. = ..()
				var/list/Choose=user.bloodrem.Copy()
				if(!Choose.len)
					//world.log << "jashin1 [Choose]"
					Error(user, "You have not collected any blood, make someone bleed to collect their blood!")
					return 0
				/*
				if(user.EnteredBlood<1)
					world.log << "jashin2 [user.EnteredBlood]"
					Error(user, "You got to have some blood with you")
					return 0
				*/

			Use(mob/user)
				var/list/Choose=user.bloodrem.Copy()
				var/mob/C
				var/mob/T=new()
				T.name="Nevermind"
				while(!C)
					for(var/mob/human/F in Choose)
						if(F != user && (F.ko||F.z!=user.z))
							Choose-=F
					Choose+=T
					C=input3(user,"Pick somebody to put a curse on","Blood Contract",Choose)
					if(C!=T && (C.ko || C.z != user.z))
						C = null
				if(C!=T)
					user.bloodrem.Cut()
					var/obj/jashin_circle/J=new(user.loc)
					user.Contract=J
					user.Contract2=C
					if(!C.ContractBy)
						C.ContractBy = list(user)
					else
						C.ContractBy += user
					user.icon='icons/jashin_base.dmi'
					spawn(1800)
						if(J)
							J.loc = null
							if(user)
								user.Contract = null
								if(user.Contract2)
									user.Contract2.ContractBy -= user
									if(user.Contract2.ContractBy.len < 1)
										user.Contract2.ContractBy = null
									user.Contract2 = null
								user.Affirm_Icon()
				else
					return 1




		wound_regeneration
			id = WOUND_REGENERATION
			name = "Wound Regeneration"
			description = "Heals your internal wounds."
			icon_state = "wound regeneration"
			default_chakra_cost = 100
			default_cooldown = 90



			Use(mob/user)
				user.overlays+='icons/base_chakra.dmi'
				user.usemove=1
				sleep(5)
				user.overlays-='icons/base_chakra.dmi'

				sleep(25)
				if(!user)
					return
				if(user.usemove)
					user.curwound-=8
					user.usemove=0
				if(user.curwound<0)
					user.curwound=0




		immortality
			id = IMMORTALITY
			name = "Immortality"
			description = "Sacrifies a corpse to allow you to continue fighting even when others would be dead."
			icon_state = "imortality"
			default_chakra_cost = 400
			default_cooldown = 1200


			Use(mob/user)
				var/timer = (user.blevel*2)*10
				user.immortality=1
				user.Imortality_Time(timer)
				user.combat("You just received [timer/10] seconds of imorality")
/*				if(user.immortality<900)
					var/found=0
					for(var/mob/corpse/C in oview(10,user))
						found=1
						user.immortality+=60+C.blevel*10
						user.combat("You pray to Jashin to grant you immortality and sacrifice [C], you gain [60+C.blevel*10] seconds of Immortality!")
						user.icon_state="Chakra"
						user.Timed_Stun(30)

						sleep(100)
						user.icon_state=""
						if(C)del(C)
						break
					if(!found)
						return
					if(user.immortality>900)
						user.immortality=900*/



		/*	IsUsable(mob/user)
			. = ..()
				if(user.immortality)
					return 0
			/*	for(var/mob/corpse/C in hearers(10,user))
					if(C.killer == user || (user.squad && (C.killer in user.squad.online_members)))
						return 1
				Error(user, "There are no valid corpses in range")
				return 0*/

			Use(mob/user)
				if(user.immortality) return //stopping immortality from being used while in effect, though the c/d will still start after immortality has been cast
				if(user.immortality<900) //Dipic: I truly do not understand this check.
					var/found=0
					for(var/mob/corpse/C in hearers(10,user))
						if(C.killer == user || (user.squad && C.killer in user.squad.online_members))
							found=1
							user.icon_state="Chakra"
							user.Timed_Stun(30)
							sleep(30)

							if(!user.ko)
								user.immortality = 300
								if(!user.sacrifice_level || C.blevel > user.sacrifice_level)
									user.sacrifice_level = C.blevel
								user.RecalculateStats()
								user.combat("You pray to Lord Jashin. He grants you 5 minutes of immortality for sacrificing [C]! Your wound cap has risen to [150+2*user.sacrifice_level]!")
								user.icon_state=""
								if(user.carrying.len && (C in user.carrying)) user.carrying -= C
								if(C) C.loc = null
							break
					if(!found)
						return
					if(user.immortality>900)
						user.immortality=900
					spawn()
						while(user && user.immortality)
							user.immortality -= 10
							if(user.immortality < 0)
								user.immortality = 0
							sleep(100)
						user.sacrifice_level = null
						user.RecalculateStats()
						if(user) user << "Immortality has ended"
*/