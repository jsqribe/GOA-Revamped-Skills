mob/var/afteryou=0
mob
	var
		lastskill=0

mob/WalkTo
	density=1
var/RandomKills = rand(100,200)
var/RandomKills2 = rand(250,300)

mob/var/tmp/PressAButton=""

obj/interactable
	paper
		verb
			Interact()
				set hidden=1
				set src in oview(1)


mob/human/npc/eventshopnpc
	interact="Shop"
	verb
		Shop()
			set src in oview(1)
			set hidden=1
			if(usr && usr.client)// && usr.client.byond_member_access)
				usr.client.eye = locate("e-shop")
			//	usr.hidestat = 0
				usr.spectate = 1
				src.Check_Sales(usr)


mob/human/npc/membershopnpc
	interact="Shop"
	verb
		Shop()
			set src in oview(1)
			set hidden=1
			if(usr && usr.client)// && usr.client.byond_member_access)
				usr.client.eye = locate("m-shop")
			//	usr.hidestat = 0
				usr.spectate = 1
				src.Check_Sales(usr)

mob/human/npc/shopnpc
	interact="Shop"
	verb
		Shop()
			set src in oview(1)
			set hidden=1
			usr.client.eye = locate("w-shop")
		//	usr.hidestat = 0
			usr.spectate = 1
			src.Check_Sales(usr)

mob/human/npc/clothing_shop_npc
	interact="Shop"
	verb
		Shop()
			set src in oview(1)
			set hidden=1
			usr.client.eye = locate("c-shop")
		//	usr.hidestat = 0
			usr.spectate = 1
			src.Check_Sales(usr)

mob/human/npc/armor_shop_npc
	interact="Shop"
	verb
		Shop()
			set src in oview(1)
			set hidden=1
			usr.client.eye = locate("a-shop")
		//	usr.hidestat = 0
			usr.spectate = 1
			src.Check_Sales(usr)

mob/human/npc/doctornpc
	interact="Doctor"
	verb
		Heal()
			set src in oview(1)
			set hidden=1
			usr<<"Hello, if you need to recover there are beds to the right up the stairs. (press space/interact to get in one)"
turf/warp
	verb
		Owner()
			if(!allow_rent)
				usr << "Rental property is disabled on this server"
				return 0
			if(src.requires_owner)
				if(src.owner)
					if(src.owner == usr.realname)
						switch(alert("Residence Control Panel",,"Rent Options","Manage Allowed List","Cancel"))
							if("Rent Options")
								var/dayofyear = dayofyear()
								usr << "Your renewal date is in [src.renewal_date - dayofyear] days."
								switch(alert("Rent Options",,"Pay Rent","Cancel Lease","Cancel"))
									if("Pay Rent")
										switch(alert("Are you sure you would like to pay your rent at this time for [src.cost] ryo?\nCAUTION: The renewal date will be pushed out to 7 days from today, not 7 days from your due date. Eastern Timezone.",,"Yes","No"))
											if("Yes")
												if(usr.money < src.cost)
													usr << "You cannot afford to pay your rent."
												else
													usr.money -= src.cost
													src.renewal_date = dayofyear() + 7
													usr << "Your new due date has been set to 7 days from now."
									if("Cancel Lease")
										switch(alert("Are you sure you would like to cancel your lease?",,"Yes","No"))
											if("Yes")
												world << "[usr.realname] has canceled their lease!"
												src.owner = null
												src.owner_allowed_list = list()
							if("Manage Allowed List")
								var/done = 0
								while(!done)
									usr << "<b>Current members of your allowed list</b>"
									usr << "[usr.realname]"
									for(var/i in src.owner_allowed_list)
										usr << "[i]"
									switch(alert("Manage Allowed List",,"Add To List","Remove From List","Finished"))
										if("Add To List")
											var/add = input("Enter the name of whom you would like to add to your allowed list.")
											if(add && add != usr.realname) src.owner_allowed_list.Add(add)
										if("Remove From List")
											var/list/choices[] = src.owner_allowed_list.Copy()
											choices.Add("Cancel")
											var/choice = input("Select the name of whom you would like to remove from your allowed list.") in choices
											if(choice != "Cancel") src.owner_allowed_list.Remove(choice)
										if("Finished")
											done = 1
					else if(usr.realname in src.owner_allowed_list)
						var/dayofyear = dayofyear()
						usr << "[src.owner] owns this property for at least [src.renewal_date - dayofyear] more days. You are on the owner's allowed list."
					else
						var/dayofyear = dayofyear()
						usr << "[src.owner] owns this property for at least [src.renewal_date - dayofyear] more days. You are not on the owner's allowed list."
				else
					switch(alert("No one owns this residence. Would you like to rent it for [src.cost] a week?",,"Yes","No"))
						if("Yes")
							if(src.owner)
								usr << "Someone rented this property while you were considering it! Tough break.."
							else
								if(usr.money < src.cost)
									usr << "You cannot afford to rent this residence."
								else
									usr.money -= src.cost
									src.owner = usr.realname
									src.renewal_date = dayofyear() + 7
									world << "[usr.realname] has rented a residence!"
			else if(src.requires_faction_owner)
				if(src.faction_owner)
					var/faction_name = usr.faction.name
					var/faction/faction = load_faction(faction_name)
					if(!faction)
						world << "BUG: The faction (\"[faction_name]\") does not exist."
						return 0
					else if(usr.faction.village != "Missing")
						world << "BUG: [usr.realname] is attempting to rent a property for a faction that is not missing. returning.."
						return 0
					else if(usr.faction && usr.faction.name == src.faction_owner && faction.leader == usr.realname)
						var/dayofyear = dayofyear()
						usr << "Your renewal date is in [src.renewal_date - dayofyear] days."
						switch(alert("What would you like to do?",,"Pay Rent","Cancel Lease","Cancel"))
							if("Pay Rent")
								switch(alert("Are you sure you would like to pay your rent at this time for [src.cost] ryo?\nCAUTION: The renewal date will be pushed out to 7 days from today, not 7 days from your due date. Eastern Timezone.",,"Yes","No"))
									if("Yes")
										if(usr.money < src.cost)
											usr << "You cannot afford to pay your rent."
										else
											usr.money -= src.cost
											src.renewal_date = dayofyear() + 7
											usr << "Your new due date has been set to 7 days from now."
							if("Cancel Lease")
								switch(alert("Are you sure you would like to cancel your lease?",,"Yes","No"))
									if("Yes")
										world << "[usr.realname] of [usr.faction.name] has canceled their lease!"
										src.faction_owner = null
					else if(usr.faction && usr.faction.name == src.faction_owner)
						var/dayofyear = dayofyear()
						usr << "[src.faction_owner] owns this property for at least [src.renewal_date - dayofyear] more days. You are a member of [src.faction_owner]."
					else
						var/dayofyear = dayofyear()
						usr << "[src.faction_owner] owns this property for at least [src.renewal_date - dayofyear] more days."
				else
					var/faction_name = usr.faction.name
					var/faction/faction = load_faction(faction_name)
					if(!faction)
						world << "BUG: The faction (\"[faction_name]\") does not exist."
						return 0
					else if(usr.faction.village != "Missing")
						world << "BUG: [usr.realname] is attempting to rent a property for a faction that is not missing. returning.."
						return 0
					else if(faction.leader != usr.realname)
						usr << "No one owns this faction residence. You are not the leader of your faction, therefore you are not authorized to make this purchase."
					else
						switch(alert("No one owns this faction residence. Would you like to rent it for [src.cost] a week?",,"Yes","No"))
							if("Yes")
								if(src.owner)
									usr << "Someone rented this property while you were considering it! Tough break.."
								else
									if(usr.money < src.cost)
										usr << "You cannot afford to rent this residence."
									else
										usr.money -= src.cost
										src.faction_owner = faction_name
										src.renewal_date = dayofyear() + 7
										world << "[usr.realname] has rented a residence for [faction_name]!"
			src.Warp_Save()


mob/human/npc/Faction_NPC
	interact="Faction"
	verb
		Faction()
			set hidden=1
			set src in oview(1)
			if(usr.faction.village != "Missing")
				usr << "You must be a missing nin in order to create a faction."
				return 0
			var/choice = input("Would you like to create or edit a missing faction?", "New, Edit, Cancel", usr.gender) in list("New","Edit","Cancel")
			if(choice == "Cancel")
				return 0
			if(choice == "Edit")
				var/faction_name = usr.faction.name
				var/faction/faction = load_faction(faction_name)
				if(!faction)
					src << "The faction (\"[faction_name]\") does not exist."
				else
					if(usr.faction.village != "Missing")
						world << "[usr.realname] is editing the Member Limit of a faction that is not missing. returning.."
						return 0
					if(faction.leader != usr.realname)
						usr << "You are not the leader of your faction."
						return 0
					var/editchoice = input("Would you like to raise your member limit or add uniforms?", "Member Limit, Uniforms, Cancel") in list("Member Limit","Uniforms","Cancel")
					if(editchoice == "Member Limit")
						var/list/faction_info = usr.faction.name
						var/cur_member_limit = text2num(faction_info["member_limit"])
						var/new_limit = null
						var/cost = 5000
						if(cur_member_limit < 24)
							new_limit = cur_member_limit + 2
						else
							usr << "Member limit is maxed out"
							return 0
						var/limitchoice = input("Your current member limit is [cur_member_limit]. Would you like to raise your member limit from [cur_member_limit] to [new_limit] at the cost of [cost] ryo?", "Yes, No") in list("Yes","No")
						if(limitchoice == "No") return 0
						if(usr.money < cost)
							usr << "You cannot afford to start a missing faction."
							return 0
						usr.money -= cost
				//		saves.ChangeFactionLimit(faction_name, new_limit)
						usr << "Your faction ([faction_name]) has had its member limit increased to [new_limit]!"
						return 1

					if(editchoice == "Uniforms")
						var/cost = 20000
				//		var/list/faction_info = saves.GetFactionInfo(usr.faction.name)
						var/cur_chuunin_item = usr.faction["chuunin_item"]
						//var/cur_chuunin_item_color = faction_info["chuunin_item_color"]
						if(cur_chuunin_item != "0")
							cost = 10000
						var/new_chuunin_item = 259
					//	var/new_chuunin_item_color = input(usr, "What color do you want your uniform to be?") as color
						var/uniformchoice = input("Would you like to purchase a uniform for your faction with the color you chose at the cost of [cost] ryo?", "Yes, No") in list("Yes","No")
						if(uniformchoice == "No") return 0
						if(usr.money < cost)
							usr << "You cannot afford to purchase this uniform."
							return 0
						usr.money -= cost
						if(new_chuunin_item == 259)
							var/give = 1
							for(var/obj/items/equipable/Chuunin_Missing/CM1 in usr.contents)
								give = 0
							if(give) usr.contents += new/obj/items/equipable/Chuunin_Missing
						usr.faction.chuunin_item = new_chuunin_item
					//	usr.faction.chuunin_item_color = new_chuunin_item_color
					//	saves.ChangeFactionChuuninItem(faction_name, new_chuunin_item)
					//	saves.ChangeFactionChuuninItemColor(faction_name, new_chuunin_item_color)
						usr << "Your faction ([faction_name]) has purchased a new uniform!"
						usr.Load_Overlays()
						return 1
					if(editchoice == "Cancel") return 0

			if(choice == "New")
				if(usr.blevel < 20 || usr.rank == "Genin" || usr.rank == "Academy Student")
					usr << "You must be a level 20 or higher and chuunin rank to create a faction."
					return 0
				var/choice2 = input("Creating a faction will remove you from your current faction. Is this OK?", "Confirmation", "") in list("Yes","No")
				if(choice2 == "No") return 0
				var/factionname = input("Choose a name for your faction.", "Faction Name", "")
				var/faction_name = Replace_All(factionname,chat_filter)
				if(factionname != faction_name)
					usr << "[factionname] is not an appropriate faction name."
					return 0
				if(html_encode(faction_name) != faction_name)
					usr << "[factionname] is not an appropriate faction name."
					return 0
				if(faction_name in list("Akatsuki","Blitzkreig","Amegakure","Sound","Rock","Cloud","Leaf","Sand","Mist","Rain","Hebi","Waterfall","Grass"))
					usr << "[factionname] is a reserved faction name"
					return 0

				var/mob/human/player/leader_name = usr
				var/village = "Missing"
				var/mouse_icon = ""
				var/chat_icon = "Missing"
				var/chuunin_item = 0
				var/chuunin_item_color = "#000000"
				var/member_limit = 8
			//	var/list/faction_info = saves.GetFactionInfo(faction_name)
				if(!usr.faction || !usr.faction["name"])
					var/cost = 50000
					var/choice3 = input("Creating this faction will cost [cost] ryo.\nCAUTION: This is nonrefundable. If you leave your faction, your faction will be left leaderless. Faction leadership is nontransferable.\nIs this OK?", "Confirmation", "") in list("Yes","No")
					if(choice3 == "No") return 0
					if(usr.money < cost)
						usr << "You cannot afford to start a missing faction."
						return 0
					usr.money -= cost
					var/faction/faction = new /faction(faction_name, village, leader_name, mouse_icon, chat_icon, chuunin_item, chuunin_item_color, member_limit, 1)
					faction.tag = "faction__[faction.name]"
					if(ismob(leader_name))
						faction.AddMember(leader_name)
						leader_name:Refresh_Faction_Verbs()
					world << "Faction [faction_name] has been created by [usr.realname]!"
				else
					usr << "There is already a faction using that name"

obj
	haku_ice
		var/dissipate_count = 0
		icon = 'icons/haku_ice.dmi'
		New()
			. = ..()
			spawn()
				flick("create", src)
				while(src)
					sleep(1)
					++dissipate_count
					for(var/mob/human/M in loc)
						if(M.clan == "Haku")
							dissipate_count = 0
							break
					if(dissipate_count > 50) del src

obj
	turrent_path
		var/dissipate_count = 0
		icon = 'icons/turrent.dmi'
		New()
			. = ..()
			spawn(1)
				while(src)
					sleep(1)
					++dissipate_count
					if(dissipate_count > 3) del src

obj
	chi_path
		var/dissipate_count = 0
		icon = 'icons/mole_hiding_technique.dmi'
		icon_state = "Trail"
		New()
			. = ..()
			spawn()
				while(src)
					sleep(1)
					++dissipate_count
					if(dissipate_count > 20) del src

mob/var/movin=0
mob/var/afteryou_cool=0
//mob/var/EnteredBlood=0
mob/human/clay
	Move(turf/new_loc,dirr)
		justwalk = 1
		. = ..()

		var/area/A = loc.loc
		if(!A.pkzone)
			var/mob/human/clay/spider/S = src
			if(istype(S) && S.owner && istype(S.owner,/mob/human/player))
				for(var/obj/trigger/exploding_spider/T in S.owner.triggers)
					if(T.spider == src) S.owner.RemoveTrigger(T)
			del src
		return

mob/human/Puppet
	Move(turf/new_loc,dirr)
		. = ..()
		var/area/A = loc.loc
		if(!A.pkzone)
			src.curwound=900
			src.curstamina=0
			src.Hostile()
		return

obj/BSEnter
	icon='icons/bloodtracks.dmi'
	icon_state="enter"
	New()
		..()
		spawn(rand(70,110))
			del(src)
obj/BSExit
	icon='icons/bloodtracks.dmi'
	icon_state="exit"
	New()
		..()
		spawn(rand(70,110))
			del(src)

mob/human
	Move(turf/new_loc,dirr)
		sleep(1)
		/*
		for(var/obj/undereffect/U in world)
			if(U.icon=='icons/blood.dmi')
				if(U.loc==locate(src.x,src.y,src.z))
					src.EnteredBlood+=2
					//world.log << "jashin3 [src.EnteredBlood]"
		if(src.EnteredBlood>=6)
			src.EnteredBlood=6
		if(src.EnteredBlood>0)
			var/obj/BS = new/obj/BSEnter(locate(src.x,src.y,src.z))
			BS.dir=src.dir
			src.EnteredBlood-=1
			if(src.EnteredBlood<0)
				src.EnteredBlood=0
		*/

	//	world.log << "jashin4 [src.EnteredBlood]"

		if(!loc)
			for(var/obj/respawn_markers/respawn/R in gameLists["spawns"])
				if((!faction || (faction.village=="Missing"&&R.ind==0))||(faction.village=="Konoha"&&R.ind==1)||(faction.village=="Suna"&&R.ind==2)||(faction.village=="Kiri"&&R.ind==3))
					loc = R.loc
					break

		if(!new_loc || !canwalk)
			return 0
		if(justwalk)
			return ..()

		var/simple_move = 0
		if(istype(src,/mob/human/sandmonster)||istype(src,/mob/human/player/npc))
			if(icon_state=="D-funeral")
				return 0
			else
				simple_move = 1

		if(istype(src,/mob/spectator))
			density = 0
			icon = null
			simple_move = 1

		if(stunned || new_loc.density)
			return 0
		if(!simple_move)
			if(mole)
				if(curchakra > 40) //should be effected by efficiency, will come back to that
					curchakra -= 40
				else
					return 0

			//IsStuff(src,new_loc)

			if(Tank)
				for(var/mob/human/Xe in get_step(src,dir))
					if(Xe!=src && !Xe.ko && !Xe.IsProtected() && (Xe.client||istype(Xe,/mob/human/player/npc/kage_bunshin)||istype(Xe,/mob/human/player/npc/bunshin)/*||istype(Xe,/mob/human/player/npc/waterclone)*/))
						Xe = Xe.Replacement_Start(src)
						var/obj/t = new/obj(Xe.loc)
						t.icon='icons/gatesmack.dmi'
						flick("smack",t)
						spawn(10)
							t.loc = null

						Xe.Damage((src.str+src.strbuff-strneg)*rand(1,3)+400, 0, src, "Human Bullet Tank", "Normal")
						Xe.Hostile(src)

						if(!Xe.Tank)
							Xe.loc=locate(src.x,src.y,src.z)
							Xe.icon_state="Hurt"

						spawn()
							if(!Xe.Tank)
								Xe.Knockback(5,turn(src.dir, 180))
							else
								Xe.Knockback(5,src.dir)
							Xe.icon_state=""
							spawn(5) if(Xe) Xe.Replacement_End()
					else
						src.loc=locate(Xe.x,Xe.y,Xe.z)

/*			if(BoneRush)
				for(var/mob/human/Xe in get_step(src,dir))
					if(Xe!=src && !Xe.ko && !Xe.IsProtected() && (Xe.client||istype(Xe,/mob/human/player/npc/kage_bunshin)||istype(Xe,/mob/human/player/npc/bunshin)/*||istype(Xe,/mob/human/player/npc/waterclone)*/))
						Xe = Xe.Replacement_Start(src)
						var/obj/t = new/obj(Xe.loc)
						t.icon='icons/gatesmack.dmi'
						flick("smack",t)
						spawn(10)
							t.loc = null

						Xe.Damage((src.con+src.conbuff-conneg)*rand(1,3)+400, 0, src, "Bone Rush Attack", "Normal")
						Xe.Hostile(src)

						if(!Xe.BoneRush)
							Xe.loc=locate(src.x,src.y,src.z)
							Xe.icon_state="Hurt"

						spawn()
							if(!Xe.BoneRush)
								Xe.Knockback(5,turn(src.dir, 180))
							else
								Xe.Knockback(5,src.dir)
							Xe.icon_state=""
							spawn(5) if(Xe) Xe.Replacement_End()
					else
						src.loc=locate(Xe.x,Xe.y,Xe.z)*/

				if(movin)
					. = ..()
					src.Get_Global_Coords()
					return

				if(dirr==dir)
					new_loc = get_step(src, dir)
					if(new_loc && loc.Exit(src) && new_loc.Enter(src))
						loc.Exited(src)
						loc = new_loc
						src.Get_Global_Coords()
						new_loc.Entered(src)
					spawn(3)
						return 1

				else
					. = ..()
					src.Get_Global_Coords()
					return

			if(!movedrecently)
				movedrecently = min(10, movedrecently + 1)
		/*		movedrecently++
				if(movedrecently > 10)
					movedrecently = 10*/

			if(isguard)
				icon_state=""
				isguard=0

			if(madarasusano==1)
				src.overlays-=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)

			if(sasukesusano == 1)
				src.overlays-=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)

			if(itachisusano == 1)
				src.overlays-=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)
				//src.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
			if(ironmass == 1)
				src.overlays-=image('icons/magnetdef.dmi',pixel_x=-32,pixel_y=-32)

			if((!new_loc.icon && !istype(new_loc,/turf/warp) && !istype(new_loc,/turf/towerdoor)) || new_loc.type==/turf)
				return 0

			if(locate(/obj/Bonespire) in new_loc) for(var/obj/Bonespire/S in new_loc)
				if(S.causer==src)
					S.density=0
					spawn(2)
						if(S)
							S.density=1

			if(sleeping)
				sleeping = 0
				icon_state = ""

			if(length(carrying))
				for(var/mob/X in carrying)
					X.loc=src.loc

		. = ..()

		if(HasSkill(BLOOD_BIND))
			for(var/obj/undereffect/B in loc)
				if(B.uowner) Blood_Add(B.uowner)

		src.Get_Global_Coords()
		//if(!istype(src,/mob/human/player/npc))src.FilterTargets()

		/*

		if(!afteryou_cool)
			if(pk && prob(5) && (src.loc && !(istype(src.loc.loc,/area/dojo))))
				var/squadsize=pick(1,2,3,4)
				squadsize = min(squadsize, afteryou)
				afteryou_cool = 1
				afteryou -= squadsize
				spawn(30)
					var/lvl=1
					switch(MissionClass)
						if("D")
							lvl=limit(1,round(src.blevel * rand(0.4,1)),30)

						if("C")
							lvl=limit(1,round(src.blevel * rand(0.7,1.1)),60)

						if("B")
							lvl=limit(1,round(src.blevel * rand(0.8,1.2)),80)

						if("A")
							lvl=limit(1,round(src.blevel * rand(0.9,1.3)),100)

						if("S")
							lvl=max(1,round(src.blevel * rand(1,1.4)))

					//Ambush(src,lvl,squadsize)

				spawn(200)
					afteryou_cool=0
		*/
		for(var/area/XE in oview(src,0))
			if(!XE.pkzone)
				src.Hostile()

		if(istype(src,/mob/human/sandmonster)||istype(src,/mob/human/player/npc))
			canmove=0
			spawn(1)
				canmove=1
			return

		for(var/obj/caltrops/x in loc)
			if(istype(x))
				x:E(src)

		for(var/obj/trip/x in oview(1))
			if(istype(x))
				x:E(src)

		for(var/obj/trip2/x in oview(1))
			if(istype(x))
				x:E(src)
		/*
		if(src.EnteredBlood>0)
			var/obj/BS2 = new/obj/BSExit(locate(src.x,src.y,src.z))
			BS2.dir=src.dir
			src.EnteredBlood-=1
			if(src.EnteredBlood<0)
				src.EnteredBlood=0
		*/
		return


turf
	Entered(mob/human/H)
		..()
		if(!(istype(H,/mob/human)) || !H.client) return


		//src << "turf[src] IsWater:[Iswater(src)]"
		//Are they in water
		if(Iswater(src) && !H.mole)
			var/obj/water/sticky/stickywater = locate(/obj/water/sticky) in src
			if(stickywater)
				if(H == stickywater.owner) stickywater = null
				else H.Timed_Move_Stun(8,severity=4)

			if(H.chidori==1)
				var/obj/elec/path = locate(/obj/elec) in src
				if(!path)
					spawn()Electricity(src.x,src.y,src.z,30)

			if(H.clan == "Haku" && !stickywater)
				var/obj/haku_ice/ice = locate(/obj/haku_ice) in src
				if(!ice)
					new /obj/haku_ice(src)
			else
				var/drain_mult = 1
				if(stickywater) drain_mult = 10
				H.curchakra-=5*drain_mult
				if(H.curchakra <= 0)
					H.curstamina = 0
					H.curchakra = 0
					H.KO()
				else if(!H.waterlogged)
					H.waterlogged=1
					//H<<"water_turf_entered waterlogged: [H.waterlogged]"
					H.RecalculateStats()
				/*else if(H.curstamina>25)
					H.curstamina-=25*drain_mult
					if(!H.waterlogged)
						H.waterlogged=1
						H.RecalculateStats()*/

		//Are they in lava
		if(Islava(src) && !H.mole)
			H.Timed_Move_Stun(8)
			var/drain_mult = 50
			H.curstamina-=10*drain_mult
			if(H.curstamina <= 0)
				H.curstamina = 0
				H.KO()
			else if(!H.waterlogged)
				H.waterlogged=1
				//H<<"lava_turf_entered waterlogged: [H.waterlogged]"
				H.RecalculateStats()


		//Are they in elec
		if(Iselec(src) && !H.mole)
			if(!H.ko && H.icon_state != "hurt") H.icon_state = "hurt"
			H.Timed_Stun(10)

		//Are they in smoke
		if(Issmoke(src) && !H.mole)
			H.Timed_Move_Stun(20,severity=4)


		//Are they in mist
		if(Ismist(src) && !H.mole)
			if(H.hiddenmist)
				H.HideInMist()
			else
				H.UnHideInMist()
				H.Affirm_Icon()
				H.Load_Overlays()


		//Are they on a swamp
		if(Isswamp(src) && !H.mole)
			if(H.onswamp)
				H.cantshun=1
				H.SwampDmg()
			else
				H.cantshun=0
				H.onswamp=0
				H.Affirm_Icon()
				H.Load_Overlays()

		//Regular Turf Removes hiddenmist.
		if(H.hiddenmist && !Ismist(src))
			H.hiddenmist=0
			H.UnHideInMist()

		//Regular Turf Removes waterlogged.
		if(H.waterlogged && !Iswater(src))
			//H<<"turf_not_water removing waterlogged: [H.waterlogged]"
			H.waterlogged = 0
			H.RecalculateStats()

		//Regular Turf Removes battlefire.
		if(H.inbattlefire && !Isbattlefire(src))
			H.inbattlefire=0
			H.RecalculateStats()

client
	West()
		return 0

	East()
		return 0

	North()
		return 0

	South()
		return 0

	Southeast()
		return 0

	Northeast()
		return 0

	Southwest()
		return 0

	Northwest()
		return 0

mob
	verb
		jumpv()
			set name="Jump"
			set hidden = 1
			if(!usr.is_jumping || !usr.pk || !usr.stunned||!usr.handseal_stun||!usr.kstun||!usr.ko||!usr.Size||!usr.Tank||!usr.mole||!usr.skillusecool||!usr.Fly)
				usr.jump()

mob
	verb
		dash()
			set name="Dash"
			set hidden = 1
			if(!usr.is_dashing || !usr.is_jumping || !usr.pk || !usr.stunned||!usr.handseal_stun||!usr.kstun||!usr.ko||!usr.Size||!usr.Tank||!usr.mole||!usr.skillusecool||!usr.Fly)
				var/mob/etarget = usr.MainTarget()
				var/ei=7
				usr.is_dashing=1
				var/old_loc = src.loc
				if(etarget)
					while(etarget && ei>0)
						for(var/mob/human/o in get_step(usr,usr.dir))
							if(!o.ko&&!o.IsProtected())
								etarget=o
						ei--
						walk(usr,usr.dir,0,32)
						if(old_loc != src.loc)
							var/lightning/shadow_step/shadow_step = new(old_loc)
							shadow_step.dir = src.dir
						sleep(1)
						walk(usr,0)
					sleep(100)
					usr.is_dashing=0
				else
					while(ei>0)
						ei--
						walk(usr,usr.dir,0,32)
						if(old_loc != src.loc)
							var/lightning/shadow_step/shadow_step = new(old_loc)
							shadow_step.dir = src.dir
						sleep(1)
						walk(usr,0)
					sleep(100)
					usr.is_dashing=0

mob
	verb
		interactv()
			set name="Interact"
			set hidden = 1

			//if(usr.inslymind==1)
			//	return

			if(usr.inmap == 1)
				usr.inmap = 0

			if(usr.spectate && usr.client)
				usr.spectate=0
				usr.client.eye=usr.client.mob
			//	src.hidestat=0
				if(usr.halfb==1)
					usr.client.screen += new /obj/black2
				if(usr.shopping)
					usr.shopping=0
					usr.canmove=1
					usr.see_invisible=0
				return
			if(usr.camo)
				usr.camo=0
				usr.Affirm_Icon()
				usr.Load_Overlays()
			if(usr.lastwitnessing &&( usr.sharingan || usr.impsharingan) && usr:HasSkill(SHARINGAN_COPY))
				var/skill/uchiha/sharingan_copy/copy = usr:GetSkill(SHARINGAN_COPY)
				var/skill/copied = copy.CopySkill(usr.lastwitnessing)
				usr.combat("<b><font color=#faa21b>Copied [copied]!</b></font>")
				usr.lastwitnessing=0
				return
			if(usr.incombo)
				return


			if(src.hydrated==1)
				if(usr.hozuki==0)
					var/time=rand(3,4)
					usr << "Hydrification <br><font color=green>On</br>"
					usr.hozuki=1
					usr.usemove=1
					usr.Affirm_Icon()
					spawn()
						while(time > 0)
							usr.protected=100
							time--
							sleep(10)
							if(time <= 0)
								usr.hozuki=0
								usr.usemove=0
								usr.Affirm_Icon()
								usr << "Hydrification <br><font color=red>Off</br>"
								usr.protected=0
					return
				else
					usr << "Stop trying to spam this you noob!"
					return

			if(src.boil_active)
				if(src.boil_damage==6)
					src << "PH Balance = <font color=#FF0000>Two"
					src.boil_damage=5
				else if(src.boil_damage==5)
					src << "PH Balance = <font color=#F62217>Three"
					src.boil_damage=4
				else if(src.boil_damage==4)
					src << "PH Balance = <font color=#FF3300>Four"
					src.boil_damage=3
				else if(src.boil_damage==3)
					src << "PH Balance = <font color=#FF6600>Five"
					src.boil_damage=2
				else if(src.boil_damage==2)
					src << "PH Balance = <font color=#FF6633>Six"
					src.boil_damage=1
				else if(src.boil_damage==1)
					src << "PH Balance = <font color=#C80000>One"
					src.boil_damage=6

			if(usr.c4)
				usr.c4 = 0
				var/hit=(5 + 230*usr.con/50)*3
				for(var/mob/human/player/x in infectedby)
					if(!x.ko && !istype(x,/mob/corpse))
						spawn()explosion(hit,x.x,x.y,x.z,usr,0,6)
						spawn()explosion(hit,x.x,x.y,x.z,usr,0,6)
						infectedby.Remove(x)
						x.Hostile(usr)
						return

			if(((usr.usedelay>0&&usr.pk)||(usr.stunned&&!usr.controlmob)||handseal_stun||usr.paralysed)&&!usr.ko)
				return
			usr.usedelay++

			var/o=0
			var/inttype=0
			if(leading)
				leading.stop_following()
				return

			if(usr.controlmob || usr.tajuu)
				for(var/mob/human/player/npc/kage_bunshin/X in world)
					if(X.ownerkey==usr.key || X.owner==usr)
						var/dx=X.x
						var/dy=X.y
						var/dz=X.z
						if(usr && usr.client && usr.client.eye != usr.client.mob) usr.client.eye = usr.client.mob
						if(dx&&dy&&dz)
							if(!X:exploading)
								spawn()Poof(dx,dy,dz)
							else
								X:exploading=0
								spawn()explosion(rand(1000,2500),dx,dy,dz,usr)
								X.icon=0
								X.targetable=0
								X.invisibility=100
								X.density=0
								sleep(30)
						if(X)
							if(locate(X) in usr.pet)
								usr.pet-=X
							X.loc=null
						if(usr.client && usr.client.mob)
							usr.client.eye=usr.client.mob
							//src.hidestat=0
				usr.tajuu=0
				usr.RecalculateStats()
				usr.controlmob=0
			spawn(30)
				usr.Respawn()
			for(var/obj/interactable/oxe in oview(1))
				oxe:Interact()
				return

			if(usr.henged)
				usr.name=usr.realname
				usr.henged=0
				usr.mouse_over_pointer=faction_mouse[usr.faction.mouse_icon]
				Poof(usr.x,usr.y,usr.z)
				usr:CreateName(255, 255, 255)
				usr.Affirm_Icon()
				usr.Load_Overlays()

			for(var/turf/warp/w in oview(1))
				if(w.requires_owner)
					w:Owner()

			for(var/mob/human/npc/x in ohearers(1))
				if(x == usr.MainTarget())
					o=1
					inttype=x.interact
				if(o)
					if(inttype=="Talk")
						x:Talk()
					if(inttype=="Shop")
						x:Shop()
					if(inttype=="Doctor")
						x:Heal()
					if(inttype=="Faction")
						x:Faction()

			for(var/mob/human/player/npc/x in ohearers(1))
				if(x == usr.MainTarget())
					o=1
					inttype=x.interact
					if(x.MainTarget()&& !usr.Missionstatus)
						o=0
				if(o)
					if(inttype=="Talk")
						x:Talk()
					if(inttype=="Shop")
						x:Shop()

			for(var/mob/human/Puppet/p in ohearers(1))
				if(Puppet1 && !Primary)
					Primary = Puppet1
					walk(Primary, 0)
					client.eye = Puppet1
					return
				else if(Puppet2 && Puppet2 != Primary)
					if(!Puppet1 || Puppet1 == Primary)
						Primary = Puppet2
						walk(Primary, 0)
						client.eye = Puppet2
						return
			if(Primary && (Puppet1 || Puppet2))
				Primary = 0
				client.eye =  client.mob
				return

			if(!usr.MainTarget())
				for(var/obj/explosive_tag/U in oview(0,usr))
					usr.Tag_Interact(U)
					return
				var/new_target
				for(var/mob/human/M in ohearers(2, usr))
					if(!M.mole)
						if(!new_target)
							new_target = M
						if(get_dist(M, usr) < get_dist(usr, new_target))
							new_target = M
				if(new_target) usr.AddTarget(new_target, active=1)
				return

mob/proc/Blood_Add(mob/V)
	if(V)
		if(!bloodrem.Find(V))
			bloodrem+=V
			//world<<"Adding [V.name] to blood list"
			spawn(600+world.tick_lag) //Spawn Tick Changes
				bloodrem-=V

		//else
			//world<<"[V.name] already in blood list"



mob
	proc
		Imortality_Time(time)
			src.immortality=1
			spawn()
				while(time > 0)
					--time
					sleep(1)
				src.immortality=0

		BubbleDrain()
			src.drowning=1
			spawn()
				while(drownA > 0 || drownD > 0 ||  drownF > 0)
					src.curstamina-=300
					sleep(1)
				src.drowning=0
				src.overlays-=image('drowning_bubble.dmi')


		ChakraDrains()
			if(src.sharingan == 1)
				src.chakradrain=3
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && sharingan == 1)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan == 2)
				src.chakradrain=6
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && src.sharingan == 2)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan == 3)
				src.chakradrain=12
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && src.sharingan == 3)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan == 4)
				src.chakradrain=16
				spawn()
					while(((src.curchakra > 0 && src.curchakra >= src.chakradrain) || (src.curstamina > 0 && src.curstamina >= src.stamdrain))  && src.sharingan == 4)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan >= 5)
				src.chakradrain=20
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && src.sharingan >= 5)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.impsharingan == 1 || src.impbyakugan == 1)
				src.chakradrain=18
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && (src.impsharingan == 1 || src.impbyakugan == 1))
						src.curchakra-=chakradrain
						sleep(50)
					src.impsharingan = 0
					src.impbyakugan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.shukaku == 1 || src.nibi == 1 || src.sanbi == 1 || src.yonbi == 1 || src.gobi == 1 || src.rokubi == 1 || src.shichibi == 1 || src.hachibi == 1 || src.kyuubi == 1)
				src.chakradrain=50
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && (src.shukaku == 1 || src.nibi == 1 || src.sanbi == 1 || src.yonbi == 1 || src.gobi == 1 || src.rokubi == 1 || src.shichibi == 1 || src.hachibi == 1 || src.kyuubi == 1))
						src.curchakra-=chakradrain
						sleep(50)
					src.shukaku=0
					src.nibi=0
					src.sanbi=0
					src.yonbi=0
					src.gobi=0
					src.rokubi=0
					src.shichibi=0
					src.hachibi=0
					src.kyuubi=0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.scorch_modo == 1)
				src.chakradrain=50
				spawn()
					while(src.curchakra > 50 && src.scorch_modo == 1)
						src.curchakra-=chakradrain
						for(var/mob/human/player/U in oview(1,src))
							var/con_mod=src.con+src.conbuff-src.conneg/150
							U.curstamina-=80*con_mod
							sleep(50)


/*		Clash_Timer(time)
			spawn()
				while(time > 0)
					--time
					sleep(10)
				src.taiclash=0*/

		Kyuubi_Regen()
			if(src.chambered || src.IsProtected() || !src.kyuubi) return
			src.kyuubi=1
			spawn()
				while(src.curwound > 0)
					src.curwound-=2
					sleep(10)



mob/var/tmp/protectendall = 0
mob/proc
	Protect(protect_time as num)
		protected++
		spawn()
			while(protect_time > 0)
				if(protectendall)
					protectendall = max(0, --protectendall)
					//--protectendall
				//	if(protectendall < 0) protectendall = 0
					break

				protect_time--
				sleep(1)
			protected = max(0, --protected)
			if(bdome==1)
				bdome=0
				overlays-='bubble_dome.dmi'
			//if(protected < 0) protected = 0

	End_Protect()
		if(protected > 0)
			protectendall = protected
			protected = 0

	IsProtected() //Proc to consolidate some protect stuff so that the code doesn't need to be littered with similar vars. (Mainly for puppet shield though)
		if(protected || mole)
			return 1
		for(var/obj/Shield/s in oview(1,src))
			if(istype(src, /mob/human/Puppet))
				if(src == s.owner)
					return 1
			if(istype(src, /mob/human/player))
				if(Puppet1)
					if(Puppet1 == s.owner)
						return 1
				else if(Puppet2)
					if(Puppet2 == s.owner)
						return 1
		return 0

mob/var/pill=0
mob/var/combo=0

mob/human/npc/Damage()
	return

mob
	proc
		Damage(stamina_dmg, wound_dmg, mob/human/attacker, source, class)
			if(auto_ez) //ez system
				src.auto_ez=0
				src.overlays-='icons/leech.dmi'
				src << "You've stopped Ezing, you gained a total of [auto_ez_total] experience."

			if(ko || (!pk && !istype(src,/mob/human/Puppet)) || mole) return

			if(istype(attacker, /mob/human/player/npc/kage_bunshin))
				stamina_dmg /= 4
				wound_dmg /= 4

			if(attacker && attacker != src)
				lasthostile = attacker.key

				if(src.using_crow)
					//M.using_crow = 0
					src.Protect(25)

					flick("Form", src)

					sleep(10)

					if(!attacker|| !src) return

					src.AppearBehind(attacker)

					flick("Reform", src)
					return

			var/piercing_stamina_dmg = 0
			if(source == "Taijutsu" && attacker && attacker.skillspassive[PIERCING_STRIKE])
				piercing_stamina_dmg = round(stamina_dmg * (attacker.skillspassive[PIERCING_STRIKE] * 0.02))
				stamina_dmg += piercing_stamina_dmg
			/*	piercing_stamina_dmg = round(stamina_dmg * 3 * attacker.skillspassive[PIERCING_STRIKE] / 100)
				stamina_dmg -= piercing_stamina_dmg*/

			var/deflection_stamina_dmg = 0
			var/ironskin_stamina_dmg = 0
			if(class != "Internal")
				if(IsProtected() || kaiten) return

				if(class == "Normal")
					if(length(pet) && loc)
						var/mob/human/sandmonster/S = locate() in (pet & loc.contents)
						if(S)
							flick("hurt", S)
							--S.hp
							if(S.hp <= 0)
								S.loc = null
							return

				if(clan == "Sand Control")
					if(sanddenfence >= 1)
						sanddenfence = 0
						for(var/obj/sandprotection/shield in src.overlays)
							flick("[src.dir]", shield)
						sleep(5)
						sanddenfence = 1
						return




				if(gaaramass && !chambered)
					protected=1
					overlays+=image("Sand_protect.dmi")
					sleep(6)
					overlays-=image("Sand_protect.dmi")
					if(stamina_dmg<=500)
						gaaramass-=1
					else if(stamina_dmg<=1000)
						gaaramass-=2
					else if(stamina_dmg<=1500)
						gaaramass-=3
					else if(stamina_dmg<=2000)
						gaaramass-=4
					else if(stamina_dmg<=2500)
						gaaramass-=5
					else if(stamina_dmg<=3000)
						gaaramass-=6
					else if(stamina_dmg<=3500)
						gaaramass-=7
					else if(stamina_dmg<=4000)
						gaaramass-=8
					else if(stamina_dmg<=4500)
						gaaramass-=9
					else if(stamina_dmg<=5000)
						gaaramass-=10
						world.log<<"-10"
						if(gaaramass <= 0)
							gaaramass = 0
							protected=0
							for(var/sand/gaara_mass/G in oview(5, usr))
								if(G.owner == src)
									del G
							var/skill/SB = GetSkill(SAND_SUMMON)
							for(var/skillcard/card in SB.skillcards)
								card.overlays -= 'icons/dull.dmi'
							spawn() SB.DoCooldown(src)
						return

					if(sandarmor && !chambered)
						--sandarmor
						if(sandarmor == 0)
							var/skill/SA = GetSkill(SAND_ARMOR)
							for(var/skillcard/card in SA.skillcards)
								card.overlays -= 'icons/dull.dmi'
							spawn() SA.DoCooldown(src)
						return


					if(sandarmor && !chambered)
						if(stamina_dmg<300)
							return
						if(stamina_dmg>=300)
							--sandarmor
							if(sandarmor == 0)
								var/skill/SA = GetSkill(SAND_ARMOR)
								for(var/skillcard/card in SA.skillcards)
									card.overlays -= 'icons/dull.dmi'
								spawn() SA.DoCooldown(src)
							return

				if(locate(/obj/Shield) in orange(1, src))
					return

				if(chambered)
					var/damage = stamina_dmg + wound_dmg*100
					chambered -= damage
					if(chambered < 0) chambered = 0

					if(chambered)
						combat("<font color=#eca940>The doton chamber took [damage] from [attacker]!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to the doton chamber!")
						return
					else
						combat("<font color=#eca940>The doton chamber took [damage] from [attacker] and it crumbled!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to the doton chamber and it crumbled!")
						for(var/obj/earthcage/o in view(0,src))
							o.icon_state = "Crumble"
							o.crumbled = 1
							return

				if(DefenceSusanoo)
					var/damage = stamina_dmg + wound_dmg*100
					DefenceSusanoo -= damage
					if(DefenceSusanoo < 0) DefenceSusanoo = 0

					if(DefenceSusanoo)
						combat("<font color=#eca940>Susanoo took [damage] from [attacker]!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to Susanoo!")
						return
					else
						combat("<font color=#eca940>Susanoo took [damage] from [attacker] and it broke!")
						if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [damage] to Susanoo and it broke!")
						InSusanoo = 0
						return

				if(attacker && attacker.skillspassive[BLINDSIDE] && attacker != src && attacker.squad != src.squad && source != "Rend" && !byakugan && !impbyakugan && !istype(src,/mob/human/Puppet) && !istype(attacker,/mob/human/Puppet))
					FilterTargets()
					if(!(attacker in active_targets))
						if(attacker in targets)
							piercing_stamina_dmg *= (1 + 0.05*attacker.skillspassive[BLINDSIDE])
							stamina_dmg *= (1 + 0.05*attacker.skillspassive[BLINDSIDE])
							wound_dmg *= (1 + 0.05*attacker.skillspassive[BLINDSIDE])
						else
							piercing_stamina_dmg *= (1 + 0.10*attacker.skillspassive[BLINDSIDE])
							stamina_dmg *= (1 + 0.10*attacker.skillspassive[BLINDSIDE])
							wound_dmg *= (1 + 0.10*attacker.skillspassive[BLINDSIDE])

				if(boneharden)
					// TODO: Real math rather than these for loops
					while(curchakra > 0 && stamina_dmg > 0)
						--curchakra
						stamina_dmg -= 3
					stamina_dmg = max(0, stamina_dmg)

					while(curchakra >= 30 && wound_dmg >= 1)
						curchakra -= 30
						--wound_dmg
					wound_dmg = max(0, wound_dmg)

				if(pill == 3)
					if(stamina_dmg > 2) stamina_dmg *= 0.7
					wound_dmg *= 0.8


				if(Size == 1)
					if(stamina_dmg > 2) stamina_dmg *= 1.5
					if(wound_dmg > 2) wound_dmg *= 1.5
					wound_dmg = min(wound_dmg, 20)

				if(Size == 2)
					if(stamina_dmg > 2) stamina_dmg *= 2
					if(wound_dmg > 2) wound_dmg *= 2
					wound_dmg = min(wound_dmg, 20)

				if(gate >= 4)
					stamina_dmg *= 1.5

				if(human_puppet == 2)
					stamina_dmg *= 0.7


				if(Tank)
					wound_dmg = min(wound_dmg, 10)

				if(isguard)
					stamina_dmg /= 2
					stamina_dmg -= (stamina_dmg * 0.01 * skillspassive[9])

				if(madarasusano==1 && isguard)
					stamina_dmg *= 0.75

				if(sasukesusano == 1 && isguard)
					stamina_dmg *= 0.75

				if(itachisusano == 1 && isguard)
					stamina_dmg *= 0.75

				if(ironmass == 1 && isguard)
					stamina_dmg *= 0.85

				if((locate(/obj/Shield) in oview(1,src)))// && !internal)
					return

				if(clan == "Battle Conditioned")
					stamina_dmg *= 0.8
					if(class == "Normal") wound_dmg *= 0.85

				if(clan == "Jashin")
					wound_dmg = min(wound_dmg, 100)

				if(src.crystal_armor)//&&!xpierce)
					stamina_dmg *= 0.8
					flick('icons/crystal_break.dmi',x)
				if(paper_armor)// && !xpierce)
					stamina_dmg *= 0.8
				if(lightning_armor>1)// && !xpierce)
					stamina_dmg *= 0.7
				if(shukaku==1||nibi==1||yonbi==1||sanbi==1||gobi==1||rokubi==1||shichibi==1||hachibi==1||kyuubi==1)
					stamina_dmg *= 0.7

			/*	if(src.spacetimebarrier&&!xpierce&&!internal)
					if(!attacker||!src) return
					var/obj/space/f = new/obj/space(src.loc)
					spawn(20) del(f)
					var/X=rand(1,5)
					var/V=pick(1,2)
					switch(V)
						if(1)
							if(attacker)
								attacker.loc = (locate(src.x+X,src.y+X,src.z))
								flick('icons/space1.dmi',attacker)
								attacker.Facedir(src)
							else return
						if(2)
							if(attacker)
								attacker.loc = (locate(src.x-X,src.y-X,src.z))
								flick('icons/space1.dmi',attacker)
								attacker.Facedir(src)
							else return
					var/mob/F = attacker
					F.stunned=rand(3,4)
					src.spacetimebarrier=0
					return*/

				if(src.petals)
					flick('icons/petals.dmi',src)
					sleep(3)
					src.AppearBehind(attacker)
					if(attacker)attacker.RemoveTarget(src)
					return

				if(controlling_yamanaka&&usr)
					if(usr)
						var/mob/Mind_Contract=src.Transfered
						if(Mind_Contract)
							Mind_Contract.Wound(x+3,3,usr,1)
							if(Mind_Contract)
								Mind_Contract.Hostile(usr)
							if(Mind_Contract)
								Mind_Contract.combat("You've taken Wound damage from [usr]")
								combat("As a result of attempting to hurt [Mind_Contract] has given you [x] wound damage as well")


				if(class == "Normal")

					var/distance = get_dist(src, attacker)
					if(istype(attacker,/mob/human/player))
						if(attacker.papermode==1 && (distance >= 0 && distance <2))
							if(rand(0,100) < 6)
								flick('icons/paper bind.dmi',src)
								src.Begin_Stun()
								src.overlays+='paper_bind2.dmi'
								spawn(20)
									src.overlays-='paper_bind2.dmi'
									src.End_Stun()

					if(immortality==1)
						stamina_dmg -= stamina_dmg
						wound_dmg -= wound_dmg

					if(istype(attacker,/mob/human/player))
						if((war && !attacker.war) || (!war && attacker.war))
							stamina_dmg -= stamina_dmg
							wound_dmg -= wound_dmg

						if(attacker.shuned==1)
							stamina_dmg /= 2
							wound_dmg /= 2

						if(attacker.sanbi==1)
							var/PO = rand(50, usr.con/2)
							src.curchakra -= PO
							attacker.curchakra += PO * 0.80

						if(attacker.shichibi==1)
							src.Poison+=rand(4,8)

					if(ironskin)
						stamina_dmg /= 2
						//ironskin_stamina_dmg = wound_dmg * 100
						wound_dmg = 0

					if(wound_dmg)
						var/effective_armor = AC / 100
						if(isguard)
							effective_armor = 1
						effective_armor = max(0, min(effective_armor, 1))

						var/min_dmg = (effective_armor >= 1)?(1):(0) //(0):(1)
						wound_dmg = max(min_dmg, wound_dmg * (1-effective_armor) + wound_dmg * effective_armor * (100/(str+strbuff-strneg)))

				if(skillspassive[DEFLECTION])
					var/checked_wounds = 0

					while(checked_wounds < wound_dmg && (deflection_stamina_dmg + 100) < curstamina)
						++checked_wounds
						if(prob(3*skillspassive[DEFLECTION]))
							--wound_dmg
							deflection_stamina_dmg += 100

			var/total_stamina_dmg = max(0, round(stamina_dmg + piercing_stamina_dmg + deflection_stamina_dmg + ironskin_stamina_dmg))
			var/stamina_msg = ""
			if(total_stamina_dmg > 0)
				var/detailed_stamina_msg = ""

				if(piercing_stamina_dmg || deflection_stamina_dmg || ironskin_stamina_dmg)
					detailed_stamina_msg = " ([stamina_dmg]"
					if(piercing_stamina_dmg)
						detailed_stamina_msg += " + [piercing_stamina_dmg] piercing"
					if(deflection_stamina_dmg)
						detailed_stamina_msg += " + [deflection_stamina_dmg] deflection"
					if(ironskin_stamina_dmg)
						if(ironskin == 1)
							detailed_stamina_msg += " + [ironskin_stamina_dmg] Iron Skin"
						else if(ironskin == 2)
							detailed_stamina_msg += " + [ironskin_stamina_dmg] Larch Dance"
					detailed_stamina_msg += ")"

				stamina_msg = "[total_stamina_dmg][detailed_stamina_msg] stamina damage"

			wound_dmg = max(0, round(wound_dmg))
			var/wound_msg = ""
			if(wound_dmg > 0)
				// TODO: Why is this proc (Damage)  not implemented on /mob/human anyway...
				if(istype(src, /mob/human) && src:HasSkill(MASOCHISM))
					var/Rlim=round(rfx/2.5)-rfxbuff
					var/Slim=round(str/2.5)-strbuff
					if(Rlim<0)
						Rlim=0
					if(Slim<0)
						Slim=0
					var/R=round(rfx/10)
					var/S=round(str/10)
					if(R>Rlim)
						R=Rlim
					if(S>Slim)
						S=Slim
					rfxbuff+=R
					strbuff+=S
					spawn(200)
						rfxbuff-=R
						strbuff-=S
						/*if(rfxbuff<=0)
							rfxbuff=0
						if(strbuff<=0)
							strbuff=0*/

				if(Contract && source != "Sorcery: Death-Ruling Possession Blood")
					var/obj/C = Contract
					if(loc == C.loc && Contract2)
						var/mob/F = Contract2
						wound_msg += " (Blood Contract => [F])"
						if(source == "Stab Self")
							F.Damage(150, wound_dmg, src, "Sorcery: Death-Ruling Possession Blood", "Internal")
						else
							F.Damage(0, wound_dmg, src, "Sorcery: Death-Ruling Possession Blood", "Internal")
						if(F) spawn() F.Hostile(usr)
				if(source == "Stab Self")//due to the wound cap change for jashins, I am making stab self do 8 wounds to the user and 10 wounds to the contract
					wound_dmg -= 2
				wound_msg = "[wound_dmg] wounds"

			var/join_msg = ""
			if(stamina_msg && wound_msg)
				join_msg = " and "

			if(source != "Gate Stress" && source != "Pill Stress") combat("<font color=#eca940>You took [stamina_msg][join_msg][wound_msg][attacker?" from [attacker]":""]!")
			if(attacker && attacker != src) attacker.combat("<font color=#14cb84>You dealt [stamina_msg][join_msg][wound_msg][attacker?" to [src]":""]!")

			if(istype(src,/mob/human/player/npc/creep) && (total_stamina_dmg||wound_dmg) && attacker && attacker.client)
				src:lasthurtme = attacker

			curstamina -= total_stamina_dmg
			curwound += wound_dmg

			if(curstamina <= 0 && source != "KO")
				spawn() KO()

			if(attacker && attacker.clan == "Ruthless")

				if(total_stamina_dmg < 250)//probably tai/low dmg
					if(prob(33)) //33% chance to boost
						attacker.adren += round(total_stamina_dmg / min(125,total_stamina_dmg)) + wound_dmg
						//attacker<<"Ruthy Boost+:[round(total_stamina_dmg / 100) + wound_dmg]"
				else
					attacker.adren += round(total_stamina_dmg / 250) + wound_dmg
					//attacker<<"Ruthy Boost+:[round(total_stamina_dmg / 250) + wound_dmg]"

				attacker.statBoost()

			//This should be handled by Hostile not by Damage. Removing, hopefully it doesn't break too many things. I'll fix it later if it does.
			//if(asleep)
			//	asleep = 0

		// TODO: These procs should be removed eventually. Just here for transitional purposes.
		Dec_Stam(x,xpierce,mob/attacker, hurtall,taijutsu, internal)
			Damage(x, 0, attacker, taijutsu?"Tajutsu":"Stamina", internal?"Internal":"Normal")

		Wound(x,xpierce, mob/attacker, reflected)
			Damage(0, x, attacker, reflected?"Sorcery: Death-Ruling Possession Blood":"Wound", (xpierce>=3)?"Internal":"Normal")
mob
	proc
		KO()
			if(curstamina > 0 && curchakra > 0) return
			if(ko) return
			if(!pk)
				curstamina = stamina
				curwound = 0

			else if(gate >= 2)
				Damage(0, rand(32, 37), null, "KO", "Internal")
				curstamina = stamina * ((maxwound - curwound) / maxwound)
				curchakra = max(round(chakra / 4), curchakra)



			else if(src.izanagi_active)
				src.curstamina=src.stamina
				src.curwound-=30
				if(src.curwound<0)
					src.curwound=0
				src.Begin_Stun()
				src.ko = 0
				src.curchakra=src.chakra
				viewers(src) << output ("<font color = white> [src]: Izanagi.....", "combat_output")
				src.izanagi_active=0
				sleep(10)
				flick("Danzou",src)
				src.invisibility = 100
				sleep(5)
				var/mob/human/player/x = usr.MainTarget()
				if(x)
					src.AppearBehind(x)
				else
					src.loc=locate(src.x+6,src.y+6,src.z)
				src.eye_collection-=1
				src.End_Stun()
			//	src << "You have [src.eye_collection] left"
				src.invisibility = 0
				src.halfb = 1
				src.client.screen += new /obj/black2
				return

			else
				if(src.pill)
					if(src.pill>=2)
						src.overlays-='icons/Chakra_Shroud.dmi'
					if(src.pill==3)
						src.overlays-='icons/Butterfly Aura.dmi'
						Damage(0, rand(150, 200), null, "KO", "Internal")
					src.conbuff=0
					src.strbuff=0
					src.pill=0
					src.combat("The effects from the pill(s) wore off.")


				if(src.adren > 0)
					src.adren = src.adren/2 //lose half boost on ko
					//src.strbuff = 0
					//src.conbuff = 0
					//src.rfxbuff = 0


				if(src.sage_mode)
					src.sage_mode = 0
					src.strbuff = 0
					src.conbuff = 0
					src.rfxbuff = 0
					src.naturechakra = 0

				if(src.human_puppet>=1)
					src.human_puppet = 0
					Affirm_Icon()

				if(src.sandfist >= 1)
					src.sandfist = 0
					src.special=0
					src.pixel_y-=32
					src.Fly = 0
					src.density = TRUE
					src.layer = 0
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "1", pixel_x = -32, pixel_y = -48)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "2", pixel_y = -48)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "3", pixel_x = 32, pixel_y = -48)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "4", pixel_x = -32, pixel_y = -16)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "5", pixel_y = -16)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "6", pixel_x = 32, pixel_y = -16)

				if(src.sharingan > 0)
					src.strbuff = 0
					src.conbuff = 0
					src.rfxbuff = 0
					src.intbuff = 0
					src.sharingan = 0
					src.Affirm_Icon()
					src.Load_Overlays()

				if(src.impbyakugan > 0)
					src.see_infrared = 0
					src.impbyakugan = 0
					src.Affirm_Icon()
					src.Load_Overlays()

				if(src.impsharingan > 0)
					src.strbuff = 0
					src.conbuff = 0
					src.rfxbuff = 0
					src.intbuff = 0
					src.impsharingan = 0
					src.Affirm_Icon()
					src.Load_Overlays()
					src.see_infrared = 0

				if(src.shukaku == 1 || src.nibi == 1 || src.sanbi == 1 || src.yonbi == 1 || src.gobi == 1 || src.rokubi == 1 || src.shichibi == 1 || src.hachibi == 1 || src.kyuubi == 1)
					src.shukaku=0
					src.nibi=0
					src.sanbi=0
					src.yonbi=0
					src.gobi=0
					src.rokubi=0
					src.shichibi=0
					src.hachibi=0
					src.kyuubi=0


				Poison = 0
				Damage(0, rand(32, 37), null, "KO", "Internal")
				curstamina=0
				stunned=1
				ko = 1
				//Dipic: Clear stuns on KO
			//	Reset_Stun()
			//	Reset_Move_Stun()

				sleep(10)

				flick("Knockout", src)

				icon_state = "Dead"
				layer = TURF_LAYER
				/*
				for(var/obj/items/Heavenscroll/II in contents)
					//world.log << "Dropped [II]"
					II.Drop()
				for(var/obj/items/Earthscroll/EI in contents)
					EI.Drop()
				*/
				for(var/obj/items/equipable/newsys/SAnbu_Armor/TS in contents)
					world.log << "Dropped [TS]"
					TS.Drop(src)

				// TODO: These vars are calculated and recalcualted all over the place, when they shouldn't even change much!
				var/maxwound1 = 100
				if(clan == "Will of Fire")
					maxwound1 = 130
				else if(clan == "Jashin")
					maxwound1=150
					if(immortality)
						maxwound1=300
				if(warlord==1)
					maxwound1 = maxwound1+15

				if(curwound < maxwound1 || (immortality && cexam != 5))
					sleep(curwound + 100)
					if(ko && curwound < 300)
						if(clan == "Will of Fire")
							curstamina = stamina
							if(curwound > 100)
								curstamina = stamina * 1.25
								curchakra = chakra * 1.25
						else
							curstamina = stamina * min(0.5, 1 - curwound / (2 * maxwound))
						if(curchakra < chakra / 5)
							curchakra = chakra / 5 + 20

					Protect(30)
					End_Stun()
					Reset_Stun()
					Reset_Move_Stun()
					ko = 0
					CombatFlag()
					icon_state = ""
				else
					Die()

		Die()

			if(inbattleroyale)
				inbattlefire=0
				inbattleroyale=0
				Reset_Stun()
				curwound = 0
				curstamina = stamina
				curchakra = chakra
				if(oldx && oldy && oldz)
					loc=locate(oldx, oldy, oldz)
					oldx = 0
					oldy = 0
					oldz = 0
				spawn() checkwinset() //let them watch

				var/Lobby/L = LobbyManager.GetLobbyByName("Battle Royale")
				if(L)
					L.lobby_info("[src] Has lost!")

					L.LPlayers-- //remove from the lobby LPlayers
					L.lobby_info("[L.lobby_name] Players left = [L.LPlayers]")

				return


			if(inarena)
				// TODO: CSS-ify this message
				if(!LobbyManager.Lobbies.len) world<<"<font color=Blue size= +1>[src] Has lost!</font>"
				inarena = 0
				Reset_Stun()
				curwound = 0
				curstamina = stamina
				curchakra = chakra
				// TODO: ...Just store the damn loc turf already.
				if(oldx && oldy && oldz)
					loc=locate(oldx, oldy, oldz)
					oldx = 0
					oldy = 0
					oldz = 0

			else if(dojo)
				// TODO: Need a better way of finding spawn points.
				// Perhaps a property on the dojo area...
				// Also, what does the 'ei' var DO?
				var/ei = 0
				var/dist = 1000
				var/obj/SPWN = new
				for(var/obj/respawn_markers/dojorespawn/Dj in gameLists["spawns"])
					if(Dj.z == z)
						if(get_dist(Dj, src) < dist)
							dist = get_dist(Dj, src)
							SPWN = Dj
				var/obj/respawn_markers/dojorespawn/Respawn = SPWN

				ei+=5
				if(Respawn)
					curwound = 0
					loc = locate(Respawn.x, Respawn.y, Respawn.z)
					// TODO: Yet more 'let's use the coordinates instead of .loc'. Also, why is it doing y-1?
					//loc = locate(Respawn.x, Respawn.y-1, Respawn.z)
				else
					curwound = 0
				spawn(10)
					Reset_Stun()
					curwound = 0
				curstamina = 1
				// TODO: CSS-ify this message
				src << "You were Defeated"

			else
				for(var/mob/human/Xe in ContractBy)
					if(Xe.Contract2 == src)
						if(Xe.Contract)
							Xe.Contract.loc = null
							Xe.Contract = null
						if(Xe.Contract2)
							Xe.Contract2.ContractBy -= Xe
							if(Xe.Contract2.ContractBy.len < 1)
								Xe.Contract2.ContractBy = null
							Xe.Contract2 = null
						Xe.Affirm_Icon()
				if(!RP)
					// TODO: CSS-ify this message. And make the message clearer. Also: "You're"
					src<<"You're wounded beyond your limit, to respawn at a hospital press Space. If you are not brought back to life in 60 seconds you'll automatically respawn."
					var/count=0

					var/obj/mapinfo/Minfo = locate("__mapinfo__[z]")
					if(Minfo && Minfo.in_war && faction && (faction.village == Minfo.village_control || faction.village == Minfo.attacking_village))
						Respawn()
					else
						// Does this really need to be a loop? I wonder if that 'event scheduler' library (or something similar) might be interesting
						// here to actually cancel it...
						// Come to think of it, there's a LOT of stuff in GOA that having a unified scheduler/ability to cancel things centrally would be nice.
						// So: TODO: Look into Stephen001's Event Scheduler, but probably end up making my own because it might not have the right features.
						while(curwound>=maxwound)
							//src.stunned=1000 //redundant since they should be KO'd at this point?
							count++
							if(count>60)
								src.Respawn()
								return
							sleep(10)
						curstamina = stamina/2

				else
					src<<"You're wounded beyond your limit, because this is a Role-Play server if your not revived by a medic within 5 minutes you'll die and have to wait till a new round to come back.(This takes hours, your best to log in to a Non-RP server)"
					var/count=0

					var/obj/mapinfo/Minfo = locate("__mapinfo__[z]")
					if(Minfo && Minfo.in_war && faction && (faction.village == Minfo.village_control || faction.village == Minfo.attacking_village))
						if(faction.village == Minfo.village_control)
							++Minfo.defender_deaths
						else if(faction.village == Minfo.attacking_village)
							++Minfo.attacker_deaths

					// This seems a rather pointless loop? Is being dead stopping other stuff that might refill stamina?
					// Mabye we should have a general 'Heal' proc for wounds that can handle un-KOing people. The full-dead mode should just set a var or something.
					while(curwound>=maxwound && count<=300)
						sleep(10)
						//src.stunned=1000 //redundant because they should be KO'd?
						count++
						src.icon_state="Dead"

					if(count>300)
						if(client) DeathList+=src.client.computer_id
						// TODO: CSS-ify this message.
						src << "You have Died!"
						if(Minfo) Minfo.PlayerLeft(src)
						new/mob/corpse(loc,src)
						verbs.Cut()
						verbs+=/mob/Admin/verb/Spectate
						if(client)
							winset(src, "observer_menu", "parent=menu;name=\"&Observer\"")
							winset(src, "observer_verb_spectate", "parent=observer_menu;name=\"&Spectate\";command=Spectate")
					else
						curstamina = stamina/2

mob
	proc
		/*relieve_bounty(mob/jerk)
			// What is this called by? I think it's just something in all this death stuff.
			// It's a bit wierd that this is the proc that actually prints death messages.
			// Also this way of detecting who actually killed you is kinda stupid, that info should be able to be passed down to here from the Damage that triggered it.
			// (With special cases for the login/death-avoid stuff farther up the chain)
			/*var/mob/jerk=0
			for(var/mob/ho in world)
				if(ho.client && ho.key == lasthostile)
					jerk = ho*/

			if(jerk && jerk != src)
				// Yay for all sorts of special cases for not having factions that should never happen -.-
				// I this this type of stuff is common enough I should just make a SameVillage() proc or something.
				if(!jerk.faction || !faction || (jerk.faction.village!=faction.village) || jerk.faction.village=="Missing")
					world << "<span class='death_info'><span class='name'>[realname]</span> has been killed by <span class='name'>[jerk.realname]</span>!</span>"
					// ...What's with this equation? Why round when it wouldn't be a decimal then not round after dividing?
					// Plus it basically amounts to (10/3) + blevel if you simplify it.
					jerk.bounty += round(10 + blevel * 3) / 3
					// I really hate how mission stuff is spread out all over the code.
					if(src == jerk.MissionTarget && jerk.MissionType == "Assasinate Player PvP")
						spawn() jerk.MissionComplete()
					if(src.faction && src.faction.village == jerk.TargetLocation && jerk.MissionType == "Assassinate Village PvP")
						jerk.MissionTargetCount--
						if(jerk.MissionTargetCount == 0) spawn() jerk.MissionComplete()
					if(jerk.faction && jerk.faction.village == "Missing")
						// TODO: CSS-ify this message.
						jerk << "You gained [bounty] ryo for [realname]'s bounty!"
						jerk.money += bounty
						bounty = 0
				else
					world << "<span class='death_info'><span class='betrayal'><span class='name'><b><u>[jerk.realname]</span> has killed <span class='name'>[realname]</span> and they are in the same village!</span></span>"
			else
				world << "<span class='death_info'><span class='name'>[realname]</span> has died!</span>"

*/

		relieve_bounty()
			var/mob/jerk=0
			for(var/mob/ho in world)
				if(ho.client)
					if(ho.key==src.lasthostile)
						jerk=ho

			if(jerk && jerk!=src)
				if(!jerk.faction || !src.faction || (jerk.faction.village!=src.faction.village)||jerk.faction.village=="Missing")
					world<<"<span class='death_info'><span class='name'>[src.realname]</span> has been killed by <span class='name'>[jerk.realname]</span>!</span>"
					jerk.bounty+=round(10+src.blevel*3)/3
					jerk.repgain(0.5,"Killing a player.")
					//var_dump(jerk)
					jerk.killedd++
					src.diedd++
					/*
					if(src==jerk.MissionTarget && jerk.MissionType=="Assasinate Player PvP")
						spawn()jerk.MissionComplete()
					if(jerk.clan=="Akimichi"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(PEPER_PILL))
							jerk.AddSkill(PEPER_PILL)
							jerk.RefreshSkillList()
					if(jerk.clan=="Puppeteer"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(HUMAN_PUPPET))
							jerk.AddSkill(HUMAN_PUPPET)
							jerk.RefreshSkillList()
					if(jerk.clan=="Sand Control"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(SAND_ATTACK))
							jerk.AddSkill(SAND_ATTACK)
							jerk.RefreshSkillList()
					if(jerk.clan=="Deidara"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(C4))
							jerk.AddSkill(C4)
							jerk.RefreshSkillList()
					if(jerk.clan=="Hyuuga"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(TWIN_LION))
							jerk.AddSkill(TWIN_LION)
							jerk.RefreshSkillList()
					if(jerk.clan=="Paper"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(PAPER_MODE))
							jerk.AddSkill(PAPER_MODE)
							jerk.RefreshSkillList()
					if(jerk.clan=="Haku"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(SUITON_BAKUSHOUHA))
							jerk.AddSkill(SUITON_BAKUSHOUHA)
							jerk.RefreshSkillList()
					if(jerk.clan=="Kaguya"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(BONE_FLOWER))
							jerk.AddSkill(BONE_FLOWER)
							jerk.RefreshSkillList()
					if(jerk.clan=="Jashin"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
						if(!jerk.HasSkill(IMMORTALITY))
							jerk.AddSkill(IMMORTALITY)
							jerk.RefreshSkillList()
					*/
					spawn()
						if(jerk.faction && jerk.faction.village=="Missing")
							jerk<<"You gained [src.bounty] dollars for [src.realname]'s bounty!"
							jerk.money+=src.bounty
							src.bounty=0
				else
					world<<"<span class='death_info'><span class='betrayal'><span class='name'><b><u>[jerk.realname]</span> has killed <span class='name'>[src.realname]</span> and they are in the same village!</span></span>"
					jerk.reploss(0.5,"Betrayed the village")
					jerk.killedd++
					src.diedd++
					/*
					if(jerk.clan=="Uchiha"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 2)
					//	world.log <<" Random = [RandomKills]"
						if(rand(0,100) < 11 && !jerk.HasSkill(ITACHI_MANGEKYOU) && !jerk.HasSkill(SASUKE_MANGEKYOU) && !jerk.HasSkill(MADARA_MANGEKYOU) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA) && !jerk.HasSkill(ITACHI_MANGEKYOU_V2))
							jerk.AddSkill(MADARA_MANGEKYOU)
							jerk.RefreshSkillList()
						else if(rand(0,100) < 31  && !jerk.HasSkill(SASUKE_MANGEKYOU) && !jerk.HasSkill(ITACHI_MANGEKYOU) && !jerk.HasSkill(MADARA_MANGEKYOU) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA) && !jerk.HasSkill(ITACHI_MANGEKYOU_V2))
							jerk.AddSkill(SASUKE_MANGEKYOU)
							jerk.RefreshSkillList()
						else if(rand(0,100) <= 100 && !jerk.HasSkill(ITACHI_MANGEKYOU) && !jerk.HasSkill(SASUKE_MANGEKYOU) && !jerk.HasSkill(MADARA_MANGEKYOU) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA) && !jerk.HasSkill(ITACHI_MANGEKYOU_V2))
							jerk.AddSkill(ITACHI_MANGEKYOU)
							jerk.RefreshSkillList()
					if(jerk.clan=="Uchiha"&&jerk.killedd>=RandomKills2 && jerk.rankgrade >= 4 && jerk.givensharingans >= 1)
					//	world.log <<" Random = [RandomKills2]"
						if(jerk.HasSkill(SASUKE_MANGEKYOU)&&!jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE))
							jerk.RemoveSkill(SASUKE_MANGEKYOU)
							jerk.AddSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE)
							jerk.RefreshSkillList()
						else if(jerk.HasSkill(MADARA_MANGEKYOU)&&!jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA))
							jerk.RemoveSkill(MADARA_MANGEKYOU)
							jerk.AddSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA)
							jerk.RefreshSkillList()
						else if(jerk.HasSkill(ITACHI_MANGEKYOU)&&!jerk.HasSkill(ITACHI_MANGEKYOU_V2))
							jerk.RemoveSkill(ITACHI_MANGEKYOU)
							jerk.AddSkill(ITACHI_MANGEKYOU_V2)
							jerk.RefreshSkillList()
					if(jerk.danzo && jerk.eye_collection<5 && src.clan == "Uchiha")
						jerk.eye_collection++
						jerk << "You now have [jerk.eye_collection] eyes"
					*/
			else
				world<<"<span class='death_info'><span class='name'>[src]</span> has died!</span>"

		Killed(mob/owned)
			// What calls this? It used to do some K/D tracking but I don't think it's used anymore.

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
				//RESPAWN
				killer = null
				for(var/mob/M in world)
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

		Hostile(mob/human/player/attacker)
			if(attacker && faction && attacker.faction && (faction.village != attacker.faction.village || faction.village == "Missing"))
				spawn() register_opponent(attacker)
				spawn() attacker.register_opponent(src)

			if(phenged)
				// There's a proc somewhere to unhenge people right? I know at least three places that do it...
				if(faction) mouse_over_pointer = faction_mouse[faction.mouse_icon]
				name = realname
				phenged = 0
				// TODO: Poof should REALLY just take a loc argument.
				spawn() Poof(x,y,z)
				overlays=0
				// Why is there a : here?
				src:CreateName(255, 255, 255)
				// And this. WTF. We DO have this whole 'rebuild icon' proc thing right? It's not even handling overlays for NPCs. (Not that any current NPC ever uses transform.)
				var/mob/example=new src.type()
				icon=example.icon
				example.loc = null

			if(using_crow)
				//using_crow = 0
				Protect(20)

				flick("Form", src)

				sleep(10)

				if(!src) return

				AppearBehind(attacker)

				flick("Reform", src)

			// Actually there's so much stuff in this proc I think we'd be better of with a full event-handler so we can just register a bunch
			// of separate callbacks as needed for things. Like these cancel-skill things.
			var/dont //Dipic: sloppy
			if(chambered)
				for(var/obj/earthcage/cage in loc)
					if(cage.owner == src)
						dont=1
			if(!dont) usemove = 0
			// Or this 'make an NPC stop following you' thing.
			if(leading)
				leading.stop_following()
				//leading.following = 0
				//leading = 0
			// And all these type-specific things.
			if(istype(src,/mob/human/player/npc))
				if(attacker && attacker!=src && attacker.faction && src.faction && attacker.faction.village != src.faction.village && !(attacker.MissionTarget==src && (attacker.MissionType=="Escort"||attacker.MissionType=="Escort PvP")))
					if(!istype(attacker,/mob/human/player/npc/creep) && !(istype(attacker, /mob/human/player/npc) && src:nisguard))
						spawn() src:AI_Target(attacker)
			// And... ANOTHER tranform revert? Huh. (What IS the difference... oh, phenged is puppet isn't it.)
			if(src.henged)
				henged = 0
				mouse_over_pointer = faction_mouse[faction.mouse_icon]
				name = realname
				spawn() Poof(x, y, z)
				src:CreateName(255, 255, 255)
				Affirm_Icon()
				Load_Overlays()

			// Also this sleeping thing.
			if(sleeping)
				// TODO: CSS-ify this message.
				combat("You were startled awake!")
				sleeping = 0

			// Yay checking types.
			if(istype(src,/mob/human/npc))
				return

			if(istype(src,/mob/human/sandmonster))
				var/mob/human/sandmonster/xi = src
				xi.hp--
				src.lasthostile = xi.ownerkey
				if(xi.hp <= 0)
					xi.loc = null
				return

			if(attacker && attacker != src && !ko && curstamina > 0)
				if(istype(attacker, /mob/human/player/npc/kage_bunshin))
					var/mob/human/player/npc/kage_bunshin/a = attacker
					src.lasthostile = a.ownerkey
				else
					src.lasthostile = attacker.key
					if(attacker.client)
						attacker.CombatFlag("offense")
			if(src && src.client)
				src.CombatFlag("defense")
			// Isn't asleep up farther?
			if(asleep)
				asleep = 0
				icon_state = ""

			on_hit.send(src, attacker)

			// ...Must...stop...repeating...village...checks...
			if(attacker && attacker.client && faction && attacker.faction && faction.village!=attacker.faction.village && !alertcool)
				alertcool = 180
				var/onit = 0
				var/list/options = new /list()
				for(var/turf/x in oview(8, src))
					if(!x.density)
						options += x

				if(length(options))
					spawn() for(var/mob/human/player/npc/OMG in world)
						if(!OMG.client && OMG.z==z && onit < 2)
							// TODO: I think this sleep should be a spawn or something. This loop must be really slow otherwise.
							// ...In fact, that slowness is probably the cause a bunch of the guard issues.
							sleep(200)
							if(OMG && attacker && OMG.z == attacker.z)
								var/turf/nextt = pick(options)
								options -= nextt
								if(OMG.nisguard && OMG.faction.village == faction.village && attacker && !(istype(attacker, /mob/human/player/npc) && attacker:nisguard))
									onit++
									OMG.AppearAt(nextt.x, nextt.y, nextt.z)
									spawn() OMG.AI_Target(attacker)
									if(get_dist(attacker, OMG) > 10)
										walk_to(OMG, attacker, 4, 1)

									spawn()
										var/eie = 0
										while(attacker && OMG && get_dist(attacker, OMG) > 20 && eie < 10)
											eie++
											step_to(OMG, src, 4)
											sleep(5)
										if(OMG)
											walk(OMG, 0)
										spawn() if(OMG && attacker) OMG.AI_Target(attacker)
										if(OMG && attacker && get_dist(attacker, OMG) > 10)
											if(OMG.z == attacker.z)
												OMG.AppearAt(attacker.x, attacker.y, attacker.z)

		CombatFlag(type)
			switch(type)
				if("offense")
					combatflago = world.time
				if("defense")
					combatflagd = world.time
				else
					combatflago = world.time
					combatflagd = world.time
		isCombatFlag(var/num=15, type)
			switch(type)
				if("offense")
					if(combatflago < world.time - num*10)
						return 0
				if("defense")
					if(combatflagd < world.time - num*10)
						return 0
				else
					if((combatflago < world.time - num*10) || (combatflagd < world.time - num*10))
						return 0
			return 1

obj
	skilltree
		// A bit of shared code here. I wonder if that can't be abstracted into something.
		Passive_C
			Click()
				usr.client.eye=locate_tag("maptag_skilltree_passive")
				usr.spectate = 1
			//	usr.hidestat = 0
				for(var/obj/gui/passives/gauge/Q in gameLists["passives"])
					if(Q.pindex == POINTS_STRENGTH || Q.pindex == POINTS_REFLEX || Q.pindex == POINTS_INTELLIGENCE || Q.pindex == POINTS_CONTROL)
						var/client/C = usr.client
						if(C) C.Passive_Refresh(Q)
		Nonclan_C
			Click()
				usr.client.eye = locate_tag("maptag_skilltree_nonclan")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:refreshskills()
		Nonclan2_C
			Click()
				usr.client.eye = locate_tag("maptag_skilltree_nonclan2")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:refreshskills()
		Clan_C
			Click()
				usr.client.eye = locate_tag("maptag_skilltree_clan")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:refreshskills()

mob/human/player
	verb
		check_skill_tree()
			if(!usr.controlmob)
				usr.client.eye = locate_tag("maptag_skilltree_select")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:Refresh_Stat_Screen()
var
	// What is this var for?
	fourpointo = 1
mob
	var
		// 'c' and 'cc' need better names.
		c = 0
		cc = 0
		isguard = 0
		dzed = 0

mob
	proc/Graphiked(icon/I, xoffset, yoffset)
		var/image/O = image(I,src, pixel_x = xoffset, pixel_y = yoffset)
		world << O
		sleep(1)
		var/time = 0
		var/time_limit = 5
		while(time < time_limit)
			O.pixel_y += 2
			sleep(1)
			time++
		O.loc = null

	proc/Combo(mob/M,r)
		// I wonder if there's any way to really simplify this. It's a pretty big proc.
		M = M.Replacement_Start(src)
		if(skillspassive[COMBO] && combo < (1 + skillspassive[COMBO]))
			combo++
			var/C = combo
			spawn(50)
				if(combo == C)
					combo = 0
		if(M && src)

			if(M.using_crow)
				//M.using_crow = 0
				M.Protect(25)

				flick("Form", M)

				sleep(10)

				if(!M || !src) return

				M.AppearBehind(src)

				flick("Reform", M)

			var/boom=0
			if(sakpunch2 || Size || Partial || gobi || madarasusano==1)
				sakpunch2 = 0
				boom = 1
			var/blk = 0

			spawn() if(M) M.Hostile(src)

			if(scalpol)
				if(M.IsProtected())
					return
				else
					if(!M.icon_state)
						flick("hurt",M)

				var/critchan2 = min(scalpoltime / 5 * rand(2, 5), 50)
				scalpoltime = 0

				var/critdamx
				var/wounddam


				var/skill/skill = GetSkill(MYSTICAL_PALM)
			/*
				var/chakracost = skill.ChakraCost(src)
				if(curchakra >= chakracost)
					curchakra -= chakracost
			*/
				if(prob(critchan2))
					// TODO: Having to explicitly deal with __buff and __neg vars everywhere is kinda annoying.
					// We need a better stat-alter system anyway that doesn't blow up when multiple things try to change it.

						//M.Earthquake(3)
						//critdam = ((con+conbuff+str+strbuff) * 2 + 200) * pick(0.6,0.8,1,1.2,1.4)
					critdamx = pick(skill.EstimateStaminaCritDamage(src))
					wounddam = pick(skill.EstimateWoundDamage(src))
					M.Damage(critdamx, wounddam, usr, "Medical: Chakra Scalpel", "Normal")
					if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 20
					// TODO: CSS-ify this message.
					combat("Critical hit [M] for [critdamx] Stamina damage and [wounddam] Wounds!")
					spawn() if(M) M.Graphiked('icons/critical.dmi', -6)
				else
					critdamx = pick(skill.EstimateStaminaDamage(src))
					wounddam = pick(skill.EstimateWoundDamage(src))
					M.Damage(critdamx, wounddam, usr, "Medical: Chakra Scalpel", "Normal")
					if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 2//1
					// TODO: CSS-ify this message.
					combat("Hit [M] for [critdamx] Stamina damage and [wounddam] Wounds!")

				scalpoltime = 0
				spawn(5) if(M) M.Replacement_End()
				return

			blk = (src in get_step(M, M.dir))

/*			if(M.isguard && (!src.taiclash || !M.taiclash) && (M == src.MainTarget() && src == M.MainTarget()))
			/*	etarget.Protect(10)
				M.Protect(10)*/
				M.startclash=1
				src.startclash=1
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				M.Knockback(3, src.dir)
				src.Knockback(3, M.dir)
				sleep(1)
				for(var/stepz = 1 to 3)
					var
						old_loc = src.loc
						old_loc2 = M.loc
					step(src,src.dir)
					step(M,M.dir)
					if(old_loc != src.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc)
						shadow_step.dir = src.dir
					if(old_loc2 != M.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc2)
						shadow_step.dir = M.dir
				var/obj/t = new/obj(src.loc)
				sleep(1)
				t.icon='icons/gatesmack.dmi'
				flick("smack",t)
				sleep(1)
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				sleep(10)
				src.taiclash = 1
				M.taiclash = 1
				src << "You have 3 seconds to press A to choose Rock, D to choose Paper or F to choose Scizor"
				M << "You have 3 seconds to press A to choose Rock, D to choose Paper or F to choose Scizor"
				sleep(30)
				if(src.PressAButton=="A" && M.PressAButton=="A" || src.PressAButton=="D" && M.PressAButton=="D" || src.PressAButton=="F" && M.PressAButton=="F" || !src.PressAButton && !M.PressAButton)
					src << "Draw"
					M << "Draw"
					flick("KickA-2",src)
					flick("KickA-2",M)
					M.Knockback(5, src.dir)
					src.Knockback(5, M.dir)
					src.Damage(rand(500),0,M,"Taijutsu Clash","Normal")
					M.Damage(rand(500),0,src,"Taijutsu Clash","Normal")
					sleep(1)
					src.Clash_Timer(60)
					M.Clash_Timer(60)
					src.taiclash = 0
					M.taiclash = 0
					M.startclash=0
					src.startclash=0
				if(src.PressAButton=="A" && M.PressAButton=="F" || src.PressAButton=="F" && M.PressAButton=="D" || src.PressAButton=="D" && M.PressAButton=="A" || !M.PressAButton)
					flick("KickA-2",src)
					M.Knockback(5, src.dir)
					src << "Win"
					M << "Lose"
					M.Damage(rand(1000,1500),0,src,"Taijutsu Clash","Normal")
					sleep(1)
					src.Clash_Timer(50)
					M.Clash_Timer(70)
					src.taiclash = 0
					M.taiclash = 0
					M.startclash=0
					src.startclash=0
				if(M.PressAButton=="A" && src.PressAButton=="F" || M.PressAButton=="F" && src.PressAButton=="D" || M.PressAButton=="D" && src.PressAButton=="A" || !src.PressAButton)
					flick("KickA-2",M)
					src.Knockback(5, M.dir)
					M << "Win"
					src << "Lose"
					src.Damage(rand(1000,1500),0,M,"Taijutsu Clash","Normal")
					sleep(1)
					src.Clash_Timer(70)
					M.Clash_Timer(50)
					src.taiclash = 0
					M.taiclash = 0
					M.startclash=0
					src.startclash=0
/*				else
					src << "Lose"
					M << "Win"*/
	//			M = get_steps(M, M.dir,3)
		//		src = get_steps(src, src.dir,3)
			//	get_steps(src,src.dir,3)
			//	src.icon_state="KickA-2"
			//	get_steps(M,M.dir,3)
			/*	if(src.dir==SOUTH)
					M.Knockback(3, EAST)
					src.Knockback(3, WEST)*/
*/



			if(M.isguard && blk && !boom)
				// TODO: CSS-ify this message.
				combat("[M] Blocked!")
				M.c--
				attackbreak += 10
				spawn(5)
					attackbreak -= 10
					if(attackbreak < 0) attackbreak = 0
				flick("hurt", src)

				M.icon_state=""
				M.isguard=0
				M.cantreact = 1
				spawn(15)
					M.cantreact = 0
				spawn(5) if(M) M.Replacement_End()
				return

			if(M.dodging >= rand(1,100))
				combat("[M] Dodged")
				M.c--
				spawn(5) if(M) M.Replacement_End()
				return

			// Ungh.
			usr = src

			if(!M.icon_state)
				flick("hurt", M)

			// Didn't I come up with something interesting relating to this in the movement stuff up farther? Need to go check that out again.
			var/xp = 0
			var/yp = 0
			if(M.x > x)
				xp=1
			if(M.x < x)
				xp=-1
			if(M.y > y)
				yp=1
			if(M.y < y)
				yp=-1
			pixel_x=4 * xp
			// Is this supposed to by pixel_y or _z? Not that it matters too much in GOA's topdown mode.
			pixel_y=4 * yp

			var/deltamove = 0
			var/critdam = 0
			var/critchan = 5
			var/tai_wounds = 0

			if(gentlefist)
				spawn()
				if(M)
					M.Chakrahit2()
					M.curchakra-=pick(3,6,9,12,15)
				if(prob(50))
					tai_wounds = pick(1,2)
				++M.gentle_fist_block
				M.RecalculateStats()
				spawn(100)
					if(M)
						--M.gentle_fist_block
						M.RecalculateStats()
			/*else
				spawn() smack(M,rand(-10,10),rand(-5,15)) wtf is this doing here??*/


			if(bonedrill)
				var/time=0
				var/go=0
				var/location=M.loc
				while(go<=6&&src&&M&&!M.ko&&M.loc==location)
					src.icon_state="Throw1"
					M.icon_state="hurt"
					time++
					if(time>5)
						go++
						if(M)
							M.Damage(50+50*src:ControlDamageMultiplier(),3,src)
							M.Wound(rand(0,1),1,src)
							M.movepenalty+=rand(2,5)
							if(prob(30)&&M)
								Blood2(M)
								M.Earthquake(5)
						time=0
					sleep(1)
				if(src)
					src.icon_state=""
				if(M)
					M.icon_state=""
				return

			if(tsupunch)
				var/skill/skill = GetSkill(CHAKRA_ENHANCEMENT)
				var/chakracost = skill.ChakraCost(src)
				if(curchakra >= chakracost)
					curchakra -= chakracost
					M.Earthquake(3)
					//critdam = ((con+conbuff+str+strbuff) * 2 + 200) * pick(0.6,0.8,1,1.2,1.4)
					critdam = pick(skill.EstimateStaminaDamage(src))
					M.Damage(critdam, tai_wounds, src, "Medical: Chakra Enhancement", "Normal")

					if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 5
					combat("Hit [M] for [critdam] damage with a chakra infused critical hit!!")
					spawn() M.Graphiked('icons/critical.dmi', -6)
					spawn() explosion3(50, M.x, M.y, M.z, src, 1)
					pixel_x = 0
					pixel_y = 0
					M.pixel_y = 0
					M.pixel_x = 0
					M.Knockback(rand(3,6), dir)
					spawn(5) if(M) M.Replacement_End()
					spawn()
						overlays+='icons/sakurapunch.dmi'
						sleep(5)
						overlays-='icons/sakurapunch.dmi'
					return
				else //not enough chakra, returning to regular taijutsu
					tsupunch = 0

			if(boom)
				M.Earthquake(5)
				var/tmp/setdmg=0
				critdam = round((con + conbuff + str + strbuff) * rand(1, 2)) + 800
				if(sakpunch==1)
					setdmg=1
					var/skill/skill = GetSkill(CHAKRA_TAI_RELEASE)
					critdam = pick(skill.EstimateStaminaDamage(src))
					//actually use the medic passive to calculate dam
				if(!setdmg && gobi==1)
					critdam = round((str + strbuff)*1.7 * rand(1.5, 2)) + 100
				if(!setdmg && Size == 1)
					critdam = round((str + strbuff) * rand(1, 1.5)) + 400
				if(!setdmg && Partial == 1)
					critdam = round((str + strbuff) * rand(2, 2.5)) + 400
				if(!setdmg && Size == 2)
					critdam = round((str + strbuff) * rand(2, 2.5)) + 400

				if(!setdmg && madarasusano==1)
					critdam = round((str + strbuff) * rand(1.5, 2)) + 300
					M.Damage(critdam, tai_wounds, src, Size?"[Size==2?"Super ":""]Size Multiplication":"Medical: Cherry Blossom Impact", "Normal")
			//	if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered)
				if(!Size || !Partial)
					// TODO: CSS-ify this message.
					combat("Hit [M] for [critdam] damage with a chakra infused critical hit!!")
				else
					// TODO: CSS-ify this message.
					combat("Hit [M] for [critdam] with your massive fist!!")
				spawn() if(M) M.Graphiked('icons/critical.dmi', -6)

				// More procs that should be taking loc instead of x/y/z...
				if(!Size) spawn() explosion3(50, M.x, M.y, M.z, src, 1)
				pixel_x = 0
				pixel_y = 0
				if(M)
					M.pixel_y = 0
					M.pixel_x = 0
				M.Knockback(rand(5, 10), dir)
				spawn(5) if(M) M.Replacement_End()
				return

			if(prob(critchan))
				//Critical..
				if(gate)
					critdam=round((str + strbuff) * rand(15, 20) / 15) * (1 + 0.10 * skillspassive[2])
				if(!gentlefist)
					critdam=round((str + strbuff) * rand(20, 25) / 15) * (1 + 0.10 * skillspassive[2])
				else
					critdam=round((con + conbuff) * rand(20, 25) / 15) * (1 + 0.10 * skillspassive[2])
				if(twinlion==1)
					critdam=round((((con + conbuff) + (str + strbuff) + (rfx + rfxbuff)) * rand(25, 30) / 10) * (1 + 0.10 * skillspassive[2])*10)

			//	if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 10
				// TODO: CSS-ify this message.
				combat("Critical hit!")
				spawn() if(M) M.Graphiked('icons/critical.dmi', -6)


			var/outcome = Roll_Against(rfx + rfxbuff - rfxneg, M.rfx + M.rfxbuff - M.rfxneg, rand(80, 120))
			var/damage_stat=0
			if(!gentlefist || !twinlion==1)
				damage_stat = str + strbuff - strneg + ( (rfx + rfxbuff - rfxneg)/2 )
			else
				if(twinlion)
					damage_stat = ((con + conbuff - conneg)+(str + strbuff - strneg)+(rfx + rfxbuff - rfxneg))*10
				else
					damage_stat = con + conbuff - conneg + ( (rfx + rfxbuff - rfxneg)/2 )

			// m is such a bad variable name.
			var/m = damage_stat / 200

			//if(gate >= 5) //Dipic: Why do we do this if they're also getting a str/rfx boost? Seems ridiculous. I'm going to disable this and see how it goes. Also reenabling combo for gates so that could get super crazy if this were to stay.
			//	m *= 1.5

			var/dam = 0

			/*
				Try to mathify this: This is pretty close other than deltamove at 3.
				The ?: in the damage is annoying but without it it wouldn't quite add up well without changing the range.
				deltamove += max(0, outcome - 3)
				M.c += max(2, 1 + 0.5 * outcome)
				dam = round(((outcome + 1) * 20 + (outcome>=3)?(10):(0)) * m)
			*/
			//new tai formulas from Max. Not sure about the deltamove and c though.
			switch(outcome)
				if(6,5)
					deltamove += 5//3
					M.c += 4
					dam = round(150 * m)
				if(5)
					deltamove += 4//3
					M.c += 4
					dam = round(150 * m)
				if(4)
					deltamove += 3//1
					M.c += 3
					dam = round(125 * m)
				if(3,2)
					deltamove += 2//1
					M.c += 2.5
					dam = round(100 * m)
				if(1,0)
					deltamove += 1//0
					M.c += 2
					dam = round(75 * m)
			/*old tai formulas
			switch(outcome)
				if(6)
					deltamove += 3
					M.c += 4
					dam = round(150 * m)
				if(5)
					deltamove += 2
					M.c += 3.5
					dam = round(130 * m)
				if(4)
					deltamove += 1
					M.c += 3
					dam = round(110*m)
				if(3)
					deltamove += 1
					M.c += 2.5
					dam = round(90 * m)
				if(2)
					M.c += 2
					dam = round(60 * m)
				if(1)
					M.c += 2
					dam = round(40 * m)
				if(0)
					M.c += 2
					dam = round(20 * m)
			*/

			if(M.c > 13)
				if(prob(10))
					spawn() if(M) M.Knockback(1, dir)
					spawn(1)
						step(src, dir)

			var/current_c = M.c
			spawn(30)
				if(M && M.c == current_c)
					M.c = 0

			if(combo)
				dam *= 1 + (2 * combo) / 30 //< Being a bit strange to avoid floating-point accuracy issues
			var/DD = dam + critdam

			M.Damage(DD, tai_wounds, usr, "Taijutsu", "Normal")

			/*for(var/mob/human/v in view(1))
				if(v.client)
					// TODO: CSS-ify this message.
					v.combat("[M] was hit for [DD] damage by [src]!")*/

			if((istype(src, /mob/human/player/npc/kage_bunshin)) || M.Tank) deltamove = 1
			if(!M.IsProtected()) M.movepenalty += deltamove
			var/dazeresist = 8 * skillspassive[9]

			if(M.c > 20 && !M.cc && !prob(dazeresist))//combo pwned!!
				if(!(istype(M, /mob/human/player/npc/kage_bunshin)) && !M.IsProtected())
					M.dzed = 1
					M.cc = 150
					spawn()
						sleep(10)
						while(M && M.cc)
							M.cc -= 10
							if(M.cc < 0) M.cc = 0
							sleep(10)
					M.icon_state = "hurt"
					var/dazed = 30
					dazed *= 1 + skillspassive[11] / 10 //< More floating-point accuracy
					M.Timed_Move_Stun(round(dazed, 0.1))

					spawn() if(M) M.Graphiked('icons/dazed.dmi')
					spawn() if(M) smack(M,0,0)
					// TODO: CSS-ify this message. + Maybe send one to M too
					combat("[M] is dazed!")
					M.combat("You are dazed!")
					spawn()
						while(M && M.move_stun)
							sleep(1)
						if(M)
							if(M.icon_state == "hurt") M.icon_state = ""
							M.dzed = 0
							M.c = 0

			sleep(3)
			pixel_x = 0
			pixel_y = 0
			if(M)
				M.pixel_y = 0
				M.pixel_x = 0
				M.Replacement_End()

mob/var/camo=0

mob/human
	proc
		attackv(mob/M)
			set name = "Attack"
			set hidden = 1

			if(taiclash)
				PressAButton="A"
				return

			if(drowning)
				drownA--
				return

			if(usr.stunned||usr.handseal_stun||usr.kstun||usr.ko||usr.Tank||usr.mole||usr.startclash)
				return
			else
				usr.CombatFlag("offense")

			var/weirdflick = 0
			if(controlmob)
				//.....-.- We should really just be calling controlmob.attackv() or something
				// Also kill whatever requires usr to change too.
				usr = controlmob
				src = controlmob
				weirdflick = 1

			if(src.Transfered||src.controlling_yamanaka)
				return

			if(camo)
				camo = 0
				Affirm_Icon()
				Load_Overlays()

			// I don't get the point of this, nothing calls combo() except for this right?
			// Why bother preparing the whole CTR-punch thing like this then?
			if(sakpunch)
				sakpunch = 0
				sakpunch2 = 1

			spawn(10)
				sakpunch2=0
				RecalculateStats()

			if(leading)
				leading.stop_following()
				return

			if(cantreact)
				return

			if(puppetsout == 2 && !Primary)
				if(Puppet2 in oview())
					var/mob/human/ptarget = usr.MainTarget()
					if(ptarget && !ptarget.ko) Puppet2.pwalk_towards(Puppet2,ptarget,2,20)
					Puppet2.Melee(usr)
					return
			var/mob/human/player/etarget = usr.NearestTarget()
			if(usr.Tree_Creation_Attack==1)
				if(etarget)
					for(var/obj/SenjuuTree/ST in view(usr,5))
						if(ST.OwnedBy==usr)
							var/STA = new/obj/SenjuuT/Attack(locate(ST.x,ST.y,ST.z))
							usr.TreesOut-=1
							del(ST)
							walk_towards(STA,etarget)
			if(usr.LavaBomb==1)
				usr.Lavas+=1
				usr.Wound(1,0,usr)
				var/LA = new/obj/Lava/Blast(locate(usr.x,usr.y,usr.z))
				LA:LavaOwner=usr
				LA:dir = usr.dir
				LA:LavaDamage=usr.con/2
				walk(LA,usr.dir)
				if(usr.Lavas>usr.LavasMax)
					usr.Lavas=0
					for(var/obj/Lava/Blast/B in world)
						del(B)
					for(var/obj/Lava/Area/AL in world)
						if(AL.LavaOwner==usr)
							spawn(rand(10,55))
								del(AL)

			if(usr.ironmass==1)
				etarget = usr.MainTarget()
				var/angle
				if(etarget) angle = get_real_angle(usr, etarget)
				else angle = dir2angle(usr.dir)

				if(usr.in_magnet_cd == 1) return

				spawn() advancedprojectile_angle('projectiles.dmi', "magnet-proj", usr, 64, angle, distance=7, damage=usr.str*2, wounds=rand(1,2))
				usr.in_magnet_cd = 1
				sleep(50)
				usr.in_magnet_cd = 0

			if(etarget)
				if(usr.Tree_Creation_Attack==1)
					if(usr.Can_Tree_Attack<=0)
						for(var/obj/SenjuuTree/F in view(usr,5))
							var/S = new/obj/SenjuuT/Attack(F.loc)
							S:Attacker=usr
							var/A = new/mob/WalkTo
							A:x=etarget.x
							A:y=etarget.y
							A:z=etarget.z
							walk_towards(S,A)
							spawn(15)
								del(A)

				if(usr.twinlion==2)
					spawn()
						var/eicon='New/lion_palm_explosion.dmi'
						var/estate=""
						var/strmult = usr.str+usr.con
						var/wounddam=rand(0.5,1)
						usr.Wound(wounddam, 0, usr)
						usr.curstamina-=100
						strmult+= usr.rfx
						var/ex=etarget.x
						var/ey=etarget.y
						var/ez=etarget.z
						var/mob/x=new/mob(locate(ex,ey,ez))

						projectile_to(eicon,estate,usr,x)
						del(x)
						for(etarget in hearers(2,x))
							spawn(2)
								etarget = etarget.Replacement_Start(usr)
								etarget.Damage(strmult/2,0,usr,"Twin Lions","Normal")
					//	spawn() AOE(ex, ey, ez, 1, (strmult/2), 50, usr, 0, 0)
						sleep(30)
/*						spawn() Fire(ex, ey, ez, 2, 50)
						spawn() FireAOE(ex, ey, ez, 2, (strmult/2), 50, usr, 3, 0)*/


			var/r = 0
			//var/sound

			if(src.butterfly_bombing)
				src.Chodan_Bakugeki()
				return

			// For that matter all these attack-override skills need better handling
			// It's a bit annoying to have to get into here or combo to do the hit logic.
			if(rasengan)
				// And a bit more specific to the rasengans: They all do the exact same thing except with different overlays and proc calls.
				if(!M && NearestTarget()) FaceTowards(NearestTarget())
				if(rasengan == 1)
					overlays -= /obj/rasengan
					overlays += /obj/rasengan2
			//		sleep(1)
					flick("PunchA-1", src)
					//sound = 'sounds/right_hook.wav'

					var/i = 0
					for(var/mob/human/o in get_step(src, dir))
						if(!o.ko && !o.IsProtected())
							i = 1
							if(rasengan == 1)
								Rasengan_Hit(o, src, dir)
					if(!i)
						Rasengan_Fail()
					return

			if(rasengan == 2)
				overlays -= /obj/oodamarasengan
				overlays += /obj/oodamarasengan2
		//		sleep(1)
				flick("PunchA-1", src)
				//sound = 'sounds/right_hook.wav'
				var/i = 0
				for(var/mob/human/o in get_step(src, dir))
					if(!o.ko && !o.IsProtected())
						i = 1
						if(rasengan == 2)
							ORasengan_Hit(o, src, dir)
				if(!i)
					ORasengan_Fail()
				return

			if(rasengan == 3)
				sleep(1)
				flick("PunchA-1", src)
				//sound = 'sounds/right_hook.wav'
				var/i = 0
				for(var/mob/human/o in get_step(src, dir))
					if(!o.ko && !o.IsProtected())
						i = 1
						if(rasengan == 3)
							Rasenshuriken_Hit(o, src, dir)
				if(!i)
					Rasenshuriken_Fail()
				return

			if(rasengan == 4)
				sleep(1)
				flick("PunchA-1", src)
				//sound = 'sounds/right_hook.wav'
				var/i = 0
				for(var/mob/human/o in get_step(src, dir))
					if(!o.ko && !o.IsProtected())
						i = 1
						if(rasengan == 4)
							Rasenshuriken_Hit2(o, src, dir)
				if(!i)
					Rasenshuriken_Fail2()
				return

				if(usr.intiger2)
					var/mob/human/player/t = usr.MainTarget()
					usr:AppearBefore(t)
					flick("PunchA-1",usr)
					flick("PunchA-2",usr)
					t.Knockback(rand(15,15),t.dir)
					usr:AppearBefore(t)
					flick("PunchA-1",usr)
					flick("PunchA-2",usr)
					t.Knockback(rand(20,20),t.dir)
					usr:AppearBefore(t)
					flick("PunchA-1",usr)
					flick("PunchA-2",usr)
					t.curstamina-=rand(usr.str+usr.strbuff+usr.rfxbuff-usr.strneg-usr.rfxneg*4.5,usr.str*5.5+usr.strbuff+usr.rfxbuff-usr.rfxneg-usr.strneg)
					sleep(5)

			if(rasengan == 6)
				// And a bit more specific to the rasengans: They all do the exact same thing except with different overlays and proc calls.
				if(!M && NearestTarget()) FaceTowards(NearestTarget())
				if(rasengan == 6)
					overlays -= /obj/rasengan
					overlays += /obj/rasengan2
			//		sleep(1)
					flick("PunchA-1", src)
					//sound = 'sounds/right_hook.wav'

					var/i = 0
					for(var/mob/human/o in get_step(src, dir))
						if(!o.ko && !o.IsProtected())
							i = 1
							if(rasengan == 6)
								SRasengan_Hit(o, src, dir)
					if(!i)
						SRasengan_Fail()
					return

			// And this arbitrary distinction between having a mob argument or not is weird.
			// It pretty much exists for the AI to explictly specify a target but there's no real reason it needs to.
			// Or that the non-AI part couldn't just preprocess a bit to figure out the target first.
			if(!M)
				if(incombo || frozen || ko)
					return

				if(isguard)
					icon_state = ""
					isguard = 0

				if(madarasusano==1)
					src.overlays-=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)

				if(sasukesusano == 1)
					src.overlays-=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)

				if(itachisusano == 1)
					src.overlays-=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)
					//src.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)

				if(ironmass == 1)
					src.overlays-=image('icons/magnetdef.dmi',pixel_x=-32,pixel_y=-32)

				CheckPK()

				if(istype(src, /mob/human/player/npc))
					var/ans = pick(1, 2, 3, 4)
					if(gentlefist>=1) ans = pick(1, 2)
					if(madarasusano==1) ans = 6
					r = ans
					if(Size || bonedrill) ans = 5 //< Sizeup shouldnt break this anymore? Not since I made it use the newer big-icon support anyway.
					r = ans //< What does 'r' do?
					// This should seriously be a switch() too
					if(Partial) ans = 5
					r = ans
					if(ans == 1)
						spawn() flick("PunchA-1", src)
						//sound = 'sounds/right_hook.wav'
					if(ans == 2)
						spawn() flick("PunchA-2", src)
						//sound = 'sounds/left_hook.wav'
					if(ans == 3)
						spawn() flick("KickA-1", src)
						//sound = 'sounds/kick.wav'
					if(ans == 4)
						spawn() flick("KickA-2", src)
						//sound = 'sounds/kick.wav'
					if(ans == 5)
						icon_state = "PunchA-1"
					if(ans == 6)
						spawn() flick('Susano Arm v2.dmi', src)
						spawn(6)
							icon_state = ""
						//sound = 'sounds/bigpunch.wav'

				if(sleeping || mane || !canattack)
					return

				if(usr.sandfist==1)
					var/obj/trailmaker/Sand_Hand/o=new/obj/trailmaker/Sand_Hand(locate(usr.x,usr.y,usr.z))
					o.density=0
					var/distance=5
					var/usr_dir = usr.dir
					while(o && distance>0 && usr)
						//this should allow people to trigger kawarimi and escape
						for(var/mob/N in o.gotmob)
							if ((N.x!=o.x)||(N.y!=o.y))
								o.gotmob-=N

						if(!step(o, usr_dir))
							break
						var/conmult = usr.ControlDamageMultiplier()
						for(var/mob/human/player/N in o.loc)
							if(N!=usr && !(N in o.gotmob) && !N.kaiten && !N.sandshield && !N.chambered && !N.IsProtected())
								N = N.Replacement_Start(usr)
								o.gotmob+=N
								if(N.shukaku==1)
									N.Damage(rand(150,550)+175*conmult,0,usr, "Doton: Earth Flow", "Normal")
								else
									N.Damage(rand(50,250)+75*conmult,0,usr, "Doton: Earth Flow", "Normal")
								spawn()N.Hostile(usr)
								N.Begin_Stun()

						for(var/turf/T in get_step(o,usr_dir))
							if(T.density)
								distance=1
						sleep(1)

						distance--
						for(var/mob/human/player/N in o.gotmob)
							if(N.shukaku==1)
								N.Damage((rand(35,70)+7*conmult), 0, usr, "Doton: Earth Flow", "Normal")
							else
								N.Damage(rand(25,50)+5*conmult, 0, usr, "Doton: Earth Flow", "Normal")
							spawn()N.Hostile(usr)
					for(var/mob/human/player/N in o.gotmob)
						N.End_Stun()
						spawn(5) N.Replacement_End()
					o.loc = null

				if(NearestTarget()) FaceTowards(NearestTarget())
				else
					var/mob/nearest = NearestTarget(range=64)
					if(nearest) FaceTowards(nearest)

				if(!pk)
					if(!nudge)
						// TODO: CSS-ify this message. Or just remove it, it's really spammy and kinda pointless.
						combat("Nudge")
						nudge = 1

						spawn(10)
							nudge = 0
						for(var/mob/human/player/o in get_step(src, dir))
							if(o.density && !o.sleeping)
								o.Knockback(1, dir)
								o.Timed_Move_Stun(5)
								o.density = 0
								spawn(5)
									o.density = 1

						for(var/mob/human/clay/o in get_step(src, dir))
							o.Explode()
					return

				if(usr.ridingbird)
					if(usr.curchakra>=200)
						usr.curchakra-=200
						for(var/time = 1 to 3)
							var/obj/O = new
							O.icon = 'icons/clay-attack.dmi'
							O.icon_state = "3"
							O.layer = MOB_LAYER + 0.1
							O.dir = usr.dir
							O.density = 0
							O.pixel_x = rand(-16,16)
							O.pixel_y = rand(-16,16)
							var/list/dirs = new
							if(usr.dir == NORTH || usr.dir == SOUTH)
								dirs += EAST
								dirs += WEST
							if(usr.dir == NORTH)
								dirs += NORTH
								if(usr.dir == SOUTH)
									dirs += SOUTH
							if(usr.dir == EAST || usr.dir == WEST || usr.dir == SOUTHEAST || usr.dir == SOUTHWEST || usr.dir == NORTHEAST || usr.dir == NORTHWEST)
								dirs += SOUTH
								dirs += NORTH
								if(usr.dir == EAST || usr.dir == SOUTHEAST || usr.dir == NORTHEAST)
									dirs += EAST
								if(usr.dir == WEST || usr.dir == SOUTHWEST || usr.dir == NORTHWEST)
									dirs += WEST
							O.loc = get_step(usr,pick(dirs))
							sleep(0.05)
							spawn()
								var/tiles = rand(10,15)
								while(usr && tiles > 0 && O.loc != null)
									tiles--
									var/old_loc = O.loc
									for(var/mob/m in view(0,O))
										tiles = 0
										m.Dec_Stam(190*usr:ControlDamageMultiplier(),0,usr)
										m.Wound(rand(0,2),0,usr)
										Blood2(m)
									if(tiles == 0)
										continue
									step(O,O.dir)
									if(O.loc == old_loc)
										tiles = 0
										continue
									sleep(1.25)
								explosion(190*usr:ControlDamageMultiplier(),O.x,O.y,O.z,usr,dist = 1)
								O.loc = null
								usr.protected = 0
								return
					else
						usr<<"You do not have the required chakra for this. [usr.curchakra]/200"
						return 0

				// Is 'Aki' just a synonym for 'Size'? You shouldn't be attacking in MT so
				if(Aki)
					weirdflick = 1

				if(pet)
					var/mob/human/player/t = usr.MainTarget()
					if(usr && t)
						for(var/mob/human/player/npc/x in usr.pet)
							if(t == usr) return
							if(x.stunned) return
							step_towards(x,t)
							spawn()x.AI_Attack(t)
							spawn()x.usev(t)
							spawn()x.AI_Attack(t)

				if(stunned || kstun || handseal_stun || attackbreak)
					return

				var/trfx = rfx + rfxbuff - rfxneg
				var/spawntime
		/*		if(gentlefist)
					attackbreak = 0
					spawntime = -2*/
				if(trfx < 100)
					attackbreak = 10
					spawntime = 5
				else if(trfx >= 100 && trfx < 150)
					attackbreak = 8
					spawntime = 4
				else if(trfx >= 150 && trfx < 200)
					attackbreak = 6
					spawntime = 3
				else if(trfx >= 200 && trfx < 250)
					attackbreak = 5
					spawntime = 2
				else if(trfx >= 250 && trfx < 300)
					attackbreak = 4
					spawntime = 2
				else if(trfx >= 300 && trfx < 350)
					attackbreak = 3
					spawntime = 1
				else if(trfx >= 350)
					attackbreak = 2
					spawntime = 1
				spawn(spawntime) attackbreak = 0

				var/rx=rand(1, 8)

			/*	if(gentlefist)
					attackbreak = 0
					spawntime = -2*/
				if(twinlion==1)
					attackbreak = 0
					spawntime = 0
				if(scalpol)
					spawn() flick("w-attack", src)
					//sound = 'sounds/.wav'
				else
					if(larch || bonedrill)
						if(bonedrill)
							bonedrilluses--
						rx = 1
					if(larch)
						rx = 1
					if(gentlefist)
						rx = pick(1, 4)
					// Yay, more checking the type of src!
					// If someone wasn't annoying and made NPCs a subtype of the player type this wouldn't be needed!
					if(!istype(src, /mob/human/player/npc))
						if(Size)
							icon_state = "PunchA-1"
							spawn(6)
								icon_state = ""
						if(Partial)
							icon_state = "PunchA-1"
							spawn(6)
								icon_state = ""
						if(madarasusano==1)
							usr.overlays+=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)
							usr.overlays+=image('icons/Susano Arm v2.dmi',pixel_x=-96,pixel_y=-96)
							usr.overlays+=image('icons/suheadblue.dmi',pixel_y=16, pixel_x=-16)
							icon_state = "PunchA-1"
							spawn(6)
								icon_state = ""
								usr.overlays-=image('icons/Susano Arm v2.dmi', pixel_x=-96, pixel_y=-96)
								usr.overlays-=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)
								usr.overlays-=image('icons/suheadblue.dmi',pixel_y=16, pixel_x=-16)
							//sound = 'sounds/bigpunch.wav'

						else if(!weirdflick)
							// Probably should be a switch. And WHAT DOES 'r' DO?
							if(rx >= 1 && rx <= 3)
								spawn() flick("PunchA-1", src)
								//sound = 'sounds/right_hook.wav'
								r = 1
							if(rx >= 4 && rx <= 6)
								spawn() flick("PunchA-2", src)
								//sound = 'sounds/left_hook.wav'
								r = 2
							if(rx == 7)
								spawn() flick("KickA-1", src)
								//sound = 'sounds/kick.wav'
								r = 3
							if(rx == 8)
								spawn() flick("KickA-2", src)
								//sound = 'sounds/kick.wav'
								r = 4

						else
							// Probably should be a switch too.
							if(rx >= 1 && rx <= 3)
								spawn()
									r = 1
									//sound = 'sounds/right_hook.wav'
									icon_state = "PunchA-1"
									sleep(5)
									icon_state = ""
							if(rx >= 4 && rx<=6)
								spawn()
									r = 2
									//sound = 'sounds/left_hook.wav'
									icon_state = "PunchA-2"
									sleep(5)
									icon_state = ""
							if(rx == 7)
								spawn()
									r = 3
									//sound = 'sounds/kick.wav'
									icon_state = "KickA-1"
									sleep(5)
									icon_state = ""
							if(rx == 8)
								spawn()
									r = 4
									//sound = 'sounds/kick.wav'
									icon_state = "KickA-2"
									sleep(5)
									icon_state = ""

			var/deg = 0
			var/attack_range = 1
			if(hassword) deg += 2
			if(twinlion==2)
				deg = 5
			if(Size == 1)
				deg = 15
				attack_range = 2
			if(Partial == 1)
				deg = 15
				attack_range = 2
			if(Size == 2)
				deg = 25
				attack_range = 2
			if(madarasusano==1)
				deg = 25
				attack_range = 2
			if(sandfist==1)
				deg = 25
				attack_range = 2

			if(move_stun)
				deg = (deg * 1.5) + 5

			canattack = 0
			spawn(4+deg)
				canattack = 1

			var/mob/target
			if(M)
				target = M
			else
				target = NearestTarget()

			var/mob/T

			if(target)
				var/gtele
				if(shadowleaf)
					var/distance = get_dist(src, target)
					if(distance == 2)
						if(!clan=="Youth")
							src.curstamina -= 250
						step_to(src,target)
				if(gate >= 4 && !gatepwn && get_dist(target, src) <= 4)
					gtele = 1
					var/tele_chance = 35
					switch(gate)
						if(5) tele_chance = 50
						if(6) tele_chance = 65
						if(7,8) tele_chance = 75
					if(prob(tele_chance))
						src:AppearBefore(target, nofollow=1)
						dir = get_dir(src, target)
						sleep(1)
					else
						var/list/xmod = list(0,0,1,1,1,-1,-1,-1)
						var/list/ymod = list(1,-1,0,1,-1,0,1,-1)
						var/list/choice = pick(1,2,3,4,5,6,7,8)
						src:AppearAt(target.x+xmod[choice],target.y+ymod[choice],target.z, "", nofollow=1)
						dir = get_dir(src, target)
						//sleep(1)

				if(usr.lightning_armor==2&& !gatepwn && get_dist(target, src) <= 4)
					gtele = 1
					var/tele_chance2 = 100
					if(prob(tele_chance2))
						src.AppearBefore(target, nofollow=1)
						dir = get_dir(src, target)
						sleep(1)

				if(!gtele && (target in ohearers(attack_range)))
					T = target

				if(M)
					T = M

				if(T && !T.ko && !T.paralysed && !T.mole)
					if(gate >= 5)
						var/obj/smack = new /obj(T.loc)
						smack.icon = 'icons/gatesmack.dmi'
						smack.layer = MOB_LAYER + 1
						flick("smack", smack)
						spawn(4) smack.loc = null

					Combo(T, r)

					//snd(T,sound,vol=30)
					spawn() Taijutsu(T)
					return

			var/last_turf = loc
			var/iterations = 0

			do
				last_turf = get_step(last_turf, dir)
				T = locate() in last_turf
			while(++iterations < attack_range && (!T || T.ko || T.paralysed))

			if(T && !T.ko && !T.paralysed && !T.mole)
				if(gate >= 5)
					var/obj/smack = new /obj(T.loc)
					smack.icon = 'icons/gatesmack.dmi'
					smack.layer = MOB_LAYER + 1
					flick("smack", smack)
					spawn(4)
						smack.loc = null

				Combo(T, r)

				//snd(T,sound,vol=30)
				spawn() Taijutsu(T)
				return
			//snd(src,'sounds/bbb_swing.wav',vol=30)
			usr.Timed_Stun(1)

			if(usr.intiger2)
				var/obj/smack=new/obj(locate(T.x,T.y,T.z))
				smack.layer=MOB_LAYER+1
				flick("PunchA-1",smack)
				flick("PunchA-2",smack)
				sleep(5)
				var/wounddam=rand(3,5)
				usr.Wound(wounddam, 0, usr)
				//	T.curstamina-=rand(usr.str+usr.strbuff+usr.rfxbuff-usr.strneg-usr.rfxneg*2.5,usr.str*3.5+usr.strbuff+usr.rfxbuff-usr.rfxneg-usr.strneg)
				spawn(4)
					smack.loc = locate(null)

				usr.Combo(T,r)

				spawn()usr.Taijutsu(T)

		defendv()
			set name = "Defend"
			set hidden = 1

			//if(inslymind)
			//	return

			if(taiclash)
				PressAButton="D"
				return

			if(drowning)
				drownD--
				return

			if(startclash)
				return

			for(var/mob/human/sandmonster/M in pet)
				spawn() if(M) M.Return_Sand_Pet(src)

			if(usr.keys["shift"] && usr.sharingan==7 && usr.madarasusano==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.madarasusano=0
			 usr.scalpol=0
			 src.overlays-=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)
			 usr<<"Susanoo (DEACTIVATED!)"
			 return
			if(usr.keys["shift"] && usr.sharingan==7 && usr.madarasusano==0)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.madarasusano=1
			 usr<<"Susanoo (ACTIVATED!)"
			 return

			if(usr.keys["shift"] && usr.sharingan==5 && usr.sasukesusano==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.sasukesusano=0
			 src.overlays-=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)
			// src.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
			 usr<<"Susanoo (DEACTIVATED!)"
			 return
			if(usr.keys["shift"] && usr.sharingan==5 && usr.sasukesusano==0)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.sasukesusano=1
			 usr<<"Susanoo (ACTIVATED!)"
			 return

			if(usr.keys["shift"] && usr.sharingan==6 && usr.itachisusano==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.itachisusano=0
			 src.overlays-=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)
			// src.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
			 usr<<"Susanoo (DEACTIVATED!)"
			 return
			if(usr.keys["shift"] && usr.sharingan==6 && usr.itachisusano==0)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.itachisusano=1
			 usr<<"Susanoo (ACTIVATED!)"
			 return

			if(usr.keys["shift"] && usr.human_puppet==2)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Defense mode with ironskin on"
			 	return
			 usr.human_puppet=1
			 usr<<"Defense Mode (DEACTIVATED!)"
			 usr.Affirm_Icon()
			 usr.Load_Overlays()
			 return
			if(usr.keys["shift"] && usr.human_puppet==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate defense mode with ironskin on"
			 	return
			 usr.human_puppet=2
			 usr<<"Defense Mode (ACTIVATED!)"
			 usr.overlays=0
			 usr.Affirm_Icon()
			 usr.Load_Overlays()
			 return

			if(Size || Tank || Partial)
				return

			//usedelay++

			if(src.Transfered||src.controlling_yamanaka)
				return

			if(usr.twinlion==2)
			 usr.twinlion=1
			 usr<<"Twin Lions (DEACTIVATED!)"
			 return
			if(usr.twinlion==1)
			 usr.twinlion=2
			 usr<<"Twin Lions (ACTIVATED!)"
			 return


			if(pet)
				for(var/mob/human/player/npc/p in usr.pet)
					spawn()
						if(usr && p)
							var/list/options = list()
							if(options.len)
								var/skill/x
								do
									x = pick(options)
									options -= x
								while(options.len && !x.IsUsable(p))
								if(x && x.IsUsable(p))
									x.Activate(p)
									return

			if(leading)
				leading.stop_following()
				return

			if(cantreact || spectate || larch || sleeping || mane || ko || !canattack)
				return

			if(skillspassive[CONCENTRATION] && gen_effective_int && !gen_cancel_cooldown)
				var/cancel_roll = Roll_Against(gen_effective_int, (con + conbuff - conneg) * (1 + 0.05 * (skillspassive[21] - 1)), 100)
				if(cancel_roll < 3)
					if(sight == (BLIND|SEE_SELF|SEE_OBJS)) // darkness gen
						sight = 0

				gen_cancel_cooldown = 1
				spawn(100)
					gen_cancel_cooldown = 0

			if(MainTarget()) FaceTowards(MainTarget())
			else
				var/mob/nearesttarget = NearestTarget(range=64)
				if(nearesttarget) FaceTowards(nearesttarget)

			if(rasengan == 1)
				Rasengan_Fail()
			if(rasengan == 2)
				ORasengan_Fail()
			if(rasengan == 6)
				SRasengan_Fail()
			//Why is this missing rasenshuriken?

			if(controlmob)
				// More stuff that should just be handled by killing uses of usr and calling controlmob.blah()
				usr = controlmob
				src = controlmob

			if(stunned || kstun || handseal_stun)
				return

			if(!isguard)
				icon_state = "Seal"
				if(madarasusano==1)
					src.overlays+=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)
				isguard = 1
				if(sasukesusano == 1)
					src.overlays+=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)
				//	src.overlays+=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
				isguard = 1

				if(itachisusano == 1)
					src.overlays+=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)
				isguard = 1

				if(ironmass == 1)
					src.overlays+=image('icons/magnetdef.dmi',pixel_x=-32,pixel_y=-32)
				isguard = 1

// I don't think this really deserves it's own proc anymore but.
mob/proc/Get_Hair_RGB()
	hair_color = input(src, "What color would you like your hair to be?") as color

obj
	mapcontrol
		World
			Click()
				if(usr.client && usr.spectate)
					usr.client.eye=locate(MAP_START_X+5,MAP_START_Y+5,MAP_START_Z)
					usr.area = null
	skilltree
		Back
			Click()
				if(usr.build_creating)
					usr.client.eye = locate_tag("maptag_skilltree_select")
					usr.spectate = 1
				//	usr.hidestat = 0
					usr:Refresh_Stat_Screen()
				else
					usr.client.eye = usr.client.mob
				//	usr.hidestat = 0
					usr.spectate = 0
					usr:Refresh_Stat_Screen()
mob/human/npc/Dojo_Owner
	interact="Talk"
	verb
		Talk()
			set src in oview(1)
			set hidden = 1
			alert(usr, "Welcome to the Dojo, this place isnt quite a pk zone and its not quite a no-pk zone. In the dojo, you can fight but youll never be wounded, its a safe place to spar and train.")
mob/human/npc/barber
	interact="Talk"
	verb
		Talk()
			set src in oview(1)
			set hidden = 1
			switch(input2(usr, "Would you like to get your hair cut?", "Barber",list ("Yes","No")))
				if("Yes")
				//	usr.hidestat = 0
					usr.GoCust()

mob/human/npc/headbandguy
	interact="Talk"
	verb
		Talk()
			set src in oview(1)
			set hidden = 1
			if(usr.rank != "Academy Student")
				for(var/obj/items/equipable/Headband/x in usr.contents)
					x.loc = null
				switch(input2(usr,"What Type of Headband would you like?", "Headband", list("Blue","Black","Red")))
					if("Red")
						new /obj/items/equipable/Headband/Red(usr)
					if("Blue")
						new /obj/items/equipable/Headband/Blue(usr)
					if("Black")
						new /obj/items/equipable/Headband/Black(usr)
			else
				// TODO: CSS-ify this message. Not that anyone will see it until we get a new tutorial.
				usr << "You get a Headband only when you graduate!"
mob/human/npc
	New()
		..()
		Load_Overlays()

// TODO: Kill these NPCs, they do nothing.
mob/human/npc/teachernpc3
	interact = "Talk"
	verb
		Talk()
			set src in oview(1)
			set hidden = 1

mob/human/npc/teachernpc2
	interact = "Talk"
	verb
		Talk()
			set src in oview(1)
			set hidden = 1

proc
	smack(mob/M, dx, dy)
		if(!M) return
		if(wregenlag > 2)
			return
		var/Px=dx + M.pixel_x
		var/Py=dy + M.pixel_y
		var/obj/X = new/obj(M.loc)
		X.pixel_x = Px
		X.pixel_y = Py
		X.layer = M.layer
		X.layer++
		X.density = 0
		X.icon = 'icons/twack.dmi'
		flick("fl", X)
		sleep(7)
		X.loc = null

// Another pretty pointless NPC.
//teacher!
mob/human/npc/teachernpc
	interact = "Talk"
	verb
		Talk_r()
			set src in oview(1)
			alert(usr, "In Naruto GOA, you don't talk to npcs by right clicking on them, double click an npc first to target it (signified by a red arrow) then press Space or the button labeled 'Spc' on the screen.")
		Talk()
			set src in oview(1)
			set hidden = 1

proc/get_steps(atom/A, var/dir, var/num)
	var/T = get_step(A, dir)
	while(num && T)
		A = T
		T = get_step(A, dir)
		--num
	return A

mob/proc
	jump()
		if(usr.is_jumping || !usr.pk || usr.stunned||usr.handseal_stun||usr.kstun||usr.ko||usr.Size||usr.Tank||usr.mole||usr.skillusecool||usr.Fly)
			return
		var/atom/a = get_steps(usr, usr.dir, 7)
		if(a.density || !a)
			return


		spawn()
			usr.curstamina-=200
			usr.is_jumping = 1
			var/jumpt = 0
			usr.icon_state = "Run"
			usr.density = 0
			usr.layer += 140
			while(src && jumpt <= jump_time/2)
				jumpt += 10
				usr.pixel_y += 5
				switch(usr.dir)
					if(NORTH)
						usr.loc = locate(usr.x, usr.y+1, usr.z)
					if(SOUTH)
						usr.loc = locate(usr.x, usr.y-1, usr.z)
					if(EAST)
						usr.loc = locate(usr.x+1, usr.y, usr.z)
					if(WEST)
						usr.loc = locate(usr.x-1, usr.y, usr.z)
					if(NORTHEAST)
						usr.loc = locate(usr.x+1, usr.y+1, usr.z)
					if(NORTHWEST)
						usr.loc = locate(usr.x-1, usr.y+1, usr.z)
					if(SOUTHEAST)
						usr.loc = locate(usr.x+1, usr.y-1, usr.z)
					if(SOUTHWEST)
						usr.loc = locate(usr.x-1, usr.y-1, usr.z)
				sleep(1)
			sleep(1)
			while(src && jumpt <= jump_time)
				jumpt += 16
				usr.pixel_y -= 8
				switch(usr.dir)
					if(NORTH)
						usr.loc = locate(usr.x, usr.y+1, usr.z)
					if(SOUTH)
						usr.loc = locate(usr.x, usr.y-1, usr.z)
					if(EAST)
						usr.loc = locate(usr.x+1, usr.y, usr.z)
					if(WEST)
						usr.loc = locate(usr.x-1, usr.y, usr.z)
					if(NORTHEAST)
						usr.loc = locate(usr.x+1, usr.y+1, usr.z)
					if(NORTHWEST)
						usr.loc = locate(usr.x-1, usr.y+1, usr.z)
					if(SOUTHEAST)
						usr.loc = locate(usr.x+1, usr.y-1, usr.z)
					if(SOUTHWEST)
						usr.loc = locate(usr.x-1, usr.y-1, usr.z)
				sleep(1)
			usr.pixel_y = 0
			usr.icon_state = "Run"
			//usr.is_jumping = 0
			usr.density = 1
			usr.layer -= 140
			sleep(100)
			usr.is_jumping = 0

obj/Effects
	icon='RockScizorsPaper.dmi'
	layer=MOB_LAYER+3
	screen_loc="10,10"
	RockMash
		icon_state="A"
	ScizorMash
		icon_state="F"
	PaperMash
		icon_state="D"

obj/Effects2
	icon='RSPscreen.dmi'
	layer=MOB_LAYER+3
	screen_loc="9,10"



mob/Admin/verb/Ambush_GM()
	var/list/Ambushees=new
	var/num=input("How many to ambush","Ambush") as num
	var/lvl=input("What level?") as num
	for(var/mob/human/player/O in world)
		if(O.client) Ambushees+=O
	Ambushees+="(Below me)"
	Ambushees+="(Nevermind)"
	var/pik = input("Pick somebody to be Ambushed","Ambush") in Ambushees
	if(istype(pik,/mob))
		var/mob/human/player/M = pik
		if(!lvl)lvl=M.blevel
		Ambush(pik,lvl,num)
	else
		if(pik=="(Below me)")
			Ambush(locate(usr.x,usr.y-10,usr.z),lvl,num)