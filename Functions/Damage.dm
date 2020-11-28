mob/human/npc/Damage()
	return

mob
	proc
		Damage(stamina_dmg, wound_dmg, mob/human/attacker, source, class)
			if(auto_ez) //ez system
				src.auto_ez=0
				src.overlays-='icons/leech.dmi'
				src << "You've stopped Ezing, you gained a total of [auto_ez_total] experience."

			if(ko || (!pk && !istype(src,/mob/human/Puppet)) || mole) return


			if(src.cursing)
				src.cursing = 0
				var/mob/human/Puppet/Cursed_Doll/puppet = new/mob/human/Puppet/Cursed_Doll(src.loc)
				Poof(src.x,src.y,src.z)

				puppet.realname = "[attacker]'s Cursed Doll"
				puppet.name = "[attacker]'s Cursed Doll"
				puppet.faction = src.faction
				puppet.CreateName(255, 255, 255)
				puppet.connected_mob = attacker
				spawn() puppet.PuppetRegen(src)
				spawn(src.int/2)
					if(puppet)
						puppet = null

			if(istype(attacker, /mob/human/player/npc/kage_bunshin))
				stamina_dmg /= 4
				wound_dmg /= 4

			if(attacker && attacker != src)
				if(attacker.client)
					lasthostile = attacker.key

				if(src.using_crow)
					//M.using_crow = 0
					src.Protect(25)

					flick("Form", src)

					sleep(10)

					if(!attacker|| !src) return

					src.AppearBehind(attacker)

					flick("Reform", src)
					return

			var/piercing_stamina_dmg = 0
			if(source == "Taijutsu" && attacker && attacker.skillspassive[PIERCING_STRIKE])
				piercing_stamina_dmg = round(stamina_dmg * (attacker.skillspassive[PIERCING_STRIKE] * 0.02))
				stamina_dmg += piercing_stamina_dmg
			/*	piercing_stamina_dmg = round(stamina_dmg * 3 * attacker.skillspassive[PIERCING_STRIKE] / 100)
				stamina_dmg -= piercing_stamina_dmg*/

			var/deflection_stamina_dmg = 0
			var/ironskin_stamina_dmg = 0
			if(class != "Internal")
				if(IsProtected() || kaiten) return

				if(class == "Normal")
					if(length(pet) && loc)
						var/mob/human/sandmonster/S = locate() in (pet & loc.contents)
						if(S)
							flick("hurt", S)
							S.hp -= stamina_dmg/100
							if(S.hp <= 0)
								S.loc = null
							return

				if(clan == "Sand Control")
					if(sanddenfence >= 1)
						sanddenfence = 0
						for(var/obj/sandprotection/shield in src.overlays)
							flick("[src.dir]", shield)
						sleep(5)
						sanddenfence = 1
						return




				if(gaaramass && !chambered)
					protected=1
					overlays+=image("Sand_protect.dmi")
					sleep(6)
					overlays-=image("Sand_protect.dmi")
					if(stamina_dmg<=500)
						gaaramass-=1
					else if(stamina_dmg<=1000)
						gaaramass-=2
					else if(stamina_dmg<=1500)
						gaaramass-=3
					else if(stamina_dmg<=2000)
						gaaramass-=4
					else if(stamina_dmg<=2500)
						gaaramass-=5
					else if(stamina_dmg<=3000)
						gaaramass-=6
					else if(stamina_dmg<=3500)
						gaaramass-=7
					else if(stamina_dmg<=4000)
						gaaramass-=8
					else if(stamina_dmg<=4500)
						gaaramass-=9
					else if(stamina_dmg<=5000)
						gaaramass-=10
						//world.log<<"-10"
						if(gaaramass <= 0)
							gaaramass = 0
							protected=0
							for(var/sand/gaara_mass/G in oview(5, usr))
								if(G.owner == src)
									del G
							var/skill/SB = GetSkill(SAND_SUMMON)
							for(var/skillcard/card in SB.skillcards)
								card.overlays -= 'icons/dull.dmi'
							spawn() SB.DoCooldown(src)
						return

					if(sandarmor && !chambered)
						--sandarmor
						if(sandarmor == 0)
							var/skill/SA = GetSkill(SAND_ARMOR)
							for(var/skillcard/card in SA.skillcards)
								card.overlays -= 'icons/dull.dmi'
							spawn() SA.DoCooldown(src)
						return


					if(sandarmor && !chambered)
						if(stamina_dmg<300)
							return
						if(stamina_dmg>=300)
							--sandarmor
							if(sandarmor == 0)
								var/skill/SA = GetSkill(SAND_ARMOR)
								for(var/skillcard/card in SA.skillcards)
									card.overlays -= 'icons/dull.dmi'
								spawn() SA.DoCooldown(src)
							return

				if(locate(/obj/Shield) in orange(1, src))
					return

				if(chambered)
					var/damage = stamina_dmg + wound_dmg*100
					chambered -= damage
					if(chambered < 0) chambered = 0

					if(chambered)
						combat("<font color=#eca940>The doton chamber took [damage] from [attacker]!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to the doton chamber!")
						return
					else
						combat("<font color=#eca940>The doton chamber took [damage] from [attacker] and it crumbled!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to the doton chamber and it crumbled!")
						for(var/obj/earthcage/o in view(0,src))
							o.icon_state = "Crumble"
							o.crumbled = 1
							return

				if(DefenceSusanoo)
					var/damage = stamina_dmg + wound_dmg*100
					DefenceSusanoo -= damage
					if(DefenceSusanoo < 0) DefenceSusanoo = 0

					if(DefenceSusanoo)
						combat("<font color=#eca940>Susanoo took [damage] from [attacker]!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to Susanoo!")
						return
					else
						combat("<font color=#eca940>Susanoo took [damage] from [attacker] and it broke!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to Susanoo and it broke!")
						InSusanoo = 0
						return

				if(attacker && attacker.skillspassive[BLINDSIDE] && attacker != src && attacker.squad != src.squad && source != "Rend" && !byakugan && !impbyakugan && !istype(src,/mob/human/Puppet) && !istype(attacker,/mob/human/Puppet))
					FilterTargets()
					if(!(attacker in active_targets))
						if(attacker in targets)
							piercing_stamina_dmg *= (1 + 0.05*attacker.skillspassive[BLINDSIDE])
							stamina_dmg *= (1 + 0.05*attacker.skillspassive[BLINDSIDE])
							wound_dmg *= (1 + 0.05*attacker.skillspassive[BLINDSIDE])
						else
							piercing_stamina_dmg *= (1 + 0.10*attacker.skillspassive[BLINDSIDE])
							stamina_dmg *= (1 + 0.10*attacker.skillspassive[BLINDSIDE])
							wound_dmg *= (1 + 0.10*attacker.skillspassive[BLINDSIDE])

				if(boneharden)
					// TODO: Real math rather than these for loops
					while(curchakra > 0 && stamina_dmg > 0)
						--curchakra
						stamina_dmg -= 3
					stamina_dmg = max(0, stamina_dmg)

					while(curchakra >= 30 && wound_dmg >= 1)
						curchakra -= 30
						--wound_dmg
					wound_dmg = max(0, wound_dmg)

				if(pill == 3)
					if(stamina_dmg > 2) stamina_dmg *= 0.7
					wound_dmg *= 0.8


				if(Size == 1)
					if(stamina_dmg > 2) stamina_dmg *= 1.5
					if(wound_dmg > 2) wound_dmg *= 1.5
					wound_dmg = min(wound_dmg, 20)

				if(Size == 2)
					if(stamina_dmg > 2) stamina_dmg *= 2
					if(wound_dmg > 2) wound_dmg *= 2
					wound_dmg = min(wound_dmg, 20)

				if(gate >= 4)
					stamina_dmg *= 1.5

				if(human_puppet == 2)
					stamina_dmg *= 0.7


				if(Tank)
					wound_dmg = min(wound_dmg, 10)

				if(isguard)
					stamina_dmg /= 2
					stamina_dmg -= (stamina_dmg * 0.01 * skillspassive[9])

				if(madarasusano==1 && isguard)
					stamina_dmg *= 0.75

				if(sasukesusano == 1 && isguard)
					stamina_dmg *= 0.75

				if(itachisusano == 1 && isguard)
					stamina_dmg *= 0.75

				if(ironmass == 1 && isguard)
					stamina_dmg *= 0.85

				if((locate(/obj/Shield) in oview(1,src)))// && !internal)
					return

				if(clan == "Battle Conditioned")
					stamina_dmg *= 0.8
					if(class == "Normal") wound_dmg *= 0.85

				if(clan == "Jashin")
					wound_dmg = min(wound_dmg, 100)

				if(src.crystal_armor)//&&!xpierce)
					stamina_dmg *= 0.8
					flick('icons/crystal_break.dmi',x)
				if(paper_armor)// && !xpierce)
					stamina_dmg *= 0.8
				if(lightning_armor>1)// && !xpierce)
					stamina_dmg *= 0.7
				if(shukaku==1||nibi==1||yonbi==1||sanbi==1||gobi==1||rokubi==1||shichibi==1||hachibi==1||kyuubi==1)
					stamina_dmg *= 0.7

			/*	if(src.spacetimebarrier&&!xpierce&&!internal)
					if(!attacker||!src) return
					var/obj/space/f = new/obj/space(src.loc)
					spawn(20) del(f)
					var/X=rand(1,5)
					var/V=pick(1,2)
					switch(V)
						if(1)
							if(attacker)
								attacker.loc = (locate(src.x+X,src.y+X,src.z))
								flick('icons/space1.dmi',attacker)
								attacker.Facedir(src)
							else return
						if(2)
							if(attacker)
								attacker.loc = (locate(src.x-X,src.y-X,src.z))
								flick('icons/space1.dmi',attacker)
								attacker.Facedir(src)
							else return
					var/mob/F = attacker
					F.stunned=rand(3,4)
					src.spacetimebarrier=0
					return*/

				if(src.petals)
					flick('icons/petals.dmi',src)
					sleep(3)
					src.AppearBehind(attacker)
					if(attacker)attacker.RemoveTarget(src)
					return

				if(controlling_yamanaka&&usr)
					if(usr)
						var/mob/Mind_Contract=src.Transfered
						if(Mind_Contract)
							Mind_Contract.Wound(x+3,3,usr,1)
							if(Mind_Contract)
								Mind_Contract.Hostile(usr)
							if(Mind_Contract)
								Mind_Contract.combat("You've taken Wound damage from [usr]")
								combat("As a result of attempting to hurt [Mind_Contract] has given you [x] wound damage as well")


				if(class == "Normal")

					var/distance = get_dist(src, attacker)
					if(istype(attacker,/mob/human/player))
						if(attacker.papermode==1 && (distance >= 0 && distance <2))
							if(rand(0,100) < 6)
								flick('icons/paper bind.dmi',src)
								src.Begin_Stun()
								src.overlays+='paper_bind2.dmi'
								spawn(20)
									src.overlays-='paper_bind2.dmi'
									src.End_Stun()

					if(immortality==1)
						stamina_dmg -= stamina_dmg
						wound_dmg -= wound_dmg

					if(istype(attacker,/mob/human/player))
						if((war && !attacker.war) || (!war && attacker.war))
							stamina_dmg -= stamina_dmg
							wound_dmg -= wound_dmg

						if(attacker.shuned==1)
							stamina_dmg /= 2
							wound_dmg /= 2

						if(attacker.sanbi==1)
							var/PO = rand(50, usr.con/2)
							src.curchakra -= PO
							attacker.curchakra += PO * 0.80

						if(attacker.shichibi==1)
							src.Poison+=rand(4,8)

					if(ironskin)
						stamina_dmg /= 2
						//ironskin_stamina_dmg = wound_dmg * 100
						wound_dmg = 0

					if(wound_dmg)
						var/effective_armor = AC / 100
						if(isguard)
							effective_armor = 1
						effective_armor = max(0, min(effective_armor, 1))

						var/min_dmg = (effective_armor >= 1)?(1):(0) //(0):(1)
						wound_dmg = max(min_dmg, wound_dmg * (1-effective_armor) + wound_dmg * effective_armor * (100/(str+strbuff-strneg)))

				if(skillspassive[DEFLECTION])
					var/checked_wounds = 0

					while(checked_wounds < wound_dmg && (deflection_stamina_dmg + 100) < curstamina)
						++checked_wounds
						if(prob(3*skillspassive[DEFLECTION]))
							--wound_dmg
							deflection_stamina_dmg += 100

			var/total_stamina_dmg = max(0, round(stamina_dmg + piercing_stamina_dmg + deflection_stamina_dmg + ironskin_stamina_dmg))
			var/stamina_msg = ""
			if(total_stamina_dmg > 0)
				var/detailed_stamina_msg = ""

				if(piercing_stamina_dmg || deflection_stamina_dmg || ironskin_stamina_dmg)
					detailed_stamina_msg = " ([stamina_dmg]"
					if(piercing_stamina_dmg)
						detailed_stamina_msg += " + [piercing_stamina_dmg] piercing"
					if(deflection_stamina_dmg)
						detailed_stamina_msg += " + [deflection_stamina_dmg] deflection"
					if(ironskin_stamina_dmg)
						if(ironskin == 1)
							detailed_stamina_msg += " + [ironskin_stamina_dmg] Iron Skin"
						else if(ironskin == 2)
							detailed_stamina_msg += " + [ironskin_stamina_dmg] Larch Dance"
					detailed_stamina_msg += ")"

				stamina_msg = "[total_stamina_dmg][detailed_stamina_msg] stamina damage"

			wound_dmg = max(0, round(wound_dmg))
			var/wound_msg = ""
			if(wound_dmg > 0)
				// TODO: Why is this proc (Damage)  not implemented on /mob/human anyway...
				if(istype(src, /mob/human) && src:HasSkill(MASOCHISM))
					var/Rlim=round(rfx/2.5)-rfxbuff
					var/Slim=round(str/2.5)-strbuff
					if(Rlim<0)
						Rlim=0
					if(Slim<0)
						Slim=0
					var/R=round(rfx/10)
					var/S=round(str/10)
					if(R>Rlim)
						R=Rlim
					if(S>Slim)
						S=Slim
					rfxbuff+=R
					strbuff+=S
					spawn(200)
						rfxbuff-=R
						strbuff-=S
						/*if(rfxbuff<=0)
							rfxbuff=0
						if(strbuff<=0)
							strbuff=0*/

				if(Contract && source != "Sorcery: Death-Ruling Possession Blood")
					var/obj/C = Contract
					if(loc == C.loc && Contract2)
						var/mob/F = Contract2
						wound_msg += " (Blood Contract => [F])"
						if(source == "Stab Self")
							F.Damage(150, wound_dmg, src, "Sorcery: Death-Ruling Possession Blood", "Internal")
						else
							F.Damage(0, wound_dmg, src, "Sorcery: Death-Ruling Possession Blood", "Internal")
						if(F) spawn() F.Hostile(usr)
				if(source == "Stab Self")//due to the wound cap change for jashins, I am making stab self do 8 wounds to the user and 10 wounds to the contract
					wound_dmg -= 2
				wound_msg = "[wound_dmg] wounds"

			var/join_msg = ""
			if(stamina_msg && wound_msg)
				join_msg = " and "

			if(source != "Gate Stress" && source != "Pill Stress") combat("<font color=#eca940>You took [stamina_msg][join_msg][wound_msg][attacker?" from [attacker]":""]!")
			if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [stamina_msg][join_msg][wound_msg][attacker?" to [src]":""]!")

			if(istype(src,/mob/human/player/npc/creep) && (total_stamina_dmg||wound_dmg) && attacker && attacker.client)
				src:lasthurtme = attacker

			if(istype(src,/mob/human/Puppet/Cursed_Doll))
				var/mob/human/Puppet/Cursed_Doll/CD = src
				if(CD.connected_mob)
					var/mob/human/player/P = CD.connected_mob
					P.curstamina -= total_stamina_dmg
					P.curwound += wound_dmg


			curstamina -= total_stamina_dmg
			curwound += wound_dmg

			if(curstamina <= 0 && source != "KO")
				spawn() KO()

			if(attacker && attacker.clan == "Ruthless")
				if(total_stamina_dmg > 0)//stop division by 0 error
					if(total_stamina_dmg < 250)//probably tai/low dmg
						if(prob(33)) //33% chance to boost
							attacker.adren += round(total_stamina_dmg / min(125,total_stamina_dmg)) + wound_dmg
							//attacker<<"Ruthy Boost+:[round(total_stamina_dmg / 100) + wound_dmg]"
					else
						attacker.adren += round(total_stamina_dmg / 250) + wound_dmg
						//attacker<<"Ruthy Boost+:[round(total_stamina_dmg / 250) + wound_dmg]"

				attacker.statBoost()

			//This should be handled by Hostile not by Damage. Removing, hopefully it doesn't break too many things. I'll fix it later if it does.
			//if(asleep)
			//	asleep = 0

		// TODO: These procs should be removed eventually. Just here for transitional purposes.
		Dec_Stam(x,xpierce,mob/attacker, hurtall,taijutsu, internal)
			Damage(x, 0, attacker, taijutsu?"Tajutsu":"Stamina", internal?"Internal":"Normal")

		Wound(x,xpierce, mob/attacker, reflected)
			Damage(0, x, attacker, reflected?"Sorcery: Death-Ruling Possession Blood":"Wound", (xpierce>=3)?"Internal":"Normal")