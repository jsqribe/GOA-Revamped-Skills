skill
	senju
		copyable = 0

		senju_clan
			id = SENJU_CLAN
			icon_state = "doton"
			name = "Senju"
			description = "Senju Clan Jutsu."
			stack = "false"//don't stack
			clan=1
			canbuy=0

/*
		proc
			ShadowImitation(mob/user)
				if(user.HasSkill("shadow_imitation"))
					var/skill/skill = user.GetSkill("shadow_imitation")
					return skill:shadow_imitation

			ShadowImitationMove(mob/user,loc,dir)
				var/nara/shadow_imitation/shadow_imitation = ShadowImitation(user)

				if(!shadow_imitation || !shadow_imitation.caught.len) return

				var
					denied = 0
					list/passed = new

				for(var/mob/enemy in shadow_imitation.caught)
					var/old_loc = enemy.loc

					enemy.Move(get_step(enemy,dir),dir)

					if(enemy.loc == old_loc)
						denied = 1
						break

					passed[enemy] = old_loc

				if(denied)
					for(var/mob/enemy in passed)
						enemy.loc = passed[enemy]

					user.loc = get_step(user,turn(dir,180))

				else if(!denied)

					shadow_imitation.loc = get_step(shadow_imitation,dir)

					for(var/nara/shadow_imitation_trail/trail in shadow_imitation.parts)
						trail.loc = get_step(trail,dir)




		wood_move
			name = "Wood"
			icon = 'mouse_shadow_imitation.dmi'
			id = wood_move
			default_cooldown = 5
			var/nara/shadow_imitation/shadow_imitation

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.MainTarget()
				if(.)
					if(!target || (target && target.ko))
						Error(user, "No Valid Target")
						return 0

			Use(mob/user)
				user.icon_state = "katon"
				user.shadow_use++
				user.Begin_Stun()
				user.dir = dir2cardinal(get_dir_(user,user.target))


				shadow_imitation = new(get_step(user,user.dir))
				shadow_imitation.dir = user.dir

				user.AddOverlays(/nara/shadow_imitation_start)


				var
					tiles = 30
					mob/enemy = user.MainTarget()
					speed = 2

				charge = 1

				shadow_imitation.parts += user

				spawn()

					while(user && tiles > 0 && (enemy && enemy.loc != shadow_imitation.loc) && charge && shadow_imitation)

						var/mob/enemy2 = locate() in shadow_imitation.loc
						if(enemy2 && enemy2 != user && enemy2.shadow_caught)
							enemy = enemy2
							break

						step_towards(shadow_imitation,enemy)

						tiles--

						sleep(speed)

					if(enemy && shadow_imitation)
						if(enemy.loc == shadow_imitation.loc)
							shadow_imitation.caught += enemy

							enemy.shadow_caught++
							enemy.AddOverlays(/nara/shadow_imitation_caught)

							shadow_imitation.icon_state = "caught 2"

					if(user)
						user.End_Stun()
						user.icon_state = ""

					if(shadow_imitation)
						shadow_imitation.animate_movement = SYNC_STEPS

					while(user && shadow_imitation && shadow_imitation.caught.len && charge)
						sleep(1)

					if(user)
						user.shadow_use--
						user.RemoveOverlays(/nara/shadow_imitation_start)

					if(shadow_imitation && shadow_imitation.caught.len)
						for(var/mob/m in shadow_imitation.caught)
							m.shadow_caught--
							m.RemoveOverlays(/nara/shadow_imitation_caught)

					del shadow_imitation
*/


		tree_creation
			id = TREE_CREATION
			name = "Forrest Creation"
			icon_state = "treecreation"
			default_chakra_cost = 50
			default_cooldown = 1

			Use(mob/user)
				if(user.Tree_Creation==1)
					viewers(user) << output("[user] claps his hands!", "combat_output")
					for(var/obj/SenjuuTree/S in world)
						if(S.OwnedBy==user)
							user.TreesOut-=1
							del(S)
					user.TreesOut=0
					user.Tree_Creation=0
				else
					viewers(user) << output("[user] bites his finger as blood slips on the ground he claps his hands!", "combat_output")
					user<<"Click any turf, and trees will begin to form!"
					user.Tree_Creation=1

		tree_attack
			id = TREE_ATTACK
			name = "Forrest Creation: Attack"
			icon_state = "tree_attack"
			default_chakra_cost = 50
			default_cooldown = 1


			Cooldown(mob/user)
				return default_cooldown


			Use(mob/user)
				if(user.Tree_Creation_Attack==1)
					viewers(user) << output("[user] claps his hands!", "combat_output")
					user.Tree_Creation_Attack=0
				else
					viewers(user) << output("[user] bites his finger as blood slips on the ground he claps his hands!", "combat_output")
					user<<"Press A to order the tree log to attack, altho there is a cooldown on how fast you can do it..."
					user.Tree_Creation_Attack=1


turf
	Click()
		if(usr.spectate==1)
			//usr<<"Nice try!, bugged? Spacebar!"
			return
		if(usr.ironsand==1)
		 for(var/mob/human/ironsand/K in world)
		  if(K.owner==usr)
		 //  world.log << "You Clicked [src]"
		   walk_to(K,src,0)

		if(usr.Tree_Creation==1)
		 if(usr.pk==0)
		 	//usr<<"Non PK Zone. Cannot Amaterasu!"
		 	return
		 if(usr.TreesOut>15)
		 	usr<<"Max trees!"
		 	return
		 usr.TreesOut+=1
		 var/A = new/obj/SenjuuTree
		 A:loc = locate( src.x , src.y , src.z )
	//	 world.log << "This [src]"
		 A:OwnedBy=usr

		if(usr.AmaterasuOn==1&&usr.ko==0)
		 if(usr.pk==0)
		 	usr<<"Non PK Zone. Cannot summon a tree!"
		 	return
		 if(usr.AmaterasuClicks<4)
			 var/A = new/obj/Amaterasuu
			 A:loc = locate( src.x , src.y , src.z )
			 A:AOwner=usr
			 usr.AmaterasuClicks+=1

		if(usr.Earth_Wall==1)
		 if(usr.pk==0)
		 	//usr<<"Non PK Zone. Cannot Amaterasu!"
		 	return
		 if(usr.EWalls>10)
		 	usr<<"Max Walls!"
		 	return
		 usr.EWalls+=1
		 var/V = new/obj/EarthWall
		 V:loc = locate( src.x , src.y , src.z )
		 V:dir = usr.dir
		 V:OwnedBy2=usr

nara
	parent_type = /projectiles

	shadow_imitation
		icon = 'kagemane.dmi'
		icon_state = "front"
		layer = MOB_LAYER - 0.1
		var
		//	list/parts = new
			list/caught = new
			obj/path_maker = new

		Move(location,direction)
			var/old_loc = loc

			if(!path_maker.Move(get_step(old_loc,dir)))
				return 0

			dir = dir2cardinals(direction)
			loc = get_step(old_loc,dir)


			flick("kage_mane",src)

			var/nara/shadow_imitation_trail/trail = new(old_loc)


			trail.dir = dir

			trail.dir = TrailDir(parts[parts.len],trail.dir)

			parts += trail

		Del()
			for(var/nara/s in parts)
				del s
			..()

	shadow_imitation_trail
		icon = 'kagemane.dmi'
		icon_state = "mid"
		layer = MOB_LAYER - 0.1
		animate_movement = SYNC_STEPS

	shadow_imitation_start
		icon = 'kagemane.dmi'
		icon_state = "start"
		layer = MOB_LAYER - 0.11
		animate_movement = SYNC_STEPS

	shadow_imitation_caught
		icon = 'kagemane.dmi'
		icon_state = "caught"
		layer = MOB_LAYER - 0.1