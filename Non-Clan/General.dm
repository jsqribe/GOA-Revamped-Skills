var/no_bunshin_skills = list(BUNSHIN, KAGE_BUNSHIN, TAJUU_KAGE_BUNSHIN, HENGE, EXPLODING_KAGE_BUNSHIN,
                             GATE1, GATE2, GATE3, GATE4, GATE5, GATE6, MORNING_PEACOCK, MEDIC, POISON_MIST, POISON_NEEDLES, MASOCHISM,
                             IMMORTALITY, BLOOD_BIND, PUPPET_SUMMON1, PUPPET_SUMMON2, MEAT_TANK, DOTON_IRON_SKIN, KAWARIMI, EXPLODING_KAWARIMI,
                             SAND_SUMMON, SAND_UNSUMMON, SAND_SHIELD, DESERT_FUNERAL, SAND_ARMOR, SAND_SHURIKEN, SHUNSHIN, DOTON_MOLE_HIDING, DOTON_HEAD_HUNTER,
                             PUPPET_HENGE, PUPPET_SWAP, EXPLODING_KUNAI, EXPLODING_NOTE, DOTON_CHAMBER_CRUSH, CHIDORI_NEEDLES,
                             CHIDORI_CURRENT, FUUTON_GREAT_BREAKTHROUGH, FUUTON_PRESSURE_DAMAGE, FUUTON_AIR_BULLET, MANIPULATE_ADVANCING_BLADES,
                             KAITEN, SHADOW_IMITATION, SHADOW_NECK_BIND, ICE_SPIKE_EXPLOSION, SAWARIBI, BONE_HARDEN, WOUND_REGENERATION,
                             EXPLODING_SPIDER, EXPLODING_BIRD, C3, PHOENIX_REBIRTH, DOTON_CHAMBER, KATON_PHOENIX_FIRE, KATON_FIREBALL, KATON_ASH_BURNING, KATON_PHOENIX_NAIL_FLOWER,
                             SUITON_SYRUP_CAPTURE, SUITON_WATER_PRISON, SUITON_HIDDEN_MIST, SUITON_WATER_BULLET,FUUTON_VACUUM_BLADE_RUSH, DOTON_MOLE_HIDING, DOTON_HEAD_HUNTER,
                             FALSE_DARKNESS, FOUR_PILLAR_BIND, CHAKRA_ENHANCEMENT, WATER_CLONE, VACUUM_SPHERE, DOTON_EARTH_SHAKING_PALM, DOTON_PRISON_DOME, DOTON_EARTH_DRAGON,
                             DOTON_RESURRECTION_TECHNIQUE, KIRIN, FRONT_LOTUS, C4, C0, EXPLODING_BARRAGE, EXPLODING_OWL, SHUKAKU, NIBI, SANBI, YONBI, GOBI, ROKUBI, SHICHIBI,
                             HACHIBI, KYUUBI, DRAGON_BULLET, BOIL_RELEASE_SKILLED_MIST_TECHNIQUE, LAVA_RELEASE_QUICKLIME, CUBICAL_VARIANT, LARIAT, HORIZONTAL_OPPRESSION,
                             PAPER_SHURIKEN, PAPER_CHASM, MIND_TRANSFER, MIND_TAG, MIND_DISTURBANCE, FLOWER_BOMB, PETAL_DANCE, PETAL_ESCAPE, SHIKI_FUJIN, UNIVERSAL_PUSH, UNIVERSAL_PULL,
                             NEEDLE_UMBRELA, SUITON_COLLISION_DESTRUCTION, SUITON_SHOCKWAVE, TWIN_RISING_DRAGONS, DOTON_IRON_SKIN, HIRAISHIN_1, HIRAISHIN_2, HIRAISHIN_KUNAI,
                             SLY_MIND, CROW , TREE_BIND, INSTANT_SLASH, IAI_BEHEADING, DANCING_BLADE)

skill
	body_replacement
		id = KAWARIMI
		name = "Body Replacement"
		description = "Prepares you for a quick escape."
		icon_state = "kawarimi"
		default_chakra_cost = 50
		default_cooldown = 60



		Use(mob/user)
			user.combat("Body Replacement is now active. If you are hit during the next <b>10 seconds</b>, you will be teleported back to the location the skill was activated on.")
			user.replacement_active = 1
			user.replacement_loc = user.loc
			var/obj/trigger/kawa_icon/T = new/obj/trigger/kawa_icon
			T.user=user
			user.AddTrigger(T)
			spawn()
				for(var/skill/sk in user.skills)
					if(sk.id == EXPLODING_KAWARIMI)
						sk.DoCooldown(user,resume=1,passthrough=1)
						break
			spawn(100)
				if(user)
					user.replacement_active = 0
					if(T) user.RemoveTrigger(T)

	exploding_body_replacement
		id = EXPLODING_KAWARIMI
		name = "Exploding Body Replacement"
		description = "Prepares you for a quick escape, leaving an explosive tag behind."
		icon_state = "exploding_kawarimi"
		default_chakra_cost = 50
		default_supply_cost = 15
		default_cooldown = 120
		stamina_damage_fixed = list(2000, 2000)
		stamina_damage_con = list(0, 0)


		DoCooldown(mob/user, resume = 0, passthrough = 0)
			var/alreadycoolingdown //used to reset the cooldown while the skill is cooling down
			if(cooldown) alreadycoolingdown = 1

			if(passthrough)
				cooldown = default_cooldown/2
			if(alreadycoolingdown) return
			..()

		Use(mob/user)
			user.combat("Exploding Body Replacement is now active. If you are hit during the next <b>10 seconds</b>, you will be teleported back to the location the skill was activated on.")
			user.replacement_active = 1
			user.exploding_log = 1
			user.replacement_loc = user.loc
			var/obj/trigger/kawa_icon/T = new/obj/trigger/kawa_icon
			T.user=user
			user.AddTrigger(T)
			spawn()
				for(var/skill/sk in user.skills)
					if(sk.id == KAWARIMI)
						sk.DoCooldown(user,resume=1,passthrough=1)
						break
			spawn(100)
				if(user)
					user.replacement_active = 0
					user.exploding_log = 0
					if(T) user.RemoveTrigger(T)


	body_flicker
		id = SHUNSHIN
		name = "Body Flicker"
		description = "Moves you at a high speed."
		icon_state = "shunshin"
		default_chakra_cost = 35
		default_stamina_cost = 70
		default_cooldown = 5

		IsUsable(mob/human/user)
			if(..())

				if(user.cantshun)
					Error(user, "Cant shunshin while your inside swamp.")
					return 0

				if(Issmoke(user.loc))
					return 0
				else
					return 1

		/*ChakraCost(mob/human/player/user) //Dipic: Pretty sure this was here because body flicker had no cost. It should no longer be needed.
			if(user.gate || user.chakrablocked)
				return 1
			return default_chakra_cost*/

		ChakraCost(mob/user)
			if(user.clan == "Youth") return 0
			else return default_chakra_cost
		StaminaCost(mob/user)
			if(user.clan == "Youth") return default_stamina_cost
			else return 0

		Use(mob/human/user)
			var/mob/human/player/etarget = user.MainTarget()

			if(user.UsrOnSwamp==1)
				return

			if(!user.icon_state)
				flick(user, "Seal")

			sleep(1)
			if(!user) return

			if(!etarget)
				user.combat("<b>Double-click</b> on an empty section of ground within 5 seconds to teleport there.")
				user.shun = 1
				spawn(50)
					if(user) user.shun = 0
			else
				if(etarget && etarget.z == user.z)
					var/did_teleport
					if(user.client)
						var/sdir = user.dir_from_keys()
						if(sdir)
							var/turf/sturf = get_step(etarget,sdir)
							if(!sturf || sturf.density)
								return
							user.client.cancel_movement_loop=1//stop move
							user.AppearAt(sturf.x,sturf.y,sturf.z)
							user.FaceTowards(etarget)
							did_teleport = 1
							user.shuned = 1
							spawn(20)
								user.shuned = 0
					if(!did_teleport)
						if(user.skillspassive[4])
							user.AppearBehind(etarget)
							user.shuned = 1
							spawn(20)
								user.shuned = 0
						else
							user.AppearBefore(etarget)
							user.shuned = 1
							spawn(20)
								user.shuned = 0

					spawn()
						user.Timed_Stun(25.5 - (5 * user.skillspassive[4]))
						user.client.cancel_movement_loop=0//allow move


		Cooldown(mob/user)
			if(user.skillspassive[4] == 5)
				return 0
			else
				return ..(user)




	clone
		id = BUNSHIN
		name = "Clone"
		description = "Creates a clone to distract your enemies."
		icon_state = "bunshin"
		default_chakra_cost = 10
		default_cooldown = 30



		Use(mob/user)
			if(!user.icon_state)
				flick(user,"Seal")

			var/ico
			var/list/over
			if(user.hiddenmist) //Dipic: Terrible work around is terrible
				user.hiddenmist=0
				user.Affirm_Icon()
				user.Load_Overlays()
				ico = user.icon
				over = user.overlays.Copy()
				usr.hiddenmist=1//make it more terrible y not
				user.HideInMist()

			else
				ico = user.icon
				over = user.overlays.Copy()

			var/mob/human/player/npc/bunshin/o = new/mob/human/player/npc/bunshin(locate(user.x,user.y,user.z))
			spawn(2)
				o.icon = ico
				o.overlays = over
				o.name = "[user.name]"
				o.bunshinowner = user.key
				o.faction = user.faction
				o.dir = user.dir
				o.mouse_over_pointer = user.mouse_over_pointer
				o.life = 30
				o.CreateName(255, 255, 255)

			Poof(o.x,o.y,o.z)

			user.BunshinTrick(list(o))




	shadow_clone
		id = KAGE_BUNSHIN
		name = "Shadow Clone"
		description = "Creates a controllable clone to distract your enemies."
		icon_state = "kagebunshin"
		default_chakra_cost = 150
		default_cooldown = 60



		Use(mob/user)
			for(var/mob/human/player/npc/kage_bunshin/O in world)
				if(O.ownerkey==user.key)
					O.loc = null
			flick("Seal",user)

			viewers(user) << output("[user]: Shadow Clone!", "combat_output")
			var/ico
			var/list/over
			if(user.hiddenmist) //Dipic: Terrible work around is terrible
				user.hiddenmist=0
				user.Affirm_Icon()
				user.Load_Overlays()
				ico = user.icon
				over = user.overlays.Copy()
				user.hiddenmist=1
				user.HideInMist()
				user.Affirm_Icon()
				user.Load_Overlays()
			else
				ico = user.icon
				over = user.overlays.Copy()
			var/mob/human/player/npc/kage_bunshin/X = new/mob/human/player/npc/kage_bunshin(locate(user.x,user.y,user.z))
			user.client.eye=X
			X.ownerkey=user.key
			user.controlmob=X
			spawn(2)
				X.icon=ico
				X.overlays=over
				X.underlays=user.underlays
				X.faction=user.faction
				X.mouse_over_pointer=user.mouse_over_pointer
				X.con=user.con
				X.str=user.str
				X.rfx=user.rfx
				X.int=user.int

				X.name="[user.name]"
				X.CreateName(255, 255, 255)

			//spawn() X.regeneration2()

			if(user) user.BunshinTrick(list(X))




	multiple_shadow_clone
		id = TAJUU_KAGE_BUNSHIN
		name = "Multiple Shadow Clone"
		description = "Creates many controllable clones to distract and hurt your enemies."
		icon_state = "taijuu_kage_bunshin"
		default_chakra_cost = 300
		default_cooldown = 60
		var/used_chakra



		ChakraCost(mob/user)
	/*		if(user.naturechakra >= 0)
				used_chakra = user.naturechakra * 3 / 4
				if(used_chakra > default_chakra_cost)
					return used_chakra*/
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
				user.hiddenmist=1
				user.HideInMist()
			else
				ico = user.icon
				over = user.overlays.Copy()


			for(var/mob/human/player/npc/kage_bunshin/O in B)
				O.Squad=B
				for(var/skill/s in user.skills)
					if(!(s.id in no_bunshin_skills))
						O.AddSkill(s.id, skillcard=0, add_unknown=0)
				O.skillspassive[4] = user.skillspassive[4]
				spawn(2)
					O.icon=ico
					O.faction=user.faction
					O.mouse_over_pointer=user.mouse_over_pointer
					O.temp=1200
					O.overlays+=over
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
					user.RecalculateStats()




	exploding_shadow_clone
		id = EXPLODING_KAGE_BUNSHIN
		name = "Exploding Shadow Clone"
		description = "Creates a controllable clones that explodes when hurt!"
		icon_state = "exploading bunshin"
		default_chakra_cost = 400
		default_cooldown = 45
		stamina_damage_fixed = list(1000, 2500)
		stamina_damage_con = list(0, 0)


		Use(mob/user)
			viewers(user) << output("[user]: Shadow Clone!", "combat_output")
			for(var/mob/human/player/npc/kage_bunshin/O in world)
				if(O.ownerkey==user.key)
					O.loc = null
			flick("Seal",user)
			var/mob/human/player/npc/kage_bunshin/X = new/mob/human/player/npc/kage_bunshin(user.loc)
			if(user.client) user.client.eye=X
			var/ico
			var/list/over
			if(user.hiddenmist) //Dipic: Terrible work around is terrible
				user.hiddenmist=0
				user.Affirm_Icon()
				user.Load_Overlays()
				ico = user.icon
				over = user.overlays.Copy()
				user.hiddenmist=1
				user.HideInMist()
			else
				ico = user.icon
				over = user.overlays.Copy()

			X.ownerkey=user.key
			user.controlmob=X
			spawn(2)
				X.icon=ico
				X.overlays=over
				X.underlays=user.underlays
				X.con=user.con
				X.str=user.str
				X.rfx=user.rfx
				X.int=user.int
				X.exploading=1
				X.faction = user.faction
				X.name="[user.name]"
				X.CreateName(255, 255, 255)
			//spawn() X.regeneration2()

			user.BunshinTrick(list(X))




	transform
		id = HENGE
		name = "Transform"
		description = "Changes your appearance to that of someone else."
		icon_state = "henge"
		default_chakra_cost = 40
		default_cooldown = 60



		IsUsable(mob/user)
			. = ..()
			if(.)
				if(!user.MainTarget())
					Error(user, "No Target")
					return 0


		Use(mob/human/player/user)

			if(!user.icon_state)
				flick(user,"Seal")

			viewers(user) << output("[user]: Transform!", "combat_output")
			var/mob/human/player/etarget = user.MainTarget()

			if(etarget && !istype(etarget, /mob/human/clay) && !istype(etarget, /mob/human/sandmonster))
				Poof(user.x, user.y, user.z)

				user.icon = etarget.icon
				user.name = etarget.name


				user.overlays= etarget.overlays
				user.mouse_over_pointer = etarget.mouse_over_pointer
				user.henged = 1

				if(!istype(etarget, /mob/human/npc) && etarget.faction)
					user.transform_chat_icon = etarget.faction.chat_icon
				else
					user.transform_chat_icon = null

				user.CreateName(255, 255, 255)




	rasengan
		id = RASENGAN
		name = "Rasengan"
		description = "Creates a small ball of highly concentrated chakra that rapidly expands when punched into an enemy."
		icon_state = "rasengan"
		default_chakra_cost = 300
		default_cooldown = 90
		stamina_damage_fixed = list(750, 750)
		stamina_damage_con = list(750, 750)



		Use(mob/human/player/user)
			viewers(user) << output("[user]: Rasengan!", "combat_output")
			user.Timed_Stun(10)
			var/obj/x = new(locate(user.x,user.y,user.z))
			x.layer=MOB_LAYER+1
			x.icon='icons/rasengan.dmi'
			x.dir=user.dir
			flick("create",x)
			user.overlays+=/obj/rasengan
			spawn(30)
				x.loc = null
			sleep(10)
			if(user && !user.ko)
				user.rasengan=1
				user.combat("Press <b>A</b> to use Rasengan on someone. If you take damage it will dissipate!")
				user.on_hit.add(src, "Cancel")



		proc
			Cancel(mob/human/player/user, mob/human/player/attacker, event/event)
				event.remove(src, "Cancel")
				if(user && user.rasengan == 1)
					user.Rasengan_Fail()




	oodama_rasengan
		id = OODAMA_RASENGAN
		name = "Large Rasengan"
		description = "Creates a ball of highly concentrated chakra that rapidly expands when punched into an enemy."
		icon_state = "oodama_rasengan"
		default_chakra_cost = 500
		default_cooldown = 140
		stamina_damage_fixed = list(1125, 1125)
		stamina_damage_con = list(1125, 1125)
		wound_damage_fixed = list(15, 20)
		wound_damage_con = list(0, 0)



		Use(mob/human/player/user)
			viewers(user) << output("[user]: Large Rasengan!", "combat_output")
			user.Timed_Stun(30)
			var/obj/x = new(locate(user.x,user.y,user.z))
			x.layer=MOB_LAYER-1
			x.icon='icons/oodamarasengan.dmi'
			x.dir=user.dir
			flick("create",x)
			user.overlays+=/obj/oodamarasengan
			spawn(30)
				x.loc = null
			sleep(30)
			if(user && !user.ko)
				user.rasengan=2
				user.combat("Press <b>A</b> before the Oodama Rasengan dissapates to use it on someone. If you take damage it will dissipate!")
				user.on_hit.add(src, "Cancel")
				// This is a nice candidate for a task system
				// Make it get removed when the rasengan is used/failed
				spawn(100)
					if(user && user.rasengan == 2)
						user.on_hit.remove(src, "Cancel")
						user.ORasengan_Fail()



		proc
			Cancel(mob/human/player/user, mob/human/player/attacker, event/event)
				event.remove(src, "Cancel")
				if(user && user.rasengan == 2)
					user.ORasengan_Fail()




	camouflaged_hiding
		id = CAMOFLAGE_CONCEALMENT
		name = "Camouflaged Hiding"
		description = "Blends you into your surroundings, making it harder for your enemies to see you."
		icon_state = "Camouflage Concealment Technique"
		default_chakra_cost = 100
		default_cooldown = 60
		default_seal_time = 5



		Use(mob/human/player/user)
			user.camo=1
			user.icon='icons/base_invisible.dmi'
			user.overlays=0
			Poof(user.x,user.y,user.z)




	chakra_leech
		id = CHAKRA_LEECH
		name = "Chakra Leech"
		description = "Drains your enemies of chakra, repleshing your chakra."
		icon_state = "chakra_leach"
		default_chakra_cost = 100
		default_cooldown = 60

		IsUsable(mob/user)
			. = ..()
			var/mob/human/target = user.NearestTarget()
			if(. && target)
				var/distance = get_dist(user, target)
				if(distance > 3)
					Error(user, "Target too far ([distance]/3 tiles)")
					return 0

		Use(mob/human/player/user)

			viewers(user) << output("[user]: Chakra Leech!", "combat_output")

			user.icon_state="Throw2"
			user.overlays+='icons/leech.dmi'

			var/mob/human/player/etarget = user.NearestTarget()

			var/dmg_mult = 1
			if(etarget)
				var/dist = get_dist(user, etarget)
				if(dist == 2)
					dmg_mult = 0.5
				else if(dist != 1)
					etarget = null
			else
				for(var/mob/human/X in get_step(user,user.dir))
					if(!X.ko && !X.IsProtected())
						etarget=X

			var/mob/gotcha=0
			var/turf/getloc=0
			if(etarget)
				gotcha=etarget.Replacement_Start(user)
				gotcha.overlays+='icons/leech.dmi'
				user.Timed_Stun(5)
				gotcha.Begin_Stun()
				if(gotcha != etarget)
					gotcha.End_Stun()
					spawn() user.Timed_Stun(20)
					sleep(20)
					gotcha.overlays-='icons/leech.dmi'
					user.overlays-='icons/leech.dmi'
					user.icon_state=""
					spawn(5) if(gotcha) gotcha.Replacement_End()
					return
				getloc=locate(etarget.x,etarget.y,etarget.z)

				sleep(5)
				user.Timed_Stun(5)

				var/max = 0
				var/turf/q=user.loc
				while(user && !user.ko && gotcha && !gotcha.ko && gotcha.loc==getloc && (abs(user.x-gotcha.x)*abs(user.y-gotcha.y))<=1 && user.x==q.x && user.y==q.y)
					var/conmult = user.ControlDamageMultiplier()
					gotcha.curchakra-= round(20*conmult*dmg_mult)
					user.curchakra+=round(20*conmult*dmg_mult)
					gotcha.Hostile(user)

					max += round(20*conmult*dmg_mult)

					if(max > 400 && gotcha)
						gotcha.End_Stun()

					if(gotcha.curchakra<0)
						gotcha.overlays-='icons/leech.dmi'
						gotcha.curstamina=0
						spawn() gotcha.KO()
						gotcha=0

					if(user.curchakra>user.chakra*1.5) user.curchakra=user.chakra*1.5
					sleep(5)
				user.overlays-='icons/leech.dmi'
				if(gotcha) gotcha.overlays-='icons/leech.dmi'
				user.icon_state=""




client
	DblClick(atom/thing, atom/loc, control, params)
		if(!mob.stunned && mob.pk && mob.shun && isloc(loc))
			if(!loc || !loc.Enter(usr) || !loc.icon || loc.type == /turf || !(loc in oview(mob)) || Issmoke(mob.loc))
				return

			if(!mob.loc.icon || mob.loc.type==/turf || mob.loc.density)
				return

			mob.shun = 0

			spawn() mob.Timed_Stun(30 - (5 * mob.skillspassive[4]))
			mob:AppearAt(loc.x, loc.y, loc.z)
		else
			..()



mob/human/player/npc/replacement_log
	Damage()
		return

	Dec_Stam()
		return

	Wound()
		return

	Hostile()
		return

	KO()
		return

	Replacement_Start()
		return src

	Replacement_End(state="kawa")
		Poof(x, y, z)
		if(src.exploding_log)
			icon = 'icons/exploding_log.dmi'
		else
			icon = 'icons/log.dmi'
		icon_state = state
		overlays = null
		underlays = null
		if(src.exploding_log)
			spawn(10)
				Poof(x, y, z)
				explosion(1500, x, y, z, src)
				del(src)
				spawn(20)
					loc = null
		else
			spawn(20)
				//loc = null
				del(src)//temporary fix for whispers/kage verbs as I cannot figure out what keeps the replacements around

mob/human/player/npc
	bunshin
		auto_ai = 0
		initialized=1
		protected=0
		ko=0



		var
			bunshinowner=1
			bunshintype=0
			life=60



		New()
			..()
			spawn()
				while(src.life>0)
					sleep(10)
					src.life--

				if(src.invisibility<=2)
					Poof(src.x,src.y,src.z)
				src.invisibility=4
				src.targetable=0
				src.density=0
				spawn(50)
					loc = null


		Dec_Stam()
			return


		Wound()
			return


		Hostile(mob/human/player/attacker)
			. = ..()
			if(bunshintype == 0)
				spawn() Poof(x, y, z)
				invisibility = 100
				loc = null
				targetable = 0
				density = 0
				// Didn't this just happen two lines above? Not even a sleep to give other stuff a chance to mess it up.
				targetable = 0
				loc = null
				//spawn(500)
				//	del(src)




	kage_bunshin
		auto_ai = 0
		initialized=1
		protected=0
		ko=0



		var
			ownerkey=""
			owner=""
			temp=0
			exploading=0
			attack_cd



		New()
			..()
			spawn(10)
				if(temp)
					spawn(temp)
						src.Hostile()


		Dec_Stam()
			return


		Wound()
			return


		Hostile(mob/human/player/attacker)
			spawn()
				var/dx = x
				var/dy = y
				var/dz = z
				if(!exploading)
					spawn() Poof(dx,dy,dz)
				else
					exploading = 0
					var/mob/owner = src
					for(var/mob/human/player/p in gameLists["mobiles"])
						if(p.key == ownerkey)
							owner = p
							break
					spawn() explosion(rand(1000, 2500), dx, dy, dz, owner)
					icon = 0
					targetable = 0
					invisibility = 100
					density = 0
					sleep(30)
				FilterTargets()
				for(var/mob/T in targets)
					RemoveTarget(T)
				dead = 1
				stunned = 100

				loc = locate(0, 0, 0)
				for(var/mob/human/player/p in gameLists["mobiles"])
					if(p.key == ownerkey)
						p.controlmob = 0
						if(p && p.client && p.client.mob)
							p.client.eye = p.client.mob
						break
				invisibility = 100
				targetable = 0
				density = 0
				targetable = 0
				spawn(100)
					loc = null
			return ..()


obj
	oodamarasengan
		icon='icons/oodamarasengan.dmi'
		icon_state="rasengan"
		layer=MOB_LAYER+1
	oodamarasengan2
		icon='icons/oodamarasengan.dmi'
		icon_state="PunchA-1"
		layer=MOB_LAYER+1
obj
	rasengan
		icon='icons/rasengan.dmi'
		icon_state="rasengan"
		layer=MOB_LAYER+1
	rasengan2
		icon='icons/rasengan.dmi'
		icon_state="PunchA-1"
		layer=MOB_LAYER+1


mob/var/tmp/exploding_log = 0
mob/human/
	Replacement_Start(mob/user)
		if(replacement_active)
			replacement_active = 0

			var/mob/human/player/npc/replace_log = new /mob/human/player/npc/replacement_log(loc)
			spawn() replace_log.CreateName(255, 255, 255)

			if(user)

				var/ico = user.icon
				var/list/over = user.overlays.Copy()

				replace_log.name = user.name
				replace_log.faction = user.faction
				replace_log.icon = ico
				replace_log.icon_state = user.icon_state
				replace_log.overlays = over
				replace_log.exploding_log = user.exploding_log

				usemove = 0

				spawn() user.FilterTargets()
				var/active = 0
				for(var/i in 1 to user.active_targets.len)
					if(user.active_targets[i] == src)
						user.active_targets[i] = replace_log
						active = 1
						user << replace_log.name_img
						user << replace_log.active_target_img
				for(var/i in 1 to user.targets.len)
					if(user.targets[i] == src)
						user.targets[i] = replace_log
						if(!active)
							user << replace_log.name_img
							user << replace_log.target_img


				if(user in targeted_by)
					targeted_by -= user

					if(user.client)
						user.client.images -= active_target_img
						user.client.images -= target_img
						user.client.images -= name_img

					spawn() user.AddTarget(src, active=0, silent=1)

			loc = replacement_loc
			Reset_Stun()
			for(var/obj/trigger/kawa_icon/T in triggers)
				if(T) RemoveTrigger(T)
			return replace_log
		else
			return src
mob/proc
	Replacement_Start(mob/user)
		return

	Replacement_End(state="kawa")
		return

	ORasengan_Fail()
		src.rasengan=0
		src.overlays-=/obj/oodamarasengan
		src.overlays-=/obj/oodamarasengan2
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER-1
		o.icon='icons/oodamarasengan.dmi'
		flick("failed",o)
		spawn(50)
			o.loc = null
	ORasengan_Hit(mob/x,mob/human/u,xdir)
		x = x.Replacement_Start(u)
		u.overlays-=/obj/oodamarasengan
		u.overlays-=/obj/oodamarasengan2
		u.rasengan=0
		var/conmult= u.ControlDamageMultiplier()
		x.cantreact=1
		spawn(30)
			x.cantreact=0
		var/obj/o=new/obj/oodamaexplosion(locate(x.x,x.y,x.z))
		o.layer=MOB_LAYER-1
		if(!x.icon_state)
			x.icon_state="hurt"
		x.Timed_Stun(20)
		u.Timed_Stun(20)
		x.Damage(1125+1125*conmult, rand(15,20), u, "Oodama Rasengan", "Normal")
		x.Earthquake(20)
		sleep(20)
		o.loc = null
		x.Knockback(10,xdir)
		explosion(50,x.x,x.y,x.z,u,1)
		if(x)
			x.Timed_Stun(30)
			if(!x.ko) x.icon_state=""
			x.Hostile(u)
		spawn(5) if(x) x.Replacement_End()
	Rasengan_Fail()
		src.rasengan=0
		src.overlays-=/obj/rasengan
		src.overlays-=/obj/rasengan2
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER+1
		o.icon='icons/rasengan.dmi'
		flick("failed",o)
		spawn(50)
			o.loc = null
	Rasengan_Hit(mob/x,mob/human/u,xdir)
		x = x.Replacement_Start(u)
		u.overlays-=/obj/rasengan
		u.overlays-=/obj/rasengan2
		u.rasengan=0
		var/conmult= u.ControlDamageMultiplier()
		x.cantreact=1
		spawn(30)	// Can we please not forget to make sure things are still valid after any sleep or spawn call.
			if(x)	x.cantreact=0
		var/obj/o=new/obj(locate(x.x,x.y,x.z))
		o.icon='icons/rasengan.dmi'
		o.layer=MOB_LAYER+1
		if(!x.icon_state)
			x.icon_state="hurt"

		flick("hit",o)

		x.Earthquake(10)
		x.Damage(750+750*conmult, 0, u, "Rasengan", "Normal")
		spawn(50)
			o.loc = null
		sleep(10)
		if(x)
			x.Knockback(10,xdir)
			if(x)	// Knockback sleeps, I think. It really shouldn't though.
				explosion(50,x.x,x.y,x.z,u,1)
				x.Timed_Stun(30)
				if(!x.ko)
					x.icon_state=""
				x.Hostile(u)
			spawn(5) if(x) x.Replacement_End()


	SRasengan_Fail()
		src.rasengan=0
		src.overlays-=/obj/rasengan
		src.overlays-=/obj/rasengan2
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER+1
		o.icon='icons/rasengan.dmi'
		flick("failed",o)
		spawn(50)
			o.loc = null
	SRasengan_Hit(mob/x,mob/human/u,xdir)
		x = x.Replacement_Start(u)
		u.overlays-=/obj/rasengan
		u.overlays-=/obj/rasengan2
		u.rasengan=0
		var/conmult= u.ControlDamageMultiplier()
		x.cantreact=1
		spawn(30)	// Can we please not forget to make sure things are still valid after any sleep or spawn call.
			if(x)	x.cantreact=0
		var/obj/o=new/obj(locate(x.x,x.y,x.z))
		o.icon='icons/rasengan.dmi'
		o.layer=MOB_LAYER+1
		if(!x.icon_state)
			x.icon_state="hurt"

		flick("hit",o)

		x.Earthquake(10)
		x.Damage(375+375*conmult, 0, u, "Space-Time Rasengan", "Normal")
		spawn(50)
			o.loc = null
		sleep(10)
		if(x)
			x.Knockback(10,xdir)
			if(x)	// Knockback sleeps, I think. It really shouldn't though.
				explosion(50,x.x,x.y,x.z,u,1)
			//	x.Timed_Stun(30)
				if(!x.ko)
					x.icon_state=""
				x.Hostile(u)
			spawn(5) if(x) x.Replacement_End()


	BunshinTrick(list/bunshins)
		FilterTargets()
		for(var/mob/M in targeted_by)
			var/max_targets = M.MaxTargets()
			var/active = 0
			if(src in M.active_targets) active = 1
			if(!active)
				max_targets -= M.MaxActiveTargets()

			var/result=Roll_Against((int+intbuff-intneg)*(1 + 0.05*skillspassive[20]),(M.int+M.intbuff-M.intneg)*(1 + 0.05*M.skillspassive[20]),100)
			//world << "user=>[src.realname],int[int+intbuff-intneg],bunshintrick:[1 + 0.05*skillspassive[20]] vs target=>[M.realname],int:[M.int+M.intbuff-M.intneg],bunshintrick:[1 + 0.05*M.skillspassive[20]]"
			//world << "result=>[result], sharingan?[M.sharingan]"
			if(result > 4 && !M.sharingan)
				//world<<"tricked"
				var/list/valid_targets = list(src)
				valid_targets += bunshins
				var/picked_targets = 0
				while(valid_targets.len && picked_targets < max_targets)
					var/target = pick(valid_targets)
					valid_targets -= target
					++picked_targets
					M.AddTarget(target, active=1, silent=1)
					M.RemoveTarget(src)
					if(prob(60))
						M.AddTarget(src, active=0, silent=1)
			else
				var/list/valid_targets = bunshins.Copy()
				var/picked_targets = 0
				while(valid_targets.len && picked_targets < (max_targets - 1))
					var/target = pick(valid_targets)
					valid_targets -= target
					M.RemoveTarget(target)
					M.AddTarget(target, active=0, silent=1)
					++picked_targets
				M.RemoveTarget(src)
				M.AddTarget(src, active=active, silent=1)
