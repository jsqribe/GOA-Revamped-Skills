var/pain_skills = list(UNIVERSAL_PUSH, UNIVERSAL_PULL)

skill
	rinnegan
		copyable = 0




		rinnegan
			id = RINNEGAN
			name = "Rinnegan"
			icon_state = "rinnegan"
			default_chakra_cost = 80
			default_cooldown = 500



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.rinnegan)
						Error(user, "Rinnegan is already active")
						return 0


			Cooldown(mob/user)
				return default_cooldown


			Use(mob/user)
				viewers(user) << output("[user]: Rinnegan!", "combat_output")
				user.rinnegan=1
				user.overlays+=image('icons/rinnegan.dmi')
				user.special=1
				user.Affirm_Icon()
				var/buffcon=round(user.con*0.44)
				var/buffrfx=round(user.rfx*0.44)

				user.rfxbuff+=buffrfx
				user.conbuff+=buffcon
				spawn(Cooldown(user)*10)
					if(user)
						user.rinnegan=0
						user.overlays-=image('icons/rinnegan.dmi')
						user.rfxbuff-=round(buffrfx)
						user.conbuff-=round(buffcon)
						user.combat("The rinnegan wore off")
						user.special=0
						user.Load_Overlays()

		Universal_Push
			id = UNIVERSAL_PUSH
			name = "Shinrai Tensai: Universal Push"
			icon_state = "upush"
			default_chakra_cost = 300
			default_cooldown = 60



	/*		IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.rinnegan)
						Error(user, "Rinnegan is Required to use this skill")
						return 0*/


			Use(mob/user)
				viewers(user) << output("[user]: Universal Push!", "combat_output")
				user.overlays+=image('icons/universal_push2.dmi', pixel_x=-16, pixel_y=-16)
				user.overlays+=image('icons/universal_push3.dmi', pixel_x=16, pixel_y=-16)
				user.overlays+=image('icons/universal_push4.dmi', pixel_x=-16, pixel_y=16)
				user.overlays+=image('icons/universal_push5.dmi', pixel_x=16, pixel_y=16)
				user.Affirm_Icon()
				var/damage=100 + charge * 0.1 + round(5*user.ControlDamageMultiplier())
				for(var/mob/human/H in oview(user,16))
					for (var/i=0, i < 9, i++)
						H.Damage(damage,0,user)
						step_away(H,user)
						sleep(2)
					step_away(H,user)

					if(user)
						user.overlays+=image('icons/universal_push2.dmi', pixel_x=-16, pixel_y=-16)
						user.overlays+=image('icons/universal_push3.dmi', pixel_x=16, pixel_y=-16)
						user.overlays+=image('icons/universal_push4.dmi', pixel_x=-16, pixel_y=16)
						user.overlays+=image('icons/universal_push5.dmi', pixel_x=16, pixel_y=16)
						user.Load_Overlays()



		Universal_Pull
			id = UNIVERSAL_PULL
			name = "Shinrai Tensai: Universal Pull"
			icon_state = "upush"
			default_chakra_cost = 300
			default_cooldown = 30

			IsUsable(mob/user)
				.	 = ..()
				if(.)
					if(!user.MainTarget())
						Error(user, "No Target")
						return 0



	/*		IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.rinnegan)
						Error(user, "Rinnegan is Required to use this skill")
						return 0*/


			Use(mob/user)
				viewers(user) << output("[user]: Universal Pull!", "combat_output")
				for(var/mob/human/H in oview(user,16))
					for (var/i=0, i < 9, i++)
						step_towards(H,user)
						sleep(2)
					step_towards(H,user)

		Chibaku_Tensai
			id = CHIBAKU_TENSAI
			name = "Chibaku Tensai"
			icon_state = "chibaku"
			default_chakra_cost = 1000
			default_cooldown = 1200
			var/used_chakra

/*			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.rinnegan)
						Error(user, "Rinnegan must be active!")
						return 0*/

			ChakraCost(mob/user)
				used_chakra = user.curchakra
				if(used_chakra > default_chakra_cost)
					return used_chakra
				else
					return default_chakra_cost

			Use(mob/human/user)
				viewers(user) << output("[user]: Chibaku Tensai!", "combat_output")
				var/obj/Chibaku/O = new
				O.loc = locate(user.x, user.y, user.z)
				O.density = 0
				O.owner = user

				var/Time = 70
				var/mob/human/P

				while(user && O && Time)
					CHECK_TICK

					for(P in view(O))
						spawn()
							if(P != user && !P.ko)
							//	P.client:hellno=1
								step_towards(P,O)

					for(P in O.loc)
						spawn()
							if(P != user && !P.ko)
							//	P.client:hellno=0
								P.density = 0
								P.Tensai=1
								P.Damage(3000, 20)
								//P.Wound(20)
								P.lasthostile = O.owner
								P.Hostile(O.owner)
								P.movepenalty++

					Time -= 0.5 //whatever sleep is u minus time by that oh
					sleep(2)//maybe have to tweak this

				if(O)
					del O
					for(P)
						P.density = 1
						P.Tensai=0

/*	multiple_shadow_clone
		id = PAIN
		name = "Multiple Shadow Clone"
		description = "Creates many controllable clones to distract and hurt your enemies."
		icon_state = "taijuu_kage_bunshin"
		default_chakra_cost = 500
		default_cooldown = 60
	//	var/used_chakra



		ChakraCost(mob/user)
			used_chakra = user.curchakra * 3 / 4
			if(used_chakra > default_chakra_cost)
				return used_chakra
			else
				return default_chakra_cost


		Use(mob/user)
			for(var/mob/human/player/npc/kage_bunshin/O in world)
				if(O.ownerkey==user.key)
					if(user.client && user.client.eye == O)
						user.client.eye = user
					O.loc = null

			flick("Seal",user)

			viewers(user) << output("[user]: Multiple Shadow Clone!", "combat_output")
			user.combat("<b>Click</b> to move your bunshins. Press <b>F</b> to have them attack your target(s).")
			user.tajuu=1
			user.RecalculateStats()
			var/list/options=new
			for(var/turf/x in oview(4,user))
				if(!x.density)
					options+=x
			var/list/B = new
			var/am=0


			while(used_chakra>default_chakra_cost && am<=20 && options.len)
				used_chakra-=default_chakra_cost
				var/turf/next=pick(options)
				spawn()Poof(next.x,next.y,next.z)
				B+=new/mob/human/player/npc/kage_bunshin(locate(next.x,next.y,next.z))
				am++
			var/ico
			var/list/over
			if(user.hiddenmist) //Dipic: Terrible work around is terrible
				user.hiddenmist=0
				user.Affirm_Icon()
				user.Load_Overlays()
				ico = user.icon
				over = user.overlays.Copy()
				user.HideInMist()
			else
				ico = user.icon
				over = user.overlays.Copy()


			for(var/mob/human/player/npc/kage_bunshin/O in B)
				O.Squad=B
				for(var/skill/s in pain_skills)
					if(!(s.id in no_bunshin_skills))
						O.AddSkill(s.id, skillcard=0, add_unknown=0)
				O.skillspassive[4] = user.skillspassive[4]
				spawn(2)
					O.icon=ico
					O.faction=user.faction
					O.mouse_over_pointer=user.mouse_over_pointer
					O.temp=1200
					O.overlays+=over
					O.rinnegan=1
					O.name=user.name
					O.con=user.con
					O.str=user.str
					O.rfx=user.rfx
					O.int=user.int
					O.blevel=user.blevel
					O.stamina=O.blevel*55 + O.str*20
					O.chakra=190 + O.blevel*10 + O.con*2.5
					O.curstamina=O.stamina
					O.curchakra=O.chakra
					O.staminaregen=round(O.stamina/100)
					O.chakraregen=round((O.chakra*3)/100)
					O.CreateName(255, 255, 255)
					spawn()O.AIinitialize()

				O.owner=user
				O.ownerkey=user.key

				O.killable=1

				user.pet=1

			user.BunshinTrick(B)

			spawn(600)
				for(var/mob/human/player/npc/kage_bunshin/U in B)
					if(U)
						var/turf/u_loc = U.loc
						spawn() if(u_loc) Poof(u_loc.x,u_loc.y,u_loc.z)
						U.loc = null
				if(user)
					user.tajuu=0
					user.RecalculateStats()*/
mob/var/Tensai=0

obj
	Chibaku
		icon='Chibaku1.dmi'
		layer=MOB_LAYER+2
		density=0
		New()
			..()
			spawn(120)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="mid")
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="north",pixel_y=32)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="south",pixel_y=-32)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="east",pixel_x=32)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="west",pixel_x=-32)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="northeast",pixel_x=32,pixel_y=32)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="northwest",pixel_x=-32,pixel_y=32)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="southeast",pixel_x=32,pixel_y=-32)
				src.overlays+=image('icons/Chibaku2.dmi',icon_state="southwest",pixel_x=-32,pixel_y=-32)
			spawn(220)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="mid")
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="north",pixel_y=32)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="south",pixel_y=-32)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="east",pixel_x=32)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="west",pixel_x=-32)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="northeast",pixel_x=32,pixel_y=32)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="northwest",pixel_x=-32,pixel_y=32)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="southeast",pixel_x=32,pixel_y=-32)
				src.overlays+=image('icons/Chibaku3.dmi',icon_state="southwest",pixel_x=-32,pixel_y=-32)