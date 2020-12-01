skill
	haku
		copyable = 0




		sensatsu_suisho
			id = ICE_NEEDLES
			name = "Sensatsusuishô"
			description = "Creates needles of ice that pierce your enemy."
			icon_state = "ice_needles"
			default_chakra_cost = 200
			default_cooldown = 30
			default_seal_time = 8
			stamina_damage_fixed = list(400, 1300)
			stamina_damage_con = list(300, 300)
			wound_damage_fixed = list(1, 3)
			wound_damage_con = list(0, 0)



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
				viewers(user) << output("[user]: Sensatsusuishô!", "combat_output")

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


		Bursting_Water_Collision_Waves
			id = SUITON_BAKUSHOUHA
			name = "Water: Bursting Water Collision Waves"
			icon_state = "exploading_water_shockwave"
			default_chakra_cost = 500
			default_cooldown = 120
			default_seal_time = 10
			base_charge = 500
			copyable = 0



			Use(mob/human/user)
				var/conmult = (user.ControlDamageMultiplier()/3)
				Make_Water(user.loc)
				if(charge<=500)

					user.Timed_Stun(50)
					user.icon_state="HandSeals"

					user.dir=SOUTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=NORTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=EAST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=WEST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,1,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					user.icon_state=""

					return

				if(charge<=1000)

					user.Timed_Stun(50)
					user.icon_state="HandSeals"

					user.dir=SOUTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=NORTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=EAST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=WEST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,3,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)



					user.icon_state=""

					return
				if(charge<=1500)

					user.Timed_Stun(50)
					user.icon_state="HandSeals"

					user.dir=SOUTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),6)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=NORTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),6)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=EAST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),6)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=WEST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),6)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,5,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					user.icon_state=""

					return
				if(charge<=2000)

					user.Timed_Stun(50)
					user.icon_state="HandSeals"
					user.dir=SOUTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),8)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=NORTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),8)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=EAST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),8)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					sleep(5)
					user.dir=WEST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),8)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),2)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,7,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					user.icon_state=""

					return
				if(charge<=2500)

					user.Timed_Stun(50)
					user.icon_state="HandSeals"

					user.dir=SOUTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),10)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x-8,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+8,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-9,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+9,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=NORTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),10)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x-8,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+8,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-9,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+9,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=EAST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),10)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x,user.y-8,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+8,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-9,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+9,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					sleep(5)
					user.dir=WEST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),10)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),3)
					spawn()wet_proj(user.x,user.y-8,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+8,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-9,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+9,user.z,'icons/watershockwave.dmi',"",user,9,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					user.icon_state=""

					return
				if(charge<3500)

					user.Timed_Stun(50)
					user.icon_state="HandSeals"

					user.dir=SOUTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),12)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-8,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x+8,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x-9,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+9,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-10,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+10,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-11,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+11,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=NORTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),12)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-8,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x+8,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x-9,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+9,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-10,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+10,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-11,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+11,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=EAST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),12)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-8,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x,user.y+8,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x,user.y-9,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+9,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-10,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+10,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-11,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+11,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					sleep(5)
					user.dir=WEST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),12)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-8,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x,user.y+8,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),4)
					spawn()wet_proj(user.x,user.y-9,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+9,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-10,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+10,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-11,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+11,user.z,'icons/watershockwave.dmi',"",user,11,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					user.icon_state=""

					return
				if(charge>=3500)

					user.Timed_Stun(50)
					user.icon_state="HandSeals"

					user.dir=SOUTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),14)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-8,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+8,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-9,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x+9,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x-10,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+10,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-11,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+11,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-12,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+12,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-13,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+13,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=NORTH
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),14)
					spawn()wet_proj(user.x-1,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+1,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-2,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+2,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-3,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+3,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-4,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+4,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-5,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+5,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-6,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+6,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-7,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+7,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-8,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+8,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-9,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x+9,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x-10,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+10,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-11,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+11,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-12,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+12,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x-13,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x+13,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)

					sleep(5)
					user.dir=EAST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),14)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-8,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+8,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-9,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x,user.y+9,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x,user.y-10,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+10,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-11,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+11,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-12,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+12,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-13,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+13,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					sleep(5)
					user.dir=WEST
					spawn()wet_proj(user.x,user.y,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),14)
					spawn()wet_proj(user.x,user.y-1,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+1,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-2,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+2,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-3,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+3,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-4,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+4,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-5,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+5,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-6,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+6,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-7,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+7,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-8,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+8,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-9,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x,user.y+9,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),5)
					spawn()wet_proj(user.x,user.y-10,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+10,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-11,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+11,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-12,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+12,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y-13,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)
					spawn()wet_proj(user.x,user.y+13,user.z,'icons/watershockwave.dmi',"",user,13,(charge+(0.1*(user.con+user.conbuff)*conmult)),0)


					user.icon_state=""

					return
//Jon


proc
	Make_Water(loc)
		var/obj/water/W=new/obj/water
		W.loc=loc
		spawn(1200)
			del(W)



mob
	proc
		NearWater(range=world.view)
			//not needed as Iswater checks that
			/*for(var/obj/water/X in oview(src, range))
				return 1*/
			for(var/turf/X in oview(src, range))
				if(Iswater(X))
					return 1
			return 0


		ClosestWater(range=world.view)
			var/closest
			var/closest_dist = 1e40
			for(var/turf/X in oview(src, range))
				if(Iswater(X))
					var/new_dist = get_true_dist(src, X)
					if(new_dist < closest_dist)
						closest = X
						closest_dist = new_dist
			return closest




/*proc
	Mirrors(mob/target, mob/user)
		if(!target || !user) return

		var/atom/water = user.ClosestWater(10)
		if(!water) return

		var/obj/Q = new/obj/waterblob(locate(water.x,water.y,water.z))

		user.oldloc = user.loc
		user.loc = null
		if(user.client) user.client.eye = Q

		while(get_dist(Q, target) > 1)
			step_to(Q, target)
			CHECK_TICK
			if(!Q || !target || !user) return

		var/turf/cen = Q.loc
		if(user.client) user.client.eye = cen

		Q.loc = null
		Q = null

		var/mirrorlist[0]
		mirrorlist+=Make_Mirror(cen, -2, 0, "Right", user, pixel_x = -16)
		mirrorlist+=Make_Mirror(cen, -2, 1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -2, -1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 0, 2, "Back", user, pixel_y = 16)
		mirrorlist+=Make_Mirror(cen, 1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 2, 0, "Left", user, pixel_x = 16)
		mirrorlist+=Make_Mirror(cen, 2, 1, "Left", user)
		mirrorlist+=Make_Mirror(cen, 2, -1, "Left", user)
		mirrorlist+=Make_Mirror(cen, -1, -2, "Back", user, hide = 1)
		mirrorlist+=Make_Mirror(cen, 0, -2, "Back", user, pixel_y = -16, hide = 1)
		mirrorlist+=Make_Mirror(cen, 1, -2, "Back", user, hide = 1)

		mirrorlist+=Make_Mirror(cen, -2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, -2, 2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, 2, "", user)

		return list("center" = cen, "mirrors" = mirrorlist)


	Make_Mirror(atom/start, dx, dy, state, mob/user, pixel_x=0, pixel_y=0, hide=0)
		if(!user || !start)
			return

		var/turf/mirror_loc=locate(start.x+dx,start.y+dy,start.z)
		if(!mirror_loc) return

		var/obj/mirror/X=new/obj/mirror(mirror_loc)
		X.invisibility = 101

		switch(state)
			if("Back")
				if(!hide)
					X.icon=user.icon
					X.overlays+=user.overlays
				X.underlays+=/obj/mirror/Back
				X.overlays+=/obj/mirror/Front

			if("Right", "Left")
				X.icon='icons/Haku.dmi'
				X.icon_state=state

		X.pixel_x=pixel_x
		X.pixel_y=pixel_y

		spawn()
			var/obj/Q = new/obj/waterblob(start)
			while(Q.loc != mirror_loc)
				step_to(Q, mirror_loc)
				CHECK_TICK
				if(!user)
					Q.loc = null
					return

			Q.icon_state="none"
			switch(state)
				if("Right")
					Q.dir=EAST
				if("Left")
					Q.dir=WEST
				if("Back")
					Q.dir=NORTH
			flick("formmirrors",Q)
			sleep(12)
			Q.loc = null
			X.invisibility = 0

		return X*/


/*proc
	Mirrors(mob/target, mob/user)
		if(!target || !user) return

		var/atom/water = user.ClosestWater(10)
		if(!water) return

		var/obj/Q = new/obj/waterblob(locate(water.x,water.y,water.z))
		while(get_dist(Q, target) > 1)
			step_to(Q, target)
			CHECK_TICK
			if(!Q || !target || !user) return

		var/turf/cen = Q.loc
		Q.loc = null
		Q = null

		var/mirrorlist[0]
		mirrorlist+=Make_Mirror(cen, -2, 0, "Right", user, pixel_x = -16)
		mirrorlist+=Make_Mirror(cen, -2, 1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -2, -1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 0, 2, "Back", user, pixel_y = 16)
		mirrorlist+=Make_Mirror(cen, 1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 2, 0, "Left", user, pixel_x = 16)
		mirrorlist+=Make_Mirror(cen, 2, 1, "Left", user)
		mirrorlist+=Make_Mirror(cen, 2, -1, "Left", user)
		mirrorlist+=Make_Mirror(cen, -1, -2, "Back", user, hide = 1)
		mirrorlist+=Make_Mirror(cen, 0, -2, "Back", user, pixel_y = -16, hide = 1)
		mirrorlist+=Make_Mirror(cen, 1, -2, "Back", user, hide = 1)
		return list("center" = cen, "mirrors" = mirrorlist)

*/

proc
	Mirrors(mob/target, mob/user)
		if(!target || !user) return

		var/atom/water = user.ClosestWater(10)
		if(!water) return

		var/obj/Q = new/obj/waterblob(locate(water.x,water.y,water.z))

		user.oldloc = user.loc
		//user.loc = null
		if(user.client) user.client.eye = Q

		var/step_count=20
		while(get_dist(Q, target) > 1 && step_count>0)
			step_to(Q, target)
			step_count--
			sleep(1)
			if(!Q || !target || !user) return

		var/turf/cen = Q.loc
		if(user.client) user.client.eye = cen

		Q.loc = null
		Q = null

		var/mirrorlist[0]
		mirrorlist+=Make_Mirror(cen, -2, 0, "Right", user, pixel_x = -16)
		mirrorlist+=Make_Mirror(cen, -2, 1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -2, -1, "Right", user)
		mirrorlist+=Make_Mirror(cen, -1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 0, 2, "Back", user, pixel_y = 16)
		mirrorlist+=Make_Mirror(cen, 1, 2, "Back", user)
		mirrorlist+=Make_Mirror(cen, 2, 0, "Left", user, pixel_x = 16)
		mirrorlist+=Make_Mirror(cen, 2, 1, "Left", user)
		mirrorlist+=Make_Mirror(cen, 2, -1, "Left", user)
		mirrorlist+=Make_Mirror(cen, -1, -2, "Back", user, hide = 1)
		mirrorlist+=Make_Mirror(cen, 0, -2, "Back", user, pixel_y = -16, hide = 1)
		mirrorlist+=Make_Mirror(cen, 1, -2, "Back", user, hide = 1)

		mirrorlist+=Make_Mirror(cen, -2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, -2, "", user)
		mirrorlist+=Make_Mirror(cen, -2, 2, "", user)
		mirrorlist+=Make_Mirror(cen, 2, 2, "", user)

		return list("center" = cen, "mirrors" = mirrorlist)

	Make_Mirror(atom/start, dx, dy, state, mob/user, pixel_x=0, pixel_y=0, hide=0)
		if(!user || !start)
			return

		var/turf/mirror_loc=locate(start.x+dx,start.y+dy,user.z)
		if(!mirror_loc) return

		var/obj/mirror/X=new/obj/mirror(mirror_loc)
		X.invisibility = 101

		switch(state)
			if("Back")
				if(!hide)
					X.icon=user.icon
					X.overlays+=user.overlays
				X.underlays+=/obj/mirror/Back
				X.overlays+=/obj/mirror/Front

			if("Right", "Left")
				X.icon='icons/Haku.dmi'
				X.icon_state=state

		X.pixel_x=pixel_x
		X.pixel_y=pixel_y

		spawn()
			var/obj/Q = new/obj/waterblob(start)
			while(Q.loc != mirror_loc)
				step_to(Q, mirror_loc)
				sleep(1)
				if(!user)
					del(Q)
					return

			Q.icon_state="none"
			switch(state)
				if("Right")
					Q.dir=EAST
				if("Left")
					Q.dir=WEST
				if("Back")
					Q.dir=NORTH
			flick("formmirrors",Q)
			sleep(12)
			del(Q)
			X.invisibility = 0

		return X

obj
	mirror
		layer=MOB_LAYER
		density=1




		Back
			icon='icons/Haku.dmi'
			icon_state="Back"




		Front
			icon='icons/Haku.dmi'
			icon_state="Front"



		New()
			..()
			spawn(900)
				loc = null




	waterblob
		icon='icons/Haku.dmi'
		icon_state="water"
		layer=MOB_LAYER+3
		density=0




	iceneedle
		icon='icons/Haku.dmi'
		icon_state="Needles"
		layer=MOB_LAYER+3
		density=0
		var/tmp/mob/human/muser


		New()
			..()
			flick("formNeedles",src)

		Move()
			..()
			for(var/mob/human/player/O in src.loc)
				if(istype(O, /mob/human/player))
					if(O != muser)
						O = O.Replacement_Start(muser)
						O.Timed_Move_Stun(10)
						//O.move_stun+=3
						var/conmult = muser.ControlDamageMultiplier()
						O.Damage((rand(200,300)+70*conmult), 0, muser, "Ice Needles", "Normal")
						//O.Dec_Stam((rand(200,300)+70*conmult),0,user)
						O.Hostile(muser)
						Blood2(O,muser)
						spawn(5) if(O) O.Replacement_End()


