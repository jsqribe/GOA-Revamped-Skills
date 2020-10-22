skill
	namikaze

		hiraishin_1
			id = HIRAISHIN_1
			name = "Hiraishin: Teleport Level 1"
			icon_state = "thunder_god_1"
			default_chakra_cost = 300
			default_cooldown = 10
			copyable = 0


			IsUsable(mob/user)
				. = ..()
				if(.)
					for(var/obj/paper_bomb/p in view(1,user))
						if(p.owner != user)
							Error(user, "This cannot be used at this time.")
							return 0


			Use(mob/user)
				var/list/L=user.hiraishin
				L+="Nevermind"
				var/atom/spot=input("Where would you like to Teleport to") as anything in L
				L-="Nevermind"
				if(spot=="Nevermind")
					default_cooldown = 3
					return
				else
					default_cooldown = initial(default_cooldown)
					L-=spot
					spawn()Poof(user.x,user.y,user.z)
					user.loc=locate(spot.x,spot.y,spot.z)
					spawn()Poof(spot.x,spot.y,spot.z)
					if(istype(spot,/obj/thunder_god))
						var/obj/thunder_god/T=spot
						T.loc=null
					if(ismob(spot))
						var/mob/M=spot
						M.Timed_Stun(10)
						user.stunned=0
						user.End_Stun()
					user.hiraishin-=spot
		/*			var/obj/mapinfo/Minfo =  locate("__mapinfo__[spot.z]")
					var/obj/mapinfo/Minfo_ =  locate("__mapinfo__[user.z]")
					if(!Minfo||!Minfo_)
						default_cooldown = 3
						return
					if(Minfo.oX==5&&Minfo.oY==8&&Minfo_!=Minfo||Minfo_.oX==5&&Minfo_.oY==8&&Minfo_!=Minfo)
						default_cooldown = 3
						return //War Map

					if(Minfo&&Minfo_)
						spawn()Poof(user.x,user.y,user.z)
						user.loc=spot.loc
						spawn()Poof(spot.x,spot.y,spot.z)
						if(istype(spot,/obj/thunder_god))
							var/obj/thunder_god/T=spot
							T.loc=null
						if(ismob(spot))
							var/mob/M=spot
							M.stunned+=1*/


		hiraishin_2
			id = HIRAISHIN_2
			name = "Hiraishin: Teleport Level 2"
			icon_state = "thunder_god_3"
			default_chakra_cost = 200
			default_cooldown = 10
			copyable = 0


			IsUsable(mob/user)
				. = ..()
				if(.)
					for(var/obj/paper_bomb/p in view(1,user))
						if(p.owner != user)
							Error(user, "This cannot be used at this time.")
							return 0


			Use(mob/user)
				var/list/L=user.hiraishin
				L+="Nevermind"
				var/atom/spot=input("Where would you like to Teleport to") as anything in L
				L-="Nevermind"
				if(spot=="Nevermind")
					default_cooldown = 3
					return
				else
					var/targets[] = user.NearestTargets(num=3)
					if(targets && targets.len)
						for(var/mob/human/player/etarget in targets)
							default_cooldown = initial(default_cooldown)
						//	default_chakra_cost = initial(default_chakra_cost *
							L-=spot
							spawn()Poof(user.x,user.y,user.z)
							spawn()Poof(etarget.x,etarget.y,etarget.z)
							user.loc=locate(spot.x,spot.y,spot.z)
							etarget.loc=locate(spot.x,spot.y,spot.z)
							spawn()Poof(spot.x,spot.y,spot.z)
						if(istype(spot,/obj/thunder_god))
							var/obj/thunder_god/T=spot
							T.loc=null
						if(ismob(spot))
							var/mob/M=spot
							M.Timed_Stun(10)
						user.hiraishin-=spot
					else
						default_cooldown = initial(default_cooldown)
						L-=spot
						spawn()Poof(user.x,user.y,user.z)
						user.loc=locate(spot.x,spot.y,spot.z)
						spawn()Poof(spot.x,spot.y,spot.z)
						if(istype(spot,/obj/thunder_god))
							var/obj/thunder_god/T=spot
							T.loc=null
						if(ismob(spot))
							var/mob/M=spot
							M.Timed_Stun(10)
						user.hiraishin-=spot


		hiraishin_kunai
			id = HIRAISHIN_KUNAI
			name = "Hiraishin: Kunai"
			icon_state = "thunder_god_kunai"
			default_chakra_cost = 350
			default_cooldown = 5
			copyable = 0

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.hiraishin.len>=6)
						Error(user, "You have reached your cap on kunais")
						return 0

			Use(mob/user)

				var/obj/thunder_god/O=new/obj/thunder_god(user)
				O.name="Thunder God Kunai"
				O.density=1
				O.icon='thunder_god_kunai.dmi'
				O.dir=user.dir

				//Location
				if(user.dir==NORTH)
					O.loc=locate(user.x,user.y+1,user.z)
				if(user.dir==SOUTH)
					O.loc=locate(user.x,user.y-1,user.z)
				if(user.dir==EAST)
					O.loc=locate(user.x+1,user.y,user.z)
				if(user.dir==WEST)
					O.loc=locate(user.x-1,user.y,user.z)
				if(user.dir==NORTHEAST)
					O.loc=locate(user.x+1,user.y+1,user.z)
				if(user.dir==NORTHWEST)
					O.loc=locate(user.x-1,user.y+1,user.z)
				if(user.dir==SOUTHEAST)
					O.loc=locate(user.x+1,user.y-1,user.z)
				if(user.dir==SOUTHWEST)
					O.loc=locate(user.x-1,user.y-1,user.z)


				var/tiles=15
				var/hit=0
				while(user&&O&&tiles>0&&!hit)
					var/old_loc = O.loc
					for(var/mob/M in O.loc)
						if(M!=user)
							user.hiraishin+=M
							O.loc=null
							O.icon_state="Stuck"
							hit=1
							break
					step(O,O.dir)

					tiles--

					if(O.loc == old_loc)
						tiles = 0
						continue

					CHECK_TICK
				if(user)
					if(!hit)
						O.name="[O.name] ([O.x],[O.y])"

						O.icon_state="Stuck"
						user.hiraishin+=O
				O.density = 0

				var/Hiraishintime=user.ControlDamageMultiplier()
				spawn(1000+(4500*Hiraishintime))
					for(var/obj/thunder_god/H in world)
						if(H)
							del(H)


		flying_thunder_god_ultimate
			id = FLYING_THUNDER_GOD
			name = "Flying Thunder God Technique:Instant Teleportation"
			icon_state = "flyingthunder"
			default_chakra_cost = 150
			default_cooldown = 7
			copyable = 0

			Use(mob/human/user)

				var/mob/human/etarget = user.MainTarget()
				var/obj/teleportation/O = new
				O.loc = (locate(user.x, user.y, user.z))

				var/hiraishin=pick("Tele-1","Tele-2")
				switch(hiraishin)
					if("Tele-1")
						user.AppearBefore(etarget)
						var/obj/teleportation2/P = new
						P.loc = (locate(user.x, user.y, user.z))
					if("Tele-2")
						user.AppearBehind(etarget)
						var/obj/teleportation3/I = new
						I.loc = (locate(user.x, user.y, user.z))


		spacerasengan
			id = RAIKIRI3
			name = "Space-Time: Rasengan"
			icon_state = "thunder_god_2"
			default_chakra_cost = 350
			default_cooldown = 30
		//	default_seal_time = 5



			Use(mob/human/user)
				viewers(user) << output("[user]: Space-Time: Rasengan!", "combat_output")
				user.overlays+='icons/rasengan.dmi'

				var/mob/human/etarget = user.MainTarget()
	//			user.Timed_Stun(10)
				spawn()

				if(etarget)
					user.rasengan=6
					spawn(1)
						user.overlays-='icons/rasengan.dmi'
					CHECK_TICK
					etarget = user.MainTarget()
				//	var/inrange=(etarget in oview(user, 10))
					user.AppearMyDir(etarget)


obj/teleportation
	icon='icons/teleportation.dmi'
	icon_state=""
	density=1
	New()
		src.icon_state="Action"
		spawn(20)
			del(src)

obj/teleportation2
	icon='icons/teleportation2.dmi'
	icon_state=""
	density=1
	New()
		src.icon_state="Action"
		spawn(8)
			del(src)

obj/teleportation3
	icon='icons/teleportation2.dmi'
	icon_state=""
	density=1
	New()
		src.icon_state="Action"
		spawn(8)
			del(src)