mob
	proc
		Respawn()
			if(RP || dojo)
				return
			if(!ko || curwound<maxwound)
				return
			//Dipic: clear stuff for death (will be adding more, like targets)
			waterlogged = 0

			var/mob/killer = null
			for(var/mob/M in gameLists["mobile"])
				if(M.client)
					if(M.key == lasthostile)
						killer = M
						break

			if(war && WAR)
				new/mob/corpse(src.loc,src)
				var/obj/Re=0
				for(var/obj/respawn_markers/respawn/R in world)
					if((faction.village=="Konoha" || LeafRecruit==1)&&R.ind==4)
						Re=R
					if((faction.village=="Suna" || SunaRecruit==1) &&R.ind==5)
						Re=R
					if((faction.village=="Kiri" || KiriRecruit==1) &&R.ind==6)
						Re=R
				if(Re)
					src.x = Re.x
					src.y = Re.y
					src.z = Re.z
				else

/*				for(var/obj/TentRespawn in world)
					if(src.faction.village=="Konoha")
						src.loc=locate(/turf/WarSpawn/Leaf)
					else if(src.faction.village=="Kiri")
						src.loc=locate(/turf/WarSpawn/Kiri)
					else if(src.faction.village=="Suna")
						src.loc=locate(/turf/WarSpawn/Suna)
					else*/
					if(src.LeafRecruit || src.faction.village=="Konoha")
						src.loc=locate_tag("war_start_konoha")
					if(src.SunaRecruit || src.faction.village=="Suna")
						src.loc=locate_tag("war_start_suna")
					if(src.KiriRecruit || src.faction.village=="Kiri")
						src.loc=locate_tag("war_start_kiri")
					else
						src.loc=locate_tag("war_start_[lowertext(src.faction.village)]")
				src.curwound=0
				src.curstamina=1500
				src.ko=0
				src.stunned=0
				src.icon_state=""
				src.inevent=0
				//RESPAWN
				killer = null
				for(var/mob/M in gameLists["mobiles"])
					if(M.client)
						if(M.key == lasthostile)
							killer = M
							break
				if(killer&&killer.war)
					killer.Killed(src)
					world<<"<span class='death_info'><span class='name'>[src.realname]</span> has been killed by <span class='name'>[killer.realname]</span>!</span>"
					killer<<"Gained a Faction Point"
					killer.killedd++
					if(killer.LeafRecruit && faction.village=="Konoha")
						Score["Konoha"]-=1
					else
						if(killer.LeafRecruit && faction.village=="Konoha")
							Score["Konoha"]+=1
							if(killer.cond=="Per Kill")
								killer.money+=payz

					if(killer.SunaRecruit && faction.village=="Suna")
						Score["Suna"]-=1
					else
						if(killer.SunaRecruit && !faction.village=="Suna")
							Score["Suna"]+=1
							if(killer.cond=="Per Kill")
								killer.money+=payz

					if(killer.KiriRecruit && faction.village=="Kiri")
						Score["Kiri"]-=1
					else
						if(killer.KiriRecruit && !faction.village=="Kiri")
							Score["Kiri"]+=1
							if(killer.cond=="Per Kill")
								killer.money+=payz
					if(killer.faction.village=="Missing")
						return
					if(killer.faction.village==faction.village)
						Score["[killer.faction.village]"]-=2
					else
						Score["[killer.faction.village]"]+=1
						if(killer.warlord==1 && (!src.warlord || !src.medic_leader))
							Score["[killer.faction.village]"]+=1
						else if(realname==medic_leader)
							Score["[killer.faction.village]"]+=2
						else if(realname==warlord)
							Score["[killer.faction.village]"]+=3
						else if(realname==faction.leader)
							Score["[killer.faction.village]"]+=4
					Show_Score()
					if(Score["[killer.faction.village]"]>=50)
						End_War()
				/*if(realname == faction.leader)
					Score["[faction.village]"]-=2
				Score["[faction.village]"]-=1*/
				//Show_Score()
				return

/*			if(killer)
				if(killer.faction.village!="Missing")
					if(killer.faction.village==faction.village)
						killer.reploss(0.5,"Betrayed the village")
					else
						killer.repgain(0.5,"Killing a player.")*/

			var/obj/mapinfo/Minfo = locate("__mapinfo__[z]")
			/*
			if(Minfo && Minfo.in_war && faction && (faction.village == Minfo.village_control || faction.village == Minfo.attacking_village))
				// TODO: A lot of this needs to be changed with the new map. It's really overly complicated anyway.
				if(faction.village == Minfo.village_control)
					++Minfo.defender_deaths
				else if(faction.village == Minfo.attacking_village)
					++Minfo.attacker_deaths

				var/adjacent[0]
				for(var/x in list(Minfo.oX-1, Minfo.oX+1))
					if(x >= 1 && x <= map_coords.len)
						var/obj/mapinfo/map = map_coords[x][Minfo.oY+1]
						if(map)
							adjacent += map
				for(var/y in list(Minfo.oY, Minfo.oY+2))
					var/list/map_col = map_coords[Minfo.oX]
					if(y >= 1 && y <= map_col.len)
						var/obj/mapinfo/map = map_col[y]
						if(map)
							adjacent += map

				var/controlled_maps[0]
				for(var/obj/mapinfo/map in adjacent)
					if(map.village_control == faction.village)
						controlled_maps += map
				if(controlled_maps.len)
					var/turf/new_loc
					while(!new_loc || !new_loc.Enter(src))
						var/obj/mapinfo/map = pick(controlled_maps)
						if(map.oX < Minfo.oX)
							new_loc = locate(1, rand(1, world.maxy), z)
						else if(map.oX > Minfo.oX)
							new_loc = locate(world.maxx, rand(1, world.maxy), z)
						else if(map.oY < Minfo.oY)
							new_loc = locate(rand(1, world.maxx), world.maxy, z)
						else // map.oX == Minfo.oX && map.oY >= Minfo.oY
							new_loc = locate(rand(1, world.maxx), 1, z)
						sleep(1)
					loc = new_loc
					ko = 0
					curstamina = stamina
					curchakra = chakra
					curwound = 0
					src.Reset_Stun()
					spawn(10) Timed_Stun(10)
					replacement_active = 0

					var/mob/killer = null
					for(var/mob/M in world)
						if(M.client)
							if(M.key == lasthostile)
								killer = M
								break
					if(killer)
						world<<"<span class='death_info'><span class='name'>[realname]</span> has been killed by <span class='name'>[killer.realname]</span>!</span>"
						// TODO: CSS-ify this message.
						killer<<"You gained a Faction Point for killing [src.name]!"
						killer.factionpoints++
						killer.Killed(src)
			*/
			if(war_death) return 0
			if(warring)
				war_death = 1
				src << "You will respawn in 30 seconds"
				sleep(300)
				spawn(100) war_death = 0
			if(warring)
				var/list/spawners
				var/obj/items/war_beacon/wb
				if(warring.attacking_type == "village" && faction.village == warring.attacking_faction)
					warring.attacker_deaths++
					wb = warring.attacker_beacon
					spawners = warring.attackers.Copy()
				else if(warring.attacking_type == "faction" && faction == warring.attacking_faction)
					warring.attacker_deaths++
					wb = warring.attacker_beacon
					spawners = warring.attackers.Copy()
				else if(warring.defending_type == "village" && faction.village == warring.defending_faction)
					warring.defender_deaths++
					wb = warring.defender_beacon
					spawners = warring.defenders.Copy()
				else if(warring.defending_type == "faction" && faction == warring.defending_faction)
					warring.defender_deaths++
					wb = warring.defender_beacon
					spawners = warring.defenders.Copy()

				var/new_loc
				if(wb)
					if(wb.holder)
						new_loc = wb.holder.loc
					else
						new_loc = wb.loc
				else
					if(spawners)
						spawners.Remove(src)
						var/mob/m = pick(spawners)
						new_loc = m.loc
					else
						sleep(10)
						return Respawn()//nothing allowed them to respawn properly, recall respawn

				loc = new_loc
				ko = 0
				curstamina = stamina/2
				curchakra = chakra
				curwound = 50
				icon_state = ""
				src.Reset_Stun()
				spawn(10) Timed_Stun(10)
				replacement_active = 0

				if(killer)
					world<<"<span class='death_info'><span class='name'>[realname]</span> has been killed by <span class='name'>[killer.realname]</span>!</span>"
					// TODO: CSS-ify this message.
					killer<<"You gained a Faction Point for killing [src.name]!"
					killer.killedd++
					killer.Killed(src)
			else if(src.rank!="Academy Student")
				var/mob/corpse/C = new/mob/corpse(loc,src)
				spawn(200) //Dipic: delete the corpse if it's not being held after 20 seconds
					if(C && !C.carriedme)
						C.loc = null
				spawn()src.relieve_bounty()
				// See comment about the stupid say the killer is detected in relieve_bounty.
				var/mob/jerk=0
				for(var/mob/ho in gameLists["mobile"])
					if(ho.client)
						if(ho.key==lasthostile)
							jerk=ho
						//	src << "[jerk] or [ho] and [lasthostile]"
			/*	if(jerk)
					if(jerk.faction.village!="Missing")
						if(jerk.faction.village==src.faction.village)
							jerk.reploss(0.5,"Betrayed the village")
						else
							jerk.repgain(0.5,"Killing a player.")*/

				if(jerk)
					if(C)
						C.killer = jerk
						if(immortality)
							if(C.blevel > sacrifice_level)
								sacrifice_level = C.blevel
							immortality += 60
							src << "You have received an extra minute of immortality for further pleasing Lord Jashin"
							C.loc = null
					jerk.Killed(src) // Does this proc do anything at all anymore? I know the main implementation doesn't, but mabye something has an override somewhere.
					relieve_bounty(jerk)
				if(Minfo)
					Minfo.PlayerLeft(src)
				var/obj/Re
				// Yet more really stupid ways of finding respawn points.
				// TODO: Get a better method of marking respawn points that doesn't need a giant for loop through everything.
				for(var/obj/respawn_markers/respawn/R in gameLists["spawns"])
					if(faction)
						switch(faction.village)
							if("Konoha")
								if(R.ind == 1)
									Re = R
									break
							if("Suna")
								if(R.ind == 2)
									Re = R
									break
							if("Kiri")
								if(R.ind == 3)
									Re = R
									break
							else
								if(R.ind == 0)
									Re = R
									break
					else
						if(R.ind == 0)
							Re = R
							break
				// Yet another pretty much pointless spawn.
				spawn()
					var/foundbed=0
					if(Re)
						var/list/pfrom=new
						for(var/obj/interactable/hospitalbed/o in oview(15,Re))
							pfrom+=o

						if(pfrom.len)
							var/obj/interactable/hospitalbed/F=0
							F=pick(pfrom)
							if(F && istype(F))
								foundbed=1
								loc=F.loc //< At least it's not using locate() here.
								Minfo = locate("__mapinfo__[z]")
								if(Minfo)
									Minfo.PlayerEntered(src)
								icon_state="hurt"
								spawn()F.Interact(src)

					if(!foundbed)
						var/obj/interactable/hospitalbed/o = locate(/obj/interactable/hospitalbed) in world
						if(o)
							loc=o.loc
							Minfo = locate("__mapinfo__[z]")
							if(Minfo)
								Minfo.PlayerEntered(src)
							icon_state="hurt"
							spawn()o.Interact(src)
						else
							curstamina = stamina
							curchakra = chakra
							curwound = 0
							Reset_Stun()
							src << "<b>No respawn point found.</b>"
							return

	/*			if(killer.faction.village!="Missing")
					if(killer.faction.village==faction.village)
						killer.reploss(0.5,"Betrayed the village")
					else
						killer.repgain(0.5,"Killing a player.")*/

				curstamina = 1
				curwound = maxwound - 1
				waterlogged = 0
				Reset_Stun()
				// TODO: CSS-ify this message.
				src<<"You have woken up in a hospital bed, you should rest here until your wounds are gone."
			else
				if(Minfo)
					Minfo.PlayerLeft(src)
				// What is this loc and why is it hardcoded? I think this is the academy student one, so... konoha academy?
				loc=locate(10,91,3)
				Minfo = locate("__mapinfo__[z]")
				if(Minfo)
					Minfo.PlayerEntered(src)
				curwound = 0
				curstamina = stamina

				waterlogged = 0
				// We just reset curstamina, why do it again?
				spawn(10) curstamina = stamina
				spawn(10) Reset_Stun()