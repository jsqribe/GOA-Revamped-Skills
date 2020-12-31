skill
	paper
		copyable = 0

		paper_clan
			id = PAPER_CLAN
			icon_state = "doton"
			name = "Paper"
			description = "Paper Clan Jutsu."
			stack = "false"//don't stack
			clan=1
/*
		Paper_Person_Of_God_Technique
			id = PAPER_GOD
			name = "Paper Person Of God Technique"
			icon_state = "god"
			default_cooldown = 600
			default_chakra_cost = 1500

			Use(mob/human/user)
				user.icon_state="Seal"
				var/obj/paper_bomb/x
				viewers(user) << output("[user]: Paper Person Of God Technique!", "combat_output")
				user.stunned=15
				user.protected=100000
				var/time=rand(50,100)
				spawn()
					for(var/turf/z in view(5,user))
						spawn()var/obj/black/v=new(locate(z.x,z.y,z.z))
						v.owner=user
					while(user.stunned>0&&user.protected&&time>0)
						sleep(2)
						x=new(locate(user.x+(rand(0,5)),user.y+(rand(0,5)),user.z))
						x=new(locate(user.x-(rand(0,5)),user.y-(rand(0,5)),user.z))
						x=new(locate(user.x+(rand(0,5)),user.y-(rand(0,5)),user.z))
						x=new(locate(user.x-(rand(0,5)),user.y+(rand(0,5)),user.z))
						explosion(user:ControlDamageMultiplier()*50,x.x,x.y,x.z,user,0,5)
						time--
						if(user.stunned<=0||!user.protected||time<=0)
							user.protected=0
							time=0
							user.stunned=0
							del(x)
							del(v)
*/
		paper_bomb
			id = PAPER_BOMB
			name = "Paper Bomb"
			icon_state = "paper_bomb"
			default_cooldown = 15
			default_chakra_cost = 200

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.MainTarget()
				if(.)
					if(!target || (target && target.ko))
						Error(user, "No Valid Target")
						return 0
					var/distance = get_dist(user, target)
					if(distance > 10)
						Error(user, "Target too far ([distance]/10 tiles)")
						return 0



			Use(mob/human/user)
				flick("Throw1",user)
				viewers(user) << output("[user]: Paper Bomb!", "combat_output")
				user.combat("If you wish to detonate early, press <b>z</b>.")
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					var/conmult = user.ControlDamageMultiplier()
					var/mob/human/clay/paper_bomb/B=new/mob/human/clay/paper_bomb(locate(user.x,user.y,user.z),rand(500,1000)+(200*conmult),user)
					var/obj/trigger/paper_bomb/T = new(usr, B) //add trigger
					user.AddTrigger(T)
					spawn(3)Homing_Projectile_bang(user,B,8,etarget,0)//1
					spawn(50)
						if(B)
							B.Explode(user)


		paper_shuriken
			id = PAPER_SHURIKEN
			name = "Paper Shuriken"
			icon_state = "paper_shuriken"
			default_chakra_cost = 250
			default_cooldown = 60

			Use(mob/user)
				viewers(user) << output("[user]: Paper Shuriken!", "combat_output")

				for(var/time = 1 to 6)
					var/obj/O = new
				//	user.stunned = 0.1
					O.icon = 'papershuriken.dmi'
					O.layer = MOB_LAYER + 0.1
					O.dir = user.dir
					O.density = 0
					O.pixel_x = rand(-16,16)
					O.pixel_y = rand(-16,16)
					var/list/dirs = new
					if(user.dir == NORTH || user.dir == SOUTH)
						dirs += EAST
						dirs += WEST
						if(user.dir == NORTH)
							dirs += NORTH
						if(user.dir == SOUTH)
							dirs += SOUTH
					if(user.dir == EAST || user.dir == WEST || user.dir == SOUTHEAST || user.dir == SOUTHWEST || user.dir == NORTHEAST || user.dir == NORTHWEST)
						dirs += SOUTH
						dirs += NORTH
						if(user.dir == EAST || user.dir == SOUTHEAST || user.dir == NORTHEAST)
							dirs += EAST
						if(user.dir == WEST || user.dir == SOUTHWEST || user.dir == NORTHWEST)
							dirs += WEST
					O.loc = get_step(user,pick(dirs))
					sleep(0.05)
					spawn()
						var/tiles = 8
						while(user && tiles > 0 && O.loc != null)
							tiles--
							var/old_loc = O.loc
							for(var/mob/m in view(0,O))
								tiles = 0
								m.Damage(500+100*user:ControlDamageMultiplier(),rand(1,5),0,user)
							//	m.Wound(rand(1,5),0,user)
								Blood2(m)
							if(tiles == 0)
								continue
							step(O,O.dir)
							if(O.loc == old_loc)
								tiles = 0
								continue
							sleep(1.25)
						explosion(400+150*user:ControlDamageMultiplier(),O.x,O.y,O.z,user,dist = 3)
						O.loc = null

		paper_chasm
			id = PAPER_CHASM
			name = "Paper Chasm"
			icon_state = "paper_chasm"
			default_chakra_cost = 650
			default_cooldown = 200

			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/player/etarget = user.MainTarget()
					if(!etarget)
						Error(user, "No Target Found")
						return 0


			Use(mob/user)
				viewers(user) << output("[user]: Paper Chasm!", "combat_output")
				user.combat("Press <b>z</b> to detonate the bombs.")

				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					for(var/turf/t in view(1,etarget))
						if(!t.density)
							spawn()
								var/conmult = user.ControlDamageMultiplier()
								var/mob/human/clay/paper_bomb/p=new/mob/human/clay/paper_bomb(locate(t.x,t.y,t.z),rand(500,1000)+(200*conmult),user)
								p.density=0
								p.owner = user
								var/obj/trigger/paper_bomb/T = new(usr, p) //add trigger
								user.AddTrigger(T)

		paper_armor
			id = PAPER_ARMOR
			name = "Paper Armor"
			icon_state = "paper_armor"
			default_chakra_cost = 350
			default_cooldown = 240

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.paper_armor)
						Error(user, "Paper Armor is already active.")
						return 0


			Cooldown(mob/user)
				return default_cooldown

			Use(mob/user)
				viewers(user) << output("[user]: Paper Armor!", "combat_output")

				user.Timed_Stun(5)

				var/obj/o = new
				o.icon = 'paper_armor.dmi'
				o.layer = MOB_LAYER + 0.1
				o.loc = user.loc
				flick("on",o)
				sleep(5)
				o.loc = null

				if(!user)
					return

				user.paper_armor=1

				spawn(Cooldown(user)*10)
					if(!user) return

					user.Timed_Stun(10)
				//	user.protected=5
					user.dir=SOUTH

					user.paper_armor=0

					o.loc = user.loc
					flick("off",o)
					o.density=0

					user.icon_state=""
					sleep(10)
					o.loc = null
					if(!user) return

					//user.stunned=0
				//	user.protected=0


		paper_mode
			id = PAPER_MODE
			name = "Paper Wings"
			icon_state = "sharingan1"
			default_chakra_cost = 950
			default_cooldown = 0//150



		/*	IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.sharingan)
						Error(user, "Sharingan is already active")
						return 0*/


			Cooldown(mob/user)
				return default_cooldown


			Use(mob/user)
				if(user.papermode)
					user.papermode = 0
					user.combat("You deactivate Paper Wings.")
					user.Affirm_Icon()
					ChangeIconState("sharingan1")
				else
					viewers(user) << output("[user]: Paper Wings!", "combat_output")
					user.papermode=1
					user.Affirm_Icon()
					ChangeIconState("sharingan1_cancel")


obj/paper_spear
	icon = 'paper_bomb.dmi'
	icon_state = "1"
	density = 0

client
	Click(object,location,control,params)
		..()

		for(var/obj/paper_bomb/p in location)
			if(p.owner == mob)
				p.Explode(mob)
				return

		for(var/obj/paper_bomb/p in view(1,object))
			if(p.owner == mob)
				p.Explode(mob)
				return
obj
	black
		icon='icons/black.dmi'



//moved paper_bomb to use deidara logic.
obj
	paper_bomb

		icon = 'paper_bomb.dmi'
		icon_state = "1"

		layer = MOB_LAYER + 0.1

		Click(location,control,params)
			if(owner == usr)
				Explode(usr)

		New(location)

			var
				state = "[rand(1,14)]"
				time = 120

			loc = location
			pixel_x = rand(-12,12)
			pixel_y = rand(-12,12)

			icon_state = state

			spawn()
				while(time > 0 && loc != null)
					for(var/mob/m in oview(1,src))
						if(m != owner)
							m.movepenalty = 20
					time--
					sleep(10)
				loc = null

		proc
			Explode(mob/user)
				if(user) user.RemoveTrigger(src)
				if(owner != user || user.ko || user.stunned)
					return

				explosion(150*user:ControlDamageMultiplier(),x,y,z,user,dist = 4)

			//	user.protected+=1
				//spawn(10)user.protected=0

				loc = null
