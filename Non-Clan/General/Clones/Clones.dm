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
                             PAPER_SHURIKEN, PAPER_CHASM, MIND_TRANSFER, MIND_TAG, MIND_DISTURBANCE, FLOWER_BOMB, SHIKI_FUJIN, UNIVERSAL_PUSH, UNIVERSAL_PULL,
                             NEEDLE_UMBRELA, SUITON_COLLISION_DESTRUCTION, SUITON_SHOCKWAVE, TWIN_RISING_DRAGONS, DOTON_IRON_SKIN, HIRAISHIN_1, HIRAISHIN_2, HIRAISHIN_KUNAI,
                             SLY_MIND, CROW , TREE_BIND, INSTANT_SLASH, IAI_BEHEADING, DANCING_BLADE, DOTON_SWAMP_FIELD)


skill

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
		default_chakra_cost = 200
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
			//max ammount of clones you can summon now based off bunshin passive
			//but you still need the chakra to summon them.


			var/max = min(1,user.skillspassive[20]) //minimum 1 clone I guess

			while(used_chakra>default_chakra_cost && am<=max && options.len)
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