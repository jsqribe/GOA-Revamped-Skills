skill
	var
		name
		description
		icon = 'icons/gui.dmi'
		icon_state
		list/icon_overlays
		id
		default_chakra_cost = 0
		default_stamina_cost = 0
		default_supply_cost = 0
		default_cooldown = 0
		default_seal_time = 0
		base_charge = 0
		max_charge = 0
		charging = 0
		charge = 0
		copyable = 1
		cooldown
		uses
		skillcards[0]
		skill/master
		face_nearest = 0
		stamina_damage_fixed[]
		stamina_damage_con[]
		stamina_damage_str
		wound_damage_fixed[]
		wound_damage_con[]
		noskillbar
		modified = 0
		charge2 = 0

		//Added for Skill Tree
		cost=0 //cost to buy
		list/skill_reqs
		element
		list/element_reqs
		clan
		list/clan_reqs
		stack="true" //should we stack the children skills
		canbuy=1//should we display buy button

		//Fuse in Passive system and also allow skill upgrades
		max //how many times it can be bought



	proc
		IsUsable(mob/user)
			if(cooldown > 0)
				Error(user, "Cooldown Time ([cooldown] seconds)")
				return 0
			else if(user.curchakra < ChakraCost(user))
				Error(user, "Insufficient Chakra ([user.curchakra]/[ChakraCost(user)])")
				return 0
			else if(user.curstamina < StaminaCost(user))
				Error(user, "Insufficient Stamina ([user.curstamina]/[StaminaCost(user)])")
				return 0
			else if(user.supplies < SupplyCost(user))
				Error(user, "Insufficient Supplies ([user.supplies]/[SupplyCost(user)])")
				return 0
			else if(user.gate && ChakraCost(user) && !istype(src, /skill/taijutsu/gates))
				Error(user, "This skill cannot be used while a gate is active")
				return 0
			else if(user.Size==1 && !istype(src, /skill/akimichi/size_multiplication))
				Error(user, "This skill cannot be used while Size Multiplication is active")
				return 0
			else if(user.Size==2 && !istype(src, /skill/akimichi/super_size_multiplication))
				Error(user, "This skill cannot be used while a Super Size Multiplication is active")
				return 0
			else if(user.chambered && !istype(src, /skill/earth/mole_hiding))
				return 0
			else if(user.mole && !istype(src, /skill/earth/head_hunter) && !istype(src, /skill/earth/mole_hiding))
				Error(user, "This skill cannot be used while under ground")
				return 0
			else if(user.larch && !istype(src, /skill/kaguya))
				Error(user, "This skill cannot be used during larch dance")
				return 0
			return 1


		Cooldown(mob/user)
			if(user && user.skillspassive[6])
				if(user.inevent && urf_mod)
					return (round(default_cooldown * (1 - user.skillspassive[6] * 0.03)))*0.20//80%
				else
					return round(default_cooldown * (1 - user.skillspassive[6] * 0.03))
			else
				if(user.inevent && urf_mod)
					return default_cooldown*0.20//80%
				else
					return default_cooldown


		ChakraCost(mob/user)
			//if(base_charge) //removing this allows for an initial chakra cost, and then the base_charge per tick of charge
			//	return base_charge
			//else
			if(user && user.skillspassive[5])
				if(user.inevent && urf_mod)
					return (round(default_chakra_cost * (1 - user.skillspassive[5] * 0.04)))*0.20//80%
				else
					return round(default_chakra_cost * (1 - user.skillspassive[5] * 0.04))
			else
				if(user.inevent && urf_mod)
					return default_chakra_cost*0.20//80%
				else
					return default_chakra_cost


		StaminaCost(mob/user)
			return default_stamina_cost


		SupplyCost(mob/user)
			return default_supply_cost

		SealTime(mob/user)
			var/time = default_seal_time
			if(user.move_stun) time = time*2+5
			return time


		Use(mob/user)
		Use_Up(mob/user)
			charge2 = 0


		Activate(mob/human/user)
			spawn(0)
				if(!((src in user.skills) || (master && (master in user.skills))))
					usr << "Nice try using a skill you don't have."
					world.log << "\"[user.realname]\"[user.client?"([user.client.address] - [user.client.computer_id])":""] attempted to use skill \"[src]\", which they do not have."
					return


				if(user.leading)
					user.leading.following = 0
					user.leading = 0
					return

				//allow rasengan,ctr,chidori through shunshin once!
				if (( user.rasengan || user.sakpunch || user.chidori ) &&!user.skillbypass && istype(src,/skill/body_flicker))
				//if ( user.sakpunch  &&!user.skillbypass && istype(src,/skill/body_flicker)) only ctr
					//user.combat("[src] bypass")
					user.skillbypass=1
				else
					//user.combat("[src] no bypass")
					if ( user.rasengan || user.sakpunch || user.chidori )
						return
					else
						user.skillbypass=0//reset


				if(user.rasengan==1 && !istype(src,/skill/body_flicker) )
					user.Rasengan_Fail()
				else if(user.rasengan==2)
					user.ORasengan_Fail()
				else if(user.rasengan == 6)
					user.SRasengan_Fail()


				if(user.qued==1)
					user.Deque()
				else if(user.qued2==1)
					user.Deque2()

				if(user.isguard)
					user.icon_state=""
					user.isguard=0

				if(user.madarasusano==1)
					user.overlays-=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)

				if(user.sasukesusano == 1)
					user.overlays-=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)
					user.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)

				if(user.itachisusano==1)
					user.overlays-=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)

				if(user.ironmass == 1)
					user.overlays-=image('icons/magnetdef.dmi',pixel_x=-32,pixel_y=-32)

				if(user.camo)
					user.camo=0
					user.Affirm_Icon()
					user.Load_Overlays()

				if(charging)
					charging = 0
					return


				//user.combat("Here1 [src]")
				//user.combat("[user.startclash],[user.stakes],[user.skillusecool && !user.skillbypass],[(!user.CanUseSkills() && !istype(src,/skill/namikaze/hiraishin_1))],[(!IsUsable(user) && !istype(src,/skill/namikaze/hiraishin_1))],[(user.mane && !istype(src,/skill/nara))]")
				if(user.startclash || user.stakes || (user.skillusecool && !user.skillbypass) || (!user.CanUseSkills() && !istype(src,/skill/namikaze/hiraishin_1)) || (!IsUsable(user) && !istype(src,/skill/namikaze/hiraishin_1)) || (user.mane && !istype(src,/skill/nara)))
					return
				//user.combat("Here2 [src]")
				user.skillusecool = 1
				AddOverlay('icons/selected.dmi')

				if(user.naturechakra > 0)
					user.naturechakra -= ChakraCost(user)
					if(user.naturechakra < 0)
						user.curchakra += user.naturechakra
						user.naturechakra = 0
				else user.curchakra -= ChakraCost(user)

				user.curstamina -= StaminaCost(user)
				if(user.clan == "Weaponist")
					user.supplies -= SupplyCost(user)/2
				else
					user.supplies -= SupplyCost(user)

				if(base_charge)
					user.combat("[src]: Use this skill again to stop charging.")
					charge = base_charge
					charging = 1
					var/chakra_charge = 1
					while(charging && user && user.CanUseSkills())
						if(chakra_charge && (!max_charge || charge < max_charge))
							var/charge_amt = min(base_charge, user.curchakra)
							var/charge_amt_n = min(base_charge, user.naturechakra)
							if(user.naturechakra > 0)
								user.curchakra -= charge_amt_n
							else user.curchakra -= charge_amt
							charge += charge_amt
							user.combat("[src]: Charged [charge] chakra.")
							if(user.curchakra <= 0)
								user.combat("[src]: Out of chakra. Use this skill again to finish charging.")
								chakra_charge = 0
						sleep(5)
					if(!user)
						RemoveOverlay('icons/selected.dmi')
						return
					else if(!user.CanUseSkills())
						user.skillusecool = 0
						RemoveOverlay('icons/selected.dmi')
						return

				if(face_nearest)
					if(user.NearestTarget()) user.FaceTowards(user.NearestTarget())
				else
					if(user.MainTarget()) user.FaceTowards(user.MainTarget())


				for(var/mob/human/player/XE in oview(8))
					var/can_copy = 0
					if(copyable && XE.HasSkill(SHARINGAN_COPY) && !XE.HasSkill(id))
						can_copy = 1
						XE.lastwitnessing=id
						spawn(50)
							if(XE) XE.lastwitnessing=0
					if(XE.sharingan || XE.impsharingan)
						XE.combat("<font color=#faa21b>{Sharingan} [user] used [src].[can_copy?" Press <b>Space</b> within 5 Seconds to copy this skill.":""]</font>")


				user.lastskill = id
				++uses
				DoSeals(user)
				var/incomplete
				if(user && user.CanUseSkills())
					if(Use(user)) incomplete = 1

				RemoveOverlay('icons/selected.dmi')

				if(!user)
					return

				spawn(2)
					if(user) user.skillusecool = 0

				if(!istype(src, /skill/medic/heal) && !istype(src, /skill/earth/mole_hiding)) user.CombatFlag("offense")
				if(!incomplete) DoCooldown(user)


		DoSeals(mob/human/user)
			var/time = SealTime(user)
			if(time)
				if(user.skillspassive[5] == 5 && user.client.run_count > 4 && !istype(src,/skill/water/water_dragon))
					user.move_stun=0
					user.icon_state="HandSeals-Run"
					while(user && time)
						if(!user || !user.CanUseSkills())
							user << "break as cannot use skill"
							break
						time--
						sleep(world.tick_lag)

				if(istext(time)) time = text2num(time)
				user.icon_state="HandSeals"
				user.handseal_stun = 1
				while(user && time)
					if(!user || !user.CanUseSkills())
						user << "break as cannot use skill"
						break
					time--
					sleep(world.tick_lag)

				if(user)
					user.icon_state=""
					user.handseal_stun = 0



		DoCooldown(mob/user, resume = 0, passthrough = 0)
			if(!resume) cooldown = Cooldown(user)

			spawn(0)
				for(var/skillcard/card in skillcards)
					card.overlays -= 'icons/dull.dmi'
				if(master)
					for(var/skillcard/card in master.skillcards)
						card.overlays -= 'icons/dull.dmi'

			if(!cooldown) return

			spawn(0)
				for(var/skillcard/card in skillcards)
					card.overlays += 'icons/dull.dmi'
				if(master)
					for(var/skillcard/card in master.skillcards)
						card.overlays += 'icons/dull.dmi'

			spawn(0)//spawn off the skill c/d
				while(cooldown > 0)
					sleep(world.tick_lag*10)
					//world<< "[src] Cooldown [cooldown]"
					--cooldown

				spawn(0)
					for(var/skillcard/card in skillcards)
						card.overlays -= 'icons/dull.dmi'
					if(master)
						for(var/skillcard/card in master.skillcards)
							card.overlays -= 'icons/dull.dmi'
				modified = 0


		Error(mob/user, message)
			user.combat("[src] can not be used currently: [message]")


		ChangeIconState(new_state)
			icon_state = new_state
			for(var/skillcard/card in skillcards)
				card.icon_state = new_state
			if(master)
				master.IconStateChanged(src, new_state)


		IconStateChanged(skill/sk, new_state)


		AddOverlay(overlay)
			for(var/skillcard/card in skillcards)
				card.overlays += overlay
			if(master)
				master.OverlayAdded(src, overlay)


		RemoveOverlay(overlay)
			for(var/skillcard/card in skillcards)
				card.overlays -= overlay
			if(master)
				master.OverlayRemoved(src, overlay)


		OverlayAdded(skill/sk, overlay)


		OverlayRemoved(skill/sk, overlay)


		EstimateStaminaCritDamage(mob/human/user)


		EstimateStaminaDamage(mob/human/user)
			var/conmult = user.ControlDamageMultiplier()
			if(stamina_damage_fixed && stamina_damage_con)
				if(stamina_damage_str == 1)
					return list(stamina_damage_fixed[1] + stamina_damage_con[1]*conmult, stamina_damage_fixed[2] + stamina_damage_con[2]*conmult + user.str)
				else if(stamina_damage_str == 2)
					return list(stamina_damage_fixed[1] + stamina_damage_con[1]*conmult, stamina_damage_fixed[2] + stamina_damage_con[2]*conmult + user.str/2)
				else
					return list(stamina_damage_fixed[1] + stamina_damage_con[1]*conmult, stamina_damage_fixed[2] + stamina_damage_con[2]*conmult)
			return null


		EstimateWoundDamage(mob/human/user)
			var/conmult = user.ControlDamageMultiplier()
			if(wound_damage_fixed && wound_damage_con)
				return list(wound_damage_fixed[1] + wound_damage_con[1]*conmult, wound_damage_fixed[2] + wound_damage_con[2]*conmult)
			return null



skillcard
	parent_type = /obj
	layer = 151



	var
		skill/skill
		noskillbar



	New(loc, skill/sk)
		..(loc)
		skill = sk
		name = sk.name
		icon = sk.icon
		icon_state = sk.icon_state
		overlays = sk.icon_overlays
		mouse_drag_pointer = icon('icons/guidrag.dmi', sk.icon_state)
		if(sk.cooldown || (istype(sk, /skill/uchiha/sharingan_copy) && sk:copied_skill && sk:copied_skill:cooldown)) overlays += 'icons/dull.dmi'
		sk.skillcards += src
		if(sk.noskillbar) noskillbar = 1


	Click(location, control, params_text)
		var/params = params2list(params_text)

		var/screen_loc = ""
		if(params["screen-loc"])
			screen_loc = params["screen-loc"]
			var/screen_loc_lst = dd_text2list(screen_loc, ",")
			var/screen_loc_non_pixel_lst = list()

			for(var/loc in screen_loc_lst)
				var/loc_lst = dd_text2list(loc, ":")
				screen_loc_non_pixel_lst += loc_lst[1]

			screen_loc = dd_list2text(screen_loc_non_pixel_lst, ",")

		skill.Activate(usr)
		/*if(!control || (control == "map_pane.map" && screen_loc == src.screen_loc))
			skill.Activate(usr)
		else
			usr.combat("Skills can only be used from the macro bar")*/

	MouseDrop(obj/over_object, src_location, over_location, src_control, over_control, params_text)
		if(src == over_object)
			return

	/*	var/Reso=winget(usr,"mainwindow.Resolution","size")
		var/pos=findtext(Reso,"x")
		var/width=copytext(Reso,1,pos)
		width=text2num(width)*/

		var/params = params2list(params_text)

		var/screen_loc = params["screen-loc"]
		var/screen_loc_lst = dd_text2list(screen_loc, ",")
		var/screen_loc_non_pixel_lst = list()

		for(var/loc in screen_loc_lst)
			var/loc_lst = dd_text2list(loc, ":")
			screen_loc_non_pixel_lst += loc_lst[1]

		screen_loc = dd_list2text(screen_loc_non_pixel_lst, ",")


		if(istype(over_object, /obj/gui/hud/skillbar) || istype(over_object, /skillcard) || istype(over_object, /obj/items/Puppet_Stuff))
			if(noskillbar)
				var/skill/skill = src.skill
				if(skill.id >= 1300 && skill.id <= 1360)
					usr << "[src] does not need to go on your skill bar. The Opening Gate skill card will automatically update as needed."
				return
			var/spot
		/*	if(screen_loc == "1,1")//"[round(width/32)]-27:15,1")
				spot = 1
			if(screen_loc == "[round(width/32)]-26:15,1")
				spot = 2*/
			switch(screen_loc)
				if("3,1")
					spot=1
				if("4,1")
					spot=2
				if("5,1")
					spot=3
				if("6,1")
					spot=4
				if("7,1")
					spot=5
				if("8,1")
					spot=6
				if("9,1")
					spot=7
				if("10,1")
					spot=8
				if("11,1")
					spot=9
				if("12,1")
					spot=10
				if("13,1")
					spot=11
				if("14,1")
					spot=12
				if("15,1")
					spot=13

			if(spot)
				if(usr.vars["macro[spot]"])
					if(istype(usr.vars["macro[spot]"], /skill))
						var/skill/s = usr.vars["macro[spot]"]
						for(var/skillcard/c in s.skillcards)
							if(c.screen_loc == screen_loc)
								usr.client.screen -= c
								usr.client.player_gui -= c
					else if(istype(usr.vars["macro[spot]"], /obj/items/Puppet_Stuff))
						//var/obj/items/Puppet_Stuff/p = usr.vars["macro[spot]"]
						for(var/obj/items/Puppet_Stuff/c in usr.client.screen)
							if(c.screen_loc == screen_loc)
								usr.client.screen -= c
								usr.client.player_gui -= c
				usr.client.player_gui += src
				src.screen_loc = screen_loc
				usr.client.screen += src
				usr.vars["macro[spot]"] = skill




proc/show_skill_name(skill, time, over)
	var/icon/I = new('icons/skill_name.dmi')
	var/image/img = image(I, over ,"[skill]")
	img.pixel_x = -((I.Width()-world.IconSizeX())/2)
	img.pixel_z = world.IconSizeY()
	world << img
	spawn(time)
		CHECK_TICK
		del img



mob/var/skillbypass=0 // used for ctr currently..

mob
	proc
		AddSkill(id, skillcard=1, add_unknown=1)
			var/skill_type = SkillType(id)
			var/skill/skill
			if(!skill_type)
				if(add_unknown)
					skill = new /skill()
					skill.id = id
					skill.name = "Unknown Skill ([id])"
			else
				skill = new skill_type()
			if(skill)
				skills += skill
			if(skillcard)
				new /skillcard(src, skill)
			return skill

		RemoveSkill(id)
			for(var/skill/S in skills)
				if(S.id == id)
					CHECK_TICK
					del S


		HasSkill(id)
			for(var/skill/skill in skills)
				if(skill.id == id)
					return 1
			return 0


		GetSkill(id)
			for(var/skill/skill in skills)
				if(skill.id == id)
					return skill


		ControlDamageMultiplier()
			var/conmult=(con + conbuff - conneg)/150
			if(skillspassive[24]) conmult *= 1 + 0.04 * skillspassive[24]
			conmult = round(conmult,0.01)
			return conmult


		CanUseSkills(inskill = 0)
			if(usr.chambered)
				for(var/obj/earthcage/cage in usr.loc)
					if(cage.owner == usr)
						return !cantreact && !spectate && !frozen && !sleeping && !ko && canattack && !Tank && pk
			return !cantreact && !spectate && !frozen && !sleeping && !ko && canattack && !stunned && !Tank && pk


		RefreshSkillList()
			if(client)
				var/grid_item = 0
				for(var/skillcard/X in contents)
					if( client && X.skill && !(X.skill.id in list(GATE2,GATE2,GATE3,GATE4,GATE5,GATE6,GATE7,GATE8)) )
						src << output(X, "skills_grid:[++grid_item]")
				if(client)
					winset(src, "skills_grid", "cells=[grid_item]")





proc
	SkillType(id)
		for(var/skill/skill in all_skills)
			if(skill.id == id)
				return skill.type

	ExampleSkill(id)
		for(var/skill/skill as() in all_skills)
			if(skill.id == id)
				//world.log << "[skill.name] -> [skill.id]"
				return skill



var
	all_skills[0]


