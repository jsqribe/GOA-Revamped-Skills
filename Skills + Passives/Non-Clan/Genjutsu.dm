
mob
	var
		using_crow = 0


obj
	sleep_genjutsu_feathers
		icon  = 'icons/genjutsu2.dmi'
		layer = MOB_LAYER + 1


skill
	genjutsu

		copyable = 1
		temple_of_nirvana
			id = SLEEP_GENJUTSU
			name = "Genjutsu: Temple of Nirvana"
			description = "Puts everyone in a large area to sleep."
			icon_state = "sleep_genjutsu"
			default_chakra_cost = 550
			default_cooldown = 220


			Use(mob/user)
				user.icon_state = "Seal"
				spawn()
					user.Timed_Stun(50)
				spawn(50)
					user.icon_state = ""

				var/mob/human/target = user.MainTarget()
				var/turf/center = user.loc

				if(target)
					center = target.loc

				if(center)
					var/r = limit(1, round((user.int+user.intbuff-user.intneg)/50) + 1, 5)
					var/images[0]
					var/area[0]

					for(var/turf/T in range(center, r))
						images += image('icons/genjutsu2.dmi', T)
						area += T

					for(var/image/I in images)
						world << I


					var/user_effective_int = (user.int+user.intbuff-user.intneg)*(1 + 0.05*user.skillspassive[19])

					spawn(20)

						for(var/mob/human/M in (range(center, r)))// - resisted))
							sleep(1)
							if(M != user && !M.ko && !M.IsProtected() && !(istype(M,/mob/human/Puppet)))
								var/resisted
								if(M.isguard && M.skillspassive[21])
									var/resist_roll=Roll_Against(user_effective_int,(M.con+M.conbuff-M.conneg)*(1 + 0.05*(M.skillspassive[21]-1)),100)
									if(resist_roll < 4)
										resisted = 1
								if(!resisted)
									M.gen_effective_int = user_effective_int
									flick("Knockout", M)
									M.Begin_Stun()
									M.icon_state = "Dead"
									M.asleep = 1
									var/sleep_time = 200
									spawn()
										while(M && (sleep_time > 0) && M.asleep && !M.ko)
											sleep_time--
											sleep(1)
										if(M)
											M.icon_state=""
											M.End_Stun()
											M.asleep=0


						for(var/image/I in images)
							del I



		fear
			id = PARALYZE_GENJUTSU
			name = "Genjutsu: Fear"
			description = "Slows the actions of anyone looking at you."
			icon_state = "paralyse_genjutsu"
			default_chakra_cost = 100
			default_cooldown = 60



			Use(mob/user)
				user.icon_state = "Seal"
				spawn() user.Timed_Stun(20)
				sleep(20)
				user.icon_state = ""

				user.FilterTargets()
				var/user_effective_int = (user.int+user.intbuff-user.intneg)*(1 + 0.05*user.skillspassive[19])
				for(var/mob/human/T in (user.targeted_by & oview(user)))
					if(!T.ko && !T.chambered)
						var/image/o = image('icons/genjutsu.dmi' ,T)
						T << o
						user << o
						var/result=Roll_Against(user_effective_int,(T.int+T.intbuff-T.intneg)*(1 + 0.05*T.skillspassive[19]),100)
						T.FilterTargets()
						if(!(user in T.active_targets))
							--result
						if(T.skillspassive[21] && T.isguard)
							var/resist_roll=Roll_Against(user_effective_int,(T.con+T.conbuff-T.conneg)*(1 + 0.05*(T.skillspassive[21]-1)),100)
							if(resist_roll < 4)
								result = 1
						T.gen_effective_int = user_effective_int
						var/duration
						if(result >= 6)
							//T.move_stun = 100
							duration = 120
						if(result == 5)
							//T.move_stun = 80
							duration = 100
						if(result == 4)
							//T.move_stun = 50
							duration = 70
						if(result == 3)
							//T.move_stun = 30
							duration = 50
						if(result == 2)
							//T.move_stun = 10
							duration = 30
						T.Timed_Move_Stun(duration)
						spawn()
							while(T && duration > 0 && !T.ko)
								duration--
								sleep(1)
							if(T && T.ko)
								T.Reset_Move_Stun()
								o.loc = null
								T.client.screen -= o
							if(T && o)
								o.loc = null
								T.client.screen -= o



		tree_bind
			id = TREE_BIND
			name = "Genjutsu: Tree Binding"
			icon_state = "tree_binding"
			default_chakra_cost = 650
			default_cooldown = 250
			default_seal_time = 10


			Use(mob/user)
				user.icon_state = "Seal"
				spawn() user.Timed_Stun(20)
				sleep(20)
				user.icon_state = ""

				var/mob/human/T = user.MainTarget()
				var/user_effective_int = (user.int+user.intbuff-user.intneg)*(1 + 0.05*user.skillspassive[19])
				if(T)
					if(!T.ko && !T.chambered)
						var/obj/o = new/obj/tree_binding(locate(T.x, T.y, T.z))
						//flick("Binding", o)
						var/result=Roll_Against(user_effective_int,(T.int+T.intbuff-T.intneg)*(1 + 0.05*T.skillspassive[19]),100)
						T.FilterTargets()
						if(!(user in T.active_targets))
							--result
						if(T.skillspassive[21] && T.isguard)
							var/resist_roll=Roll_Against(user_effective_int,(T.con+T.conbuff-T.conneg)*(1 + 0.05*(T.skillspassive[21]-1)),100)
							if(resist_roll < 4)
								result = 1
						T.gen_effective_int = user_effective_int
						var/duration
						if(result >= 6)
							//T.move_stun = 100
							duration = 100
						if(result == 5)
							//T.move_stun = 80
							duration = 80
						if(result == 4)
							//T.move_stun = 50
							duration = 60
						if(result == 3)
							//T.move_stun = 30
							duration = 40
						if(result == 2)
							//T.move_stun = 10
							duration = 20
						T.Timed_Move_Stun(duration)
						spawn()
							while(T && duration > 0 && !T.ko)
								duration--
								sleep(1)
							if(T) T.End_Stun()
							del(o)

		crow

			id = CROW
			name = "Crow Genjutsu"
			icon_state = "crow_depart"
			default_cooldown = 80
			default_chakra_cost = 200


			Activate(mob/human/user)
				if(user.using_crow)
					user.using_crow = 0
					return
				..(user)


			Use(mob/user)

				if(!user) return
				var/user_effective_int = (user.int+user.intbuff-user.intneg)*(1 + 0.05*user.skillspassive[19])
				user.combat("You are now in crow form for [round(user_effective_int/30)] seconds") //at 450int roughly 30secs
				//flick("Form", user)
				user.using_crow = 1

				spawn((user_effective_int/30)*10)
					if(user.using_crow)
						user.combat("You are no longer in crow form.")
						user.using_crow = 0




		sly_mind
			id = SLY_MIND
			name = "Genjutsu: Sly Mind Affect Technique"
			description = "Makes your enemie think hes moving when hes actually standing still."
			icon_state = "slymind"
			default_chakra_cost = 1100
			default_cooldown = 300

			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/etarget = user.MainTarget()
					if(!etarget || (etarget && (etarget.chambered || etarget.ko || etarget.inslymind)))
						Error(user, "No Valid Target")
						return 0

			Use(mob/user)
				user.icon_state="Seal"
				spawn(30)
					user.icon_state=""
				var/mob/human/etarget = user.MainTarget()
				var/user_effective_int = (user.int+user.intbuff-user.intneg)*(1 + 0.05*user.skillspassive[19])
				if(etarget)
					var/result=Roll_Against(user_effective_int,(etarget.int+etarget.intbuff-etarget.intneg)*(1 + 0.05*etarget.skillspassive[19]),80)
					if(etarget.skillspassive[21] && etarget.isguard)
						var/resist_roll=Roll_Against(user_effective_int,(etarget.con+etarget.conbuff-etarget.conneg)*(1 + 0.05*(etarget.skillspassive[21]-1)),100)
						if(resist_roll < 4)
							result = 1

					var/d=0
					if(result>=7)
						d=30
					if(result==6)
						d=27
					if(result==5)
						d=24
					if(result==4)
						d=21
					if(result==3)
						d=18
					if(result==2)
						d=15

					if(d > 0)
						user.combat("[etarget] is now in slymind")
						etarget.inslymind=1
						etarget.sly_mind_count=0
						etarget.sly_mind_x=etarget.x
						etarget.sly_mind_y=etarget.y
						etarget.sly_mind_z=etarget.z
						spawn()
							var/gentime = d*5
							while(gentime > 0 && etarget && !etarget.ko)
								gentime--
								sleep(1)
							if(etarget)
								user.combat("[etarget] is no longer in slymind")
								etarget.inslymind=0
								etarget.sly_mind_count=0


obj/tree_binding
	density=0
	icon='icons/tree5.dmi'
	pixel_y=-32


obj/Illusion
	New(loc)
		..(loc)
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "1",pixel_x = -32)
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "2")
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "3",pixel_x = 32)
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "4",pixel_x = -32,pixel_y = 32)
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "5",pixel_y = 32)
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "6",pixel_x = 32,pixel_y = 32)
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "7",pixel_x = -32,pixel_y = 64)
		overlays += image(icon = 'icons/illusion.dmi',icon_state = "8",pixel_y = 64)
