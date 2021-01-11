skill
	haku
		copyable = 0

		haku_clan
			id = HAKU_CLAN
			icon_state = "doton"
			name = "Haku"
			description = "Haku Clan Jutsu."
			stack = "false"//don't stack
			clan=1
			canbuy=0

		sensatsu_suisho
			id = ICE_NEEDLES
			name = "Ice Needles"
			description = "Creates needles of ice that pierce your enemy."
			icon_state = "ice_needles"
			default_chakra_cost = 200
			default_cooldown = 30
			default_seal_time = 8
			stamina_damage_fixed = list(400, 1300)
			stamina_damage_con = list(300, 300)
			wound_damage_fixed = list(1, 3)
			wound_damage_con = list(0, 0)
			cost = 800
			skill_reqs = list(HAKU_CLAN)


			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.MainTarget())
						Error(user, "No Target")
						return 0
					if(!user.NearWater(10))
						Error(user, "Must be near water")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Sensatsusuish�!", "combat_output")

				var/atom/found = user.ClosestWater(10)
				if(!found) return

				var/mob/human/etarget = user.MainTarget()
				var/obj/Q = new/obj/waterblob(locate(found.x,found.y,found.z))

				var/steps = 25
				while(steps > 0 && etarget && Q && (Q.x!=etarget.x || Q.y!=etarget.y) && Q.z==etarget.z && user)
					sleep(1)
					step_to(Q, etarget)
					--steps

				if(!etarget)
					Q.loc = null
					return
				if(!Q) return
				Q.icon_state="none"
				flick("water-needles",Q)
				sleep(1)
				if(!etarget)
					Q.loc = null
					return
				if(!Q) return

				var/list/EX=new
				EX+=new/obj/iceneedle(locate(Q.x+1,Q.y,Q.z))
				EX+=new/obj/iceneedle(locate(Q.x-1,Q.y,Q.z))
				EX+=new/obj/iceneedle(locate(Q.x,Q.y-1,Q.z))
				EX+=new/obj/iceneedle(locate(Q.x,Q.y+1,Q.z))
				EX+=new/obj/iceneedle(locate(Q.x+1,Q.y-1,Q.z))
				EX+=new/obj/iceneedle(locate(Q.x+1,Q.y+1,Q.z))
				EX+=new/obj/iceneedle(locate(Q.x-1,Q.y-1,Q.z))
				EX+=new/obj/iceneedle(locate(Q.x-1,Q.y+1,Q.z))
				var/turf/P = Q.loc

				Q.loc = null
				Q = null

				for(var/obj/iceneedle/M in EX)
					M.muser=user
					M.FaceTowards(P)


				spawn(1)
					for(var/obj/M in EX)
						if((M.x!=P.x) || (M.y!=P.y))
							step_to(M,P,0)
						M.icon_state = "NeedleHit"

				if(!user)
					for(var/obj/O in EX)
						O.loc = null
					return

				//var/conmult = user.ControlDamageMultiplier()

				/*
				for(var/mob/human/O in P)
					O = O.Replacement_Start(user)
					O.Timed_Move_Stun(30)
					//O.move_stun+=3
					O.Damage((rand(400,1300)+300*conmult), rand(1,3), user, "Ice Needles", "Normal")
					//O.Dec_Stam((rand(400,1300)+300*conmult),0,user)
					//O.Wound(rand(1,3),0,user)
					O.Hostile(user)
					Blood2(O,user)
					spawn(5) if(O) O.Replacement_End()
				*/
				spawn(30)
					for(var/obj/O in EX)
						O.loc = null




		ice_explosion
			id = ICE_SPIKE_EXPLOSION
			name = "Ice Explosion"
			description = "Creates many spikes of ice that protect you from your enemies after damaging anyone near by."
			icon_state = "ice_spike_explosion"
			default_chakra_cost = 350
			default_cooldown = 80
			default_seal_time = 5
			stamina_damage_fixed = list(1000, 1500)
			stamina_damage_con = list(300, 300)
			wound_damage_fixed = list(3, 6)
			wound_damage_con = list(0, 0)
			cost = 1500
			skill_reqs = list(ICE_NEEDLES)


			Use(mob/human/user)
				user.Protect(38)
				viewers(user) << output("[user]: Ice Explosion!", "combat_output")

				spawn(2)Haku_Spikes(user.x,user.y+1,user.z)
				spawn(1)Haku_Spikes(user.x-1,user.y+2,user.z)
				spawn(1)Haku_Spikes(user.x-1,user.y,user.z)
				spawn(1)Haku_Spikes(user.x+1,user.y+2,user.z)
				spawn(1)Haku_Spikes(user.x+1,user.y,user.z)
				var/conmult = user.ControlDamageMultiplier()
				for(var/mob/human/X in ohearers(2,user))
					X = X.Replacement_Start(user)
					X.Damage(rand(1000,1500)+500*conmult,rand(3,6),user,"Ice Explosion","Normal")
					X.Hostile(user)
					Blood2(X)
					spawn(5) if(X) X.Replacement_End()




		demonic_ice_crystal_mirrors
			id = DEMONIC_ICE_MIRRORS
			name = "Demonic Ice Crystal Mirrors"
			description = "Creates mirrors of ice that hide you from your enemies. Anyone caught inside the mirrors is pierced by many needles!"
			icon_state = "demonic_ice_mirrors"
			default_chakra_cost = 850
			default_cooldown = 200
			default_seal_time = 10
			stamina_damage_fixed = list(1000, 1750)
			stamina_damage_con = list(500, 500)
			wound_damage_fixed = list(10, 25)
			wound_damage_con = list(0, 0)
			cost = 2500
			skill_reqs = list(ICE_SPIKE_EXPLOSION)


			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/etarget = user.MainTarget()
					if(!etarget || !etarget.client || (etarget && (etarget.chambered || etarget.sandshield || etarget.ko) ))
						//Can only use mirrors on clients, should solve mirrors used on bunshins.
						Error(user, "No Valid Target")
						return 0
					if(!user.NearWater(10))
						Error(user, "Must be near water")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Demonic Ice Crystal Mirrors!", "combat_output")

				var/mob/human/etarget = user.MainTarget()
				var/conmult = user.ControlDamageMultiplier()
				user.Begin_Stun()
				user.protected=999

				if(etarget)
					user.incombo=1
					user.invisibility=10
					spawn(250)
						if(user && user.invisibility==10)
							user.invisibility=0

					if(!etarget.x)
						user.invisibility=0
						user.End_Stun()
						user.End_Protect()
						user.protected=0
						return

					var/list/ret = Mirrors(etarget, user)
					if(!ret || !istype(ret)) return
					var/list/mirrorlist = ret["mirrors"]
					var/turf/cen = ret["center"]


					for(var/mob/G in range(2,cen))
						G.cantshun=1//Fix Shunhsin out of Ice Mirrors?


					sleep(20)

					var/demonmirrored = 0

					var/list/Gotchad=new
					for(var/mob/G in range(2,cen))
						if(G!=user)
							if(!Gotchad.Find(G))
								Gotchad+=G //add them if they weren't in the list before
							G = G.Replacement_Start(user)
							demonmirrored = 1
							spawn() G.Timed_Stun(180)
							spawn() G.Hostile(user)

					if(demonmirrored)
						for(var/obj/M in mirrorlist)
							if(M.icon!='icons/Haku.dmi')
								flick("Throw1",M)

							//Remove mobs who are not in range anymore
							for(var/mob/OG in Gotchad)
								if(!OG in range(2,cen))
									Gotchad-=OG

							for(var/mob/OG in Gotchad)
								spawn() if(OG) projectile_to('icons/projectiles.dmi',"needle-m",M,OG)
								if(!OG.icon_state)
									OG.icon_state="Hurt"
									spawn(10)
										if(OG && OG.icon_state=="Hurt")
											OG.icon_state=""

						for(var/mob/G in range(2,cen))
							if(G != user)
								if(!Gotchad.Find(G))
									Gotchad+=G //add them if they weren't in the list before
								if(!G.ironskin)
									G.overlays += 'icons/needlepwn.dmi'

						sleep(2)

						for(var/i in 1 to 5)
							for(var/obj/M in mirrorlist)
								if(M.icon!='icons/Haku.dmi')
									flick("Throw1",M)

								for(var/mob/OG in Gotchad)
									spawn()projectile_to('icons/projectiles.dmi',"needle-m",M,OG)

								sleep(2)

						spawn(5)
							for(var/mob/OG in Gotchad)
								OG.End_Stun()
								OG.Damage(rand(800,1550)+1800*conmult,rand(15,35),user,"Demonic Ice Mirrors","Normal")
								OG.Replacement_End()

						user.loc = user.oldloc
						if(user.client) user.client.eye = usr
						user.End_Stun()
						user.End_Protect()
						user.invisibility=0
						user.incombo=0

						for(var/obj/M in mirrorlist)
							M.loc = null

						spawn(100)
							for(var/mob/OG in Gotchad)
								OG.overlays-='icons/needlepwn.dmi'
								OG.cantshun=0 //enable Shunshin

					else
						user.loc = user.oldloc
						if(user.client) user.client.eye = usr

						user.End_Stun()
						user.End_Protect()
						user.invisibility=0
						user.incombo=0
						for(var/obj/M in mirrorlist)
							M.loc = null
						return

				user.End_Stun()
				user.End_Protect()
				user.invisibility=0