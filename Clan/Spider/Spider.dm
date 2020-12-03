skill
	spider
		copyable = 0
		face_nearest = 1


/*		gold_armor
			id = GOLD_ARMOR
			name = "Sticky Gold Armor"
			icon_state = "gold_armor"
			default_chakra_cost = 250
			default_cooldown = 70

			IsUsable(mob/user)
				.=..()
				if(.)
					if(user.goldarmor)
						Error(user, "Sticky Gold Armor is already active.")
						return 0
					if(user.ironskin)
						Error(user, "You cannot stack Iron Skin ")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Sticky Gold Armor!", "combat_output")
				if(user.playergender=="male")
					user.icon='icons/base_m_goldarmor.dmi'
				else
					user.icon='icons/base_m_goldarmor.dmi'

				var/O = rand(500, 1000)
				user.goldarmor = O + (50 * user.ControlDamageMultiplier())*/

		sticking_spit
			id = STICKING_SPIT
			name = "Sticking Spit"
			icon_state = "sticking_spit"
			default_cooldown = 55

			Use(mob/human/user)
				var/obj/sticking_spit/O=new/obj/sticking_spit(user)
				O.density=0
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


				var/tiles=8
				var/hit=0
				while(user&&O&&tiles>0&&!hit)
					for(var/mob/M in O.loc)
						if(M!=user)
							O.loc=null
							hit=1
							spawn()
								M.stunned+=3
								M.overlays+='spider_web_hit.dmi'
							//	new/obj/web_trap(user,M.loc,1)
								while(M&&M.stunned>0)
									M.icon_state="hurt"
									CHECK_TICK
								if(M)
									M.icon_state=""
									M.overlays-='spider_web_hit.dmi'

							break
					step(O,O.dir)
					tiles--
					CHECK_TICK
				if(!hit)
					new/obj/web_trap(user,O.loc,1)
					O.loc=null


		web_cocoon
			id = WEB_COCOON
			name = "Web Cocoon"
			icon_state = "web_cocoon"
			default_chakra_cost = 200
			default_cooldown = 45
			default_seal_time = 5

			Use(mob/human/user)
				user.stunned=3
				viewers(user) << output("[user]: Web Cocoon!", "combat_output")

				for(var/obj/web_trap/o in oview(8))
					if(o.owner==user)
						for(var/mob/human/m in oview(0,o))
							if(m!=user)
								m.stunned+=4
								m.Damage(rand(1000+600*user.ControlDamageMultiplier(),1000+1000*user.ControlDamageMultiplier()),0,user)
								o.loc=null

		generate_supplies
			id = GENERATE_SUPPLIES
			name = "Generate Supplies"
			icon_state = "generate_supplies"
			default_chakra_cost = 250
			default_cooldown = 60
			default_seal_time = 3

			Use(mob/human/user)
				user.stunned=3
				user << output("Your supplies have been regenerated.", "combat_output")
				user.supplies=user.maxsupplies



obj
	sticking_spit
		icon='spider_web.dmi'

	web_trap
		icon='spider_web.dmi'
		icon_state="web"
		New(mob/user,location,jutsu)
			.=..()
			loc=location
			pixel_x=rand(-16,16)
			pixel_y=rand(-16,16)
			owner = user
			if(jutsu)
				spawn()new/obj/web_trap(user,locate(x+1,y+1,z))
				spawn()new/obj/web_trap(user,locate(x-1,y-1,z))
				spawn()new/obj/web_trap(user,locate(x-1,y,z))
				spawn()new/obj/web_trap(user,locate(x+1,y,z))
				spawn()new/obj/web_trap(user,locate(x,y+1,z))
				spawn()new/obj/web_trap(user,locate(x,y-1,z))
				spawn()new/obj/web_trap(user,locate(x-1,y+1,z))
				spawn()new/obj/web_trap(user,locate(x+1,y-1,z))
			spawn(300)
				src.loc=null
		proc/E(mob/human/o)
			if(o==owner) return
			usr=o
			spawn()
				usr.stunned+=5
				usr.overlays+='spider_web_hit.dmi'
				while(usr&&usr.stunned>0)
					usr.icon_state="hurt"
					sleep(1)
				if(usr)
					usr.icon_state=""
					usr.overlays-='spider_web_hit.dmi'
				src.loc=null
			..()
