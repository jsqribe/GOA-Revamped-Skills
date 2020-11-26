mob/proc/Get_Skill_Info(index)
	switch(index)
		if(4)
			var/popup = {"SkillPoint Cost: 50, Chakra Cost:10 Cooldown: 30 Seconds <br>
			<br><p><b>Bunshin is a standard ninja skill, using a very slight amount of chakra, the user can create an illusion of themselves to fool enemies.</b>"}// {"<IMG SRC='X.jpg'</IMG>"}
			src<<browse(popup,"window=Announcement,size=300x300,can_close=1,can_resize=1,titlebar=1")

client/Topic(href)
	if(href=="close")
		usr << browse(null,"window=Announcement")
	.=..()

mob/human/proc/refreshskills()
	//world.log << "[src] called refreshskills()"
	if(src.client)
		src.Refresh_Skillpoints()
		src.Refresh_Gold()

mob/human/proc/Refresh_Gold()
	CHECK_TICK
	if(client)
		for(var/obj/skilltree/skills/X in gameLists["skills"])
			if(X.is_dull)
				continue

			client.images -= X.goldimage
			client.images -= X.dullimage

			var/shown_gold = 0
			var/shown_dull = 0

			if(X.sindex > 0 && HasSkill(X.sindex))
				if(!shown_gold)
					src << X.goldimage
					shown_gold = 1

			if(X.element)
				if(X.element in elements)
					if(!shown_gold)
						src << X.goldimage
						shown_gold = 1

			if(X.clan)
				if(clan == X.clan)
					if(!shown_gold)
						src << X.goldimage
						shown_gold = 1
				else
					if(!shown_dull)
						src << X.dullimage
						shown_dull = 1

			if(X.clan_reqs)
				var/has_reqs = 1
				for(var/req_clan in X.clan_reqs)
					if(clan != req_clan)
						has_reqs = 0
						break

				if(!has_reqs)
					if(!shown_dull)
						src << X.dullimage
						shown_dull = 1

			if(X.element_reqs)
				var/has_reqs = 1
				for(var/req_element in X.element_reqs)
					if(!(req_element in elements))
						has_reqs = 0
						break

				if(!has_reqs)
					if(!shown_dull)
						src << X.dullimage
						shown_dull = 1

			if(X.skill_reqs)
				var/has_reqs = 1
				for(var/req_skill in X.skill_reqs)
					if(!HasSkill(req_skill))
						has_reqs = 0
						break

				if(!has_reqs)
					if(!shown_dull)
						src << X.dullimage
						shown_dull = 1

mob/objserver
	New()
		..()
		var/list/m=list()//typesof(/obj/gui/skillcards)
		m+=typesof(/obj/items)
		m -= /obj/items
		m -= /obj/items/equipable
		m -= /obj/items/equipable/newsys
		for(var/x in m)
			new x(src)

obj
	skilltree
		skills
			var
				sindex=0
				cost=0
				list/skill_reqs
				element
				list/element_reqs
				clan
				list/clan_reqs

				tmp
					image
						goldimage
						dullimage
					is_dull = 0


			New()
				. = ..()
				if(icon=='icons/gui.dmi')
					goldimage=image('icons/gui.dmi',src,icon_state="golden")
					dullimage=image('icons/dull.dmi',src)

					//goldimage.pixel_x = pixel_x
					//goldimage.pixel_y = pixel_y
					goldimage.layer = layer + 1

					//dullimage.pixel_x = pixel_x
					//dullimage.pixel_y = pixel_y
					dullimage.layer = layer + 1

				if(!((cost && (sindex > 0)) || element || clan))
					world << dullimage
					is_dull = 1
				gameLists["skills"] += src

			Click()
				if(sindex <= 0 && !element)
					return

				var/srccost=src.cost
				if(element)
					switch(usr.elements.len)
						if(0)
							srccost=250
						if(1)
							srccost=450
						if(2)
							srccost=650
						if(3)
							srccost=850
						else // 4
							srccost=1050

				var/description="Ability: [src.name]"
				if(srccost)
					description += ", Skill Point Cost: [srccost]"
				var/options = list("Get Skill Information")

				if(srccost)
					var/has_clan = 1
					if(clan_reqs)
						for(var/req_clan in clan_reqs)
							if(usr.clan != req_clan)
								has_clan = 0
								break

					if(has_clan)
						if(sindex > 0)
							if(!usr:HasSkill(sindex))
								options += "Buy Skill"
						else if(element)
							if(!(element in usr.elements))
								options += "Buy Skill"

				options += "Nevermind"

				switch(input2(usr, "[description]", "Skill", options))
					if("Get Skill Information")
						if(sindex > 0 || element)
							usr << "[src]: "
							if(srccost)
								usr << "\t[srccost] Skill Points"
							if(clan_reqs)
								usr << "\tA skill of the [list_to_text(clan_reqs)] clan[clan_reqs.len>1?"s":""]"
							if(element_reqs)
								usr << "\tRequires the ability to convert chakra to the [list_to_text(element_reqs)] element[element_reqs.len>1?"s":""]"
							if(element)
								usr << "\tGives the ability to convert chakra to the [element] element."
							if(sindex > 0)
								var/skill/s = ExampleSkill(sindex)
								if(s)
									var/stam_dmg = s.EstimateStaminaDamage(usr)
									var/wound_dmg = s.EstimateWoundDamage(usr)
									var/chakra_cost = s.ChakraCost(usr)
									var/stamina_cost = s.StaminaCost(usr)
									var/supply_cost = s.SupplyCost(usr)
									var/seal_time = s.SealTime(usr)
									var/cooldown_time = s.Cooldown(usr)

									if(s.description)
										usr << "\t[s.description]"

									if(chakra_cost)
										usr << "\tChakra Cost: [chakra_cost]"
									if(stamina_cost)
										usr << "\tStamina Cost: [stamina_cost]"
									if(supply_cost)
										usr << "\tSupply Cost: [supply_cost]"
									if(seal_time)
										usr << "\tHandseal Time: [seal_time]"
									if(cooldown_time)
										usr << "\tCooldown Time: [cooldown_time]"

									if(stam_dmg)
										if(stam_dmg[1] == stam_dmg[2])
											usr << "\tStamina Damage: [round(stam_dmg[1])]"
										else
											usr << "\tStamina Damage: [round(stam_dmg[1])]-[round(stam_dmg[2])]"
									if(wound_dmg)
										if(wound_dmg[1] == wound_dmg[2])
											usr << "\tWound Damage: [round(wound_dmg[1])]"
										else
											usr << "\tWound Damage: [round(wound_dmg[1])]-[round(wound_dmg[2])]"


					if("Buy Skill")
						if(!(SkillType(sindex) || element))
							usr << "This skill is not currently available."
							return

						if(sindex > 0)
							if(usr:HasSkill(sindex))
								usr<<"You have already learned this skill!"
								return
						else
							if(element in usr.elements)
								usr<<"You have already learned to control this element!"
								return

						var/has_reqs=1
						if(skill_reqs)
							for(var/skill_id in skill_reqs)
								if(skill_id > 0)
									if(!usr:HasSkill(skill_id))
										has_reqs = 0
										break

						if(has_reqs && element_reqs)
							for(var/element in element_reqs)
								if(!(element in usr.elements))
									has_reqs = 0
									break

						if(has_reqs && clan_reqs)
							for(var/clan in clan_reqs)
								if(usr.clan != clan)
									has_reqs = 0
									break

						if(has_reqs)
							if(srccost > 0)
								switch(input2(usr,"Are you sure you want to obtain [src.name] at the cost of [srccost] skillpoints", "Skill",list ("Yes","No")))
									if("Yes")
										var/realcost = src.cost
										if(element)
											switch(usr.elements.len)
												if(0)
													realcost=250
												if(1)
													realcost=450
												if(2)
													realcost=650
												if(3)
													realcost=850
												else // 4
													realcost=1050
										if(usr.skillpoints>=realcost)
											if(sindex > 0)
												usr:AddSkill(sindex)
												if(sindex==SAND_SUMMON)
													usr:AddSkill(SAND_UNSUMMON)
												if(sindex==GATE1)
													usr:AddSkill(GATE_CANCEL)
												if(sindex==HUMAN_PUPPET)
													usr:AddSkill(PUPPET_WEAPON_1)
													usr:AddSkill(PUPPET_WEAPON_2)
													usr:AddSkill(PUPPET_WEAPON_3)
													usr:AddSkill(PUPPET_WEAPON_4)
													usr:AddSkill(PUPPET_WEAPON_5)
													usr:AddSkill(PUPPET_WEAPON_6)
												usr:RefreshSkillList()
											if(element)
												usr.elements += element
											usr.skillpoints-=realcost
											usr:refreshskills()

							else
								usr<<"This skill is not currently available."
								return
						else
							usr << "You are missing the prerequisites to learn this skill!"

			clan
				Akimichi_Clan
					clan = "Akimichi"
				Deidara_Clan
					clan = "Deidara"
				Haku_Clan
					clan = "Haku"
				Hyuuga_Clan
					clan = "Hyuuga"
				Jashin_Religion
					clan = "Jashin"
				Kaguya_Clan
					clan = "Kaguya"
				Nara_Clan
					clan = "Nara"
				Puppeteer
					clan = "Puppeteer"
				// Sand is a skill
				Uchiha_Clan
					clan = "Uchiha"
				Paper_Clan
					clan = "Paper"
				Collector_Clan
					clan = "Collector"
				Hozuki_Clan
					clan = "Hozuki"
				Bubble_Clan
					clan = "Bubble"
				Scavenger_Clan
					clan = "Scavenger"
				Yamanaka_Clan
					clan = "Yamanaka"
				Dust_Clan
					clan = "Dust"
				Inuzuka_Clan
					clan = "Inuzuka"
				Boil_Clan
					clan = "Boil"
				Ink_Clan
					clan = "Ink"
				Crystal_Clan
					clan = "Crystal"
				Snake_Clan
					clan = "Snake"
				Space_Time_Clan
					clan = "Namikaze"
				Nintaijutsu_Clan
					clan = "Nintaijutsu"
				nintaijutsu
					clan_reqs = list("Nintaijutsu")
					horizontal_oppression
						sindex = HORIZONTAL_OPPRESSION
						cost = 900
						skill_reqs = list(LIGHTNING_ARMOR)
					lariat
						sindex = LARIAT
						cost = 1400
						skill_reqs = list(HORIZONTAL_OPPRESSION)
					lightning_armor
						sindex = LIGHTNING_ARMOR
						cost = 1800
					lightning_armor_2nd
						sindex = LIGHTNING_ARMOR_2ND
						cost = 7500
						skill_reqs = list(LARIAT)
				crystal
					clan_reqs = list("Crystal")
					crystal_spikes
						sindex = CRYSTAL_SPIKES
						cost = 1500
					crystal_chamber
						sindex = CRYSTAL_CHAMBER
						cost = 1800
						skill_reqs = list(CRYSTAL_ARMOR)
					crystal_dragon
						sindex = CRYSTAL_DRAGON
						cost = 2500
					crystal_barrier
						sindex = CRYSTAL_BARRIER
						cost = 3000
						skill_reqs = list(CRYSTAL_DRAGON)
					crystal_armor
						sindex = CRYSTAL_ARMOR
						cost = 1200
				snake
					clan_reqs = list("Snake")
					snake_bind
						sindex = SNAKE_BIND
						cost = 800
					snake_ambush
						sindex = SNAKE_AMBUSH
						cost = 1700
						skill_reqs = list(SNAKE_BIND)
					snake_hands
						sindex = SNAKE_HANDS
						cost = 500
					many_snake_hands
						sindex = MANY_SNAKE_HANDS
						cost = 1200
						skill_reqs = list(SNAKE_HANDS)
					snake_shedding
						sindex = SKIN_SHEDDING
						cost = 2500
						skill_reqs = list(MANY_SNAKE_HANDS)
					rashomon
						sindex = RASHOUMON
						cost = 3500
						skill_reqs = list(SKIN_SHEDDING)
					snake_wear
						sindex = SKIN_WEAR
						cost = 1400
						skill_reqs = list(SNAKE_AMBUSH)
				space_time
					clan_reqs = list("Namikaze")
					space_time_migration
						sindex = SPACETIME_MIGRATION
						cost = 1600
					space_time_barrier
						sindex = SPACETIME_BARRIER
						cost = 1800
						skill_reqs = list(SPACETIME_MIGRATION)
					marking
						sindex = SPACETIME_HIRAISHIN_MARKING
						cost = 800
					flying_thunder_god_technique
						sindex = SPACETIME_FLYING_GOD
						cost = 2500
						skill_reqs = list(SPACETIME_HIRAISHIN_MARKING)
				ink
					clan_reqs = list("Ink")
					brush
						sindex = BRUSH
						cost = 400
					ink_snake
						sindex = INK_SNAKE
						cost = 800
						skill_reqs = list(BRUSH)
					ink_beast
						sindex = INK_BEAST
						cost = 1400
						skill_reqs = list(INK_SNAKE)
					ink_bird
						sindex = INK_BIRD
						cost = 2500
						skill_reqs = list(INK_BEAST)
				boil
					clan_reqs = list("Boil")
					Dragon_Bullet
						sindex = DRAGON_BULLET
						cost = 3000
						skill_reqs = list(BOIL_RELEASE_SKILLED_MIST_TECHNIQUE)
					Mist
						sindex = BOIL_RELEASE_SKILLED_MIST_TECHNIQUE
						cost = 1900
				dust
					clan_reqs = list("Dust")
					Detachment
						sindex = CUBICAL_VARIANT
						cost = 4500
				paper
					clan_reqs = list("Paper")
					Paper_Shuriken
						sindex = PAPER_SHURIKEN
						cost = 1400
					Paper_Bomb
						sindex = PAPER_BOMB
						cost = 800
						skill_reqs = list(PAPER_SHURIKEN)
					Paper_Chasm
						sindex = PAPER_CHASM
						cost = 2500
						skill_reqs = list(PAPER_BOMB)
			/*	scavenger
					clan_reqs = list("Scavenger")
					Heart_Extraction
						sindex = HEART_EXTRACTION
						cost = 1800
					Generate_Heart
						sindex = GENERATE_HEART
						cost = 2200*/
				inuzuka
					clan_reqs = list("Inuzuka")
					Double_Fang_Over_Fang
						sindex = DOUBLE_FANG_OVER_FANG
						cost = 2500
						skill_reqs = list(FANG_OVER_FANG)
					Whistle
						sindex = WHISTLE
						cost = 1000
					Beast_Mode
						sindex = BEAST_MODE
						cost = 2000
						skill_reqs = list(WHISTLE)
					Dynamic_Marking
						sindex = DYNAMIC_MARKING
						cost = 1500
						skill_reqs = list(WHISTLE)
					Fang_Over_Fang
						sindex = FANG_OVER_FANG
						cost = 1700
						skill_reqs = list(WHISTLE)
				bubble
					clan_reqs = list("Bubble")
					Blinding_Bubble
						sindex = BLINDING_BUBBLES
						cost = 1200
						skill_reqs = list(BUBBLE_BARRAGE)
					Exploding_Bubble
						sindex = EXPLODING_BUBBLES
						cost = 2900
						skill_reqs = list(BLINDING_BUBBLES)
					Bubble_Barrage
						sindex = BUBBLE_BARRAGE
						cost = 1500
				hozuki
					clan_reqs = list("Hozuki")
					Water_Gun
						sindex = WATER_GUN
						cost = 1600
						skill_reqs = list(HYDRATION)
					Water_Arm
						sindex = WATER_ARM
						cost = 1100
					Hydration
						sindex = HYDRATION
						cost = 1900
						skill_reqs = list(WATER_ARM)
				akimichi
					clan_reqs = list("Akimichi")
					Size_Multiplication
						sindex = SIZEUP1
						cost = 800
					Super_Size_Multiplication
						sindex = SIZEUP2
						cost = 1500
						skill_reqs = list(SIZEUP1)
					Human_Bullet_Tank
						sindex = MEAT_TANK
						cost = 600
					Spinach_Pill
						sindex = SPINACH_PILL
						cost = 800
					Curry_Pill
						sindex = CURRY_PILL
						cost = 1200
						skill_reqs = list(SPINACH_PILL)
				deidara
					clan_reqs = list("Deidara")
					Exploding_Bird
						sindex = EXPLODING_BIRD
						cost = 800
					Exploding_Spider
						sindex = EXPLODING_SPIDER
						cost = 800
					C3
						sindex = C3
						cost = 3500
						skill_reqs = list(EXPLODING_BIRD, EXPLODING_SPIDER)
					Exploding_Barrage
						sindex = EXPLODING_BARRAGE
						cost = 1500
						skill_reqs = list(EXPLODING_OWL,EXPLODING_BIRD)
					Exploding_Owl
						sindex = EXPLODING_OWL
						cost = 1200
					C4
						sindex = C4
						cost = 2800
						skill_reqs = list(C3)
					C0
						sindex = C0
						cost = 3500
						skill_reqs = list(C4)
					C2
						sindex = C2
						cost = 1800
						skill_reqs = list(EXPLODING_BIRD, EXPLODING_SPIDER)
				haku
					clan_reqs = list("Haku")
					Sensatsusuisho
						sindex = ICE_NEEDLES
						cost = 800
					Ice_Explosion
						sindex = ICE_SPIKE_EXPLOSION
						cost = 1500
						skill_reqs = list(ICE_NEEDLES)
					Demonic_Ice_Crystal_Mirrors
						sindex = DEMONIC_ICE_MIRRORS
						cost = 2500
						skill_reqs = list(ICE_SPIKE_EXPLOSION)
				hyuuga
					clan_reqs = list("Hyuuga")
					Byakugan
						sindex = BYAKUGAN
						cost = 400
					Turning_the_Tide
						sindex = KAITEN
						cost = 1500
						skill_reqs = list(BYAKUGAN)
					Palms
						sindex = HAKKE_64
						cost = 2000
						skill_reqs = list(BYAKUGAN)
					Gentle_Fist
						sindex = GENTLE_FIST
						cost = 700
						skill_reqs = list(BYAKUGAN)
				jashin
					clan_reqs = list("Jashin")
					Stab_Self
						sindex = MASOCHISM
						cost = 500
						skill_reqs = list(BLOOD_BIND)
					Death_Ruling_Possession_Blood
						sindex = BLOOD_BIND
						cost = 1200
					Wound_Regeneration
						sindex = WOUND_REGENERATION
						cost = 800
						skill_reqs = list(MASOCHISM)
					Immortality
						sindex = IMMORTALITY
						cost = 1500
				kaguya
					clan_reqs = list("Kaguya")
					Piercing_Finger_Bullets
						sindex = BONE_BULLETS
						cost = 1500
					Bone_Harden
						sindex = BONE_HARDEN
						cost = 1000
					Camellia_Dance
						sindex = BONE_SWORD
						cost = 500
					Larch_Dance
						sindex = BONE_SPINES
						cost = 800
						skill_reqs = list(BONE_SWORD)
					Young_Bracken_Dance
						sindex = SAWARIBI
						cost = 2000
						skill_reqs = list(BONE_SPINES, BONE_BULLETS)
				nara
					clan_reqs = list("Nara")
					Shadow_Binding
						sindex = SHADOW_IMITATION
						cost = 1100
					Shadow_Neck_Bind
						sindex = SHADOW_NECK_BIND
						cost = 1500
						skill_reqs = list(SHADOW_IMITATION)
					Shadow_Sewing
						sindex = SHADOW_SEWING_NEEDLES
						cost = 1500
						skill_reqs = list(SHADOW_NECK_BIND)
				puppet
					clan_reqs = list("Puppeteer")
					First_Puppet
						sindex = PUPPET_SUMMON1
						cost = 700
					Second_Puppet
						sindex = PUPPET_SUMMON2
						cost = 2000
						skill_reqs = list(PUPPET_SUMMON1)
					Puppet_Transform
						sindex = PUPPET_HENGE
						cost = 350
						skill_reqs = list(PUPPET_SUMMON1)
					Puppet_Swap
						sindex = PUPPET_SWAP
						cost = 350
						skill_reqs = list(PUPPET_SUMMON1)
				sand
					clan_reqs = list("Sand Control")
					Sand_Control
						sindex = SAND_SUMMON
						cost = 100
					Desert_Funeral
						sindex = DESERT_FUNERAL
						cost = 2000
						skill_reqs = list(SAND_SUMMON)
					Sand_Shield
						sindex = SAND_SHIELD
						cost = 800
						skill_reqs = list(SAND_SUMMON)
					Sand_Armor
						sindex = SAND_ARMOR
						cost = 1500
						skill_reqs = list(SAND_SHIELD)
					Sand_Shuriken
						sindex = SAND_SHURIKEN
						cost = 1750
						skill_reqs = list(SAND_SUMMON)
				uchiha
					clan_reqs = list("Uchiha")
					Sharingan_2
						sindex = SHARINGAN1
						cost = 750
					Sharingan_3
						sindex = SHARINGAN2
						cost = 2000
						skill_reqs = list(SHARINGAN1)
					Sharingan_Copy
						sindex = SHARINGAN_COPY
						cost = 2500
						skill_reqs = list(SHARINGAN2)
				yamanaka
					clan_reqs = list("Yamanaka")
					Mind_Transfer_Jutsu
						sindex = MIND_TRANSFER
						cost = 500
					Wolfbane
						sindex = WOLFBANE
						cost = 1000
					Flower_Bomb
						sindex = FLOWER_BOMB
						cost = 1400
						skill_reqs = list(WOLFBANE)
					Mind_Disturbance
						sindex = MIND_DISTURBANCE
						cost = 800
						skill_reqs = list(MIND_TRANSFER)
					Mind_Read
						sindex = MIND_READ
						cost = 400
						skill_reqs = list(MIND_DISTURBANCE)
					Cursed_Doll
						sindex = CURSED_DOLL
						cost = 2000
						skill_reqs = (MIND_DISTURBANCE)
			elements
				Earth_Elemental_Control
					element = "Earth"
				Fire_Elemental_Control
					element = "Fire"
				Lightning_Elemental_Control
					element = "Lightning"
				Water_Elemental_Control
					element = "Water"
				Wind_Elemental_Control
					element = "Wind"
				earth
					element_reqs = list("Earth")
					Iron_Skin
						sindex = DOTON_IRON_SKIN
						cost = 1800
					Earth_Wall
						sindex = EARTH_WALL
						cost = 1000
						skill_reqs = list(DOTON_IRON_SKIN)
					Swamp_of_the_Underworld
						sindex  = DOTON_SWAMP_FIELD
						cost = 900
						skill_reqs = list (DOTON_EARTH_FLOW)
					Dungeon_Chamber_of_Nothingness
						sindex = DOTON_CHAMBER
						cost = 800
					Split_Earth_Revolution_Palm
						sindex = DOTON_CHAMBER_CRUSH
						cost = 1500
						skill_reqs = list(DOTON_CHAMBER)
					Earth_Flow_River
						sindex = DOTON_EARTH_FLOW
						cost = 1900
					Mole_Hiding
						sindex = DOTON_MOLE_HIDING
						cost = 700
					Head_Hunter
						sindex = DOTON_HEAD_HUNTER
						cost = 1100
						skill_reqs = list(DOTON_MOLE_HIDING)
					Dome
						sindex = DOTON_PRISON_DOME
						cost = 1400
						skill_reqs = list(DOTON_CHAMBER)
					Shaking_Palm
						sindex = DOTON_EARTH_SHAKING_PALM
						cost = 2000
						skill_reqs = list(DOTON_CHAMBER_CRUSH)
					Earth_Flow_River
						sindex = DOTON_EARTH_FLOW
						cost = 1900
					Earth_Dragon
						sindex = DOTON_EARTH_DRAGON
						cost = 1100
						skill_reqs = list(DOTON_EARTH_FLOW)
					Resurrection
						sindex = DOTON_RESURRECTION_TECHNIQUE
						cost = 4000
						skill_reqs = list(DOTON_HEAD_HUNTER,DOTON_EARTH_FLOW,DOTON_EARTH_DRAGON,DOTON_CHAMBER,DOTON_PRISON_DOME,DOTON_IRON_SKIN,DOTON_CHAMBER_CRUSH,DOTON_EARTH_SHAKING_PALM)

				fire
					element_reqs = list("Fire")
					Grand_Fireball
						sindex = KATON_FIREBALL
						cost = 800
					Hosenka
						sindex = KATON_PHOENIX_FIRE
						cost = 400
					Ash_Accumulation_Burning
						sindex = KATON_ASH_BURNING
						cost = 2500
					Fire_Dragon_Flaming_Projectile
						sindex = KATON_DRAGON_FIRE
						cost = 2200
						skill_reqs = list(KATON_PHOENIX_FIRE)
					Coiling_Flame
						sindex = KATON_COILING_FLAME
						cost = 800
						skill_reqs = list(KATON_PHOENIX_FIRE)
					Katon_Phoenix_Nail_Flower
						sindex = KATON_PHOENIX_NAIL_FLOWER
						cost = 1500
						skill_reqs = list(KATON_PHOENIX_FIRE)
				lightning
					element_reqs = list("Lightning")
					Chidori
						sindex = CHIDORI
						cost = 1500
					Chidori_Spear
						sindex = CHIDORI_SPEAR
						cost = 2500
					False_Darkness
						sindex = FALSE_DARKNESS
						cost = 1800
						skill_reqs = list(CHIDORI_SPEAR)
					Chidori_Current
						sindex = CHIDORI_CURRENT
						cost = 600
					Four_Pillar_Binding
						sindex = FOUR_PILLAR_BIND
						cost = 1200
					Chidori_Needles
						sindex = CHIDORI_NEEDLES
						cost = 1500
						skill_reqs = list(CHIDORI)
				water
					element_reqs = list("Water")
					Giant_Vortex
						sindex = SUITON_VORTEX
						cost = 600

					Bursting_Water_Shockwave
						sindex = SUITON_SHOCKWAVE
						cost = 2500

					Water_Dragon_Projectile
						sindex = SUITON_DRAGON
						cost = 1100

					Hidden_Mist
						sindex = SUITON_HIDDEN_MIST
						cost = 1500

					Water_Prison
						sindex = SUITON_WATER_PRISON
						cost = 1200

					Water_Bullet
						sindex = SUITON_WATER_BULLET
						cost = 800

					Syrup_Capture
						sindex = SUITON_SYRUP_CAPTURE
						cost = 1100
						skill_reqs = list(SUITON_VORTEX)

					Collision_Destruction
						sindex = SUITON_COLLISION_DESTRUCTION
						cost = 2100
						skill_reqs = list(SUITON_VORTEX)
				wind
					element_reqs = list("Wind")
					Pressure_Damage
						sindex = FUUTON_PRESSURE_DAMAGE
						cost = 2500
					Blade_of_Wind
						sindex = FUUTON_WIND_BLADE
						cost = 1500
					Vacuum_Blade_Rush
						sindex = FUUTON_VACUUM_BLADE_RUSH
						cost = 1500
						skill_reqs = list(FUUTON_WIND_BLADE)
					Great_Breakthrough
						sindex = FUUTON_GREAT_BREAKTHROUGH
						cost = 400
					Refined_Air_Bullet
						sindex = FUUTON_AIR_BULLET
						cost = 2000
						skill_reqs = list(FUUTON_GREAT_BREAKTHROUGH)
					Vaccum_Sphere
						sindex = VACUUM_SPHERE
						cost = 1300
						skill_reqs = list(FUUTON_GREAT_BREAKTHROUGH, FUUTON_WIND_BLADE)
			general
				clones
					Clone
						sindex = BUNSHIN
						cost = 50
					Shadow_Clone
						sindex = KAGE_BUNSHIN
						cost = 1500
						skill_reqs = list(BUNSHIN)
					Multiple_Shadow_Clone
						sindex = TAJUU_KAGE_BUNSHIN
						cost = 1800
						skill_reqs = list(KAGE_BUNSHIN)
					Exploding_Shadow_Clone
						sindex = EXPLODING_KAGE_BUNSHIN
						cost = 1900
						skill_reqs = list(KAGE_BUNSHIN)
					/*
					Crow_Clone
						sindex = CROW_BUNSHIN
						cost = 900
						skill_reqs = list(BUNSHIN)
					*/

				gates
					Opening_Gate
						sindex = GATE1
						cost = 1500
					Energy_Gate
						sindex = GATE2
						cost = 1000
						skill_reqs = list(GATE1)
					Life_Gate
						sindex = GATE3
						cost = 1250
						skill_reqs = list(GATE2)
					Pain_Gate
						sindex = GATE4
						cost = 2000
						skill_reqs = list(GATE3)
					Limit_Gate
						sindex = GATE5
						cost = 1500
						skill_reqs = list(GATE4)
					View_Gate
						sindex = GATE6
						cost = 1500
						skill_reqs = list(GATE5)
					Wonder_Gate
						sindex = GATE7
						cost = 1250
						skill_reqs = list(GATE6)
					Death_Gate
						sindex = GATE8
						cost = 1000
						skill_reqs = list(GATE7)
				genjutsu
				/*
					Darkness
						sindex = DARKNESS_GENJUTSU
						cost = 1700
						skill_reqs = list(PARALYZE_GENJUTSU)
				*/
					Fear
						sindex = PARALYZE_GENJUTSU
						cost = 1000

					Temple_of_Nirvana
						sindex = SLEEP_GENJUTSU
						cost = 1300
						skill_reqs = list(PARALYZE_GENJUTSU)
				/*
					Shackling_Pillar
						sindex = STAKES_GENJUTSU
						cost = 1500
				*/
					Crow
						sindex = CROW
						cost = 2000

					Sly_Mind
						sindex = SLY_MIND
						cost = 2300

					Tree_Binding
						sindex = TREE_BIND
						cost = 2000

				taijutsu
					Lion_Combo
						sindex = LION_COMBO
						cost = 1400
					Front_Lotus
						sindex = FRONT_LOTUS
						cost = 2000
						skill_reqs = list(LION_COMBO)
					Shadow_Dance
						sindex = SHADOW_DANCE
						cost = 2500
						skill_reqs = list(LION_COMBO)
					Achiever_of_Nirvana_Fist
						cost = 400
						sindex = NIRVANA_FIST
					Dynamic_Entry
						sindex = DYNAMIC_ENTRY
						cost = 1000
						skill_reqs = list(NIRVANA_FIST)
					Leaf_Whirlwind
						cost = 800
						sindex = LEAF_WHIRLWIND
					Leaf_Great_Whirlwind
						cost = 1300
						sindex = LEAF_GREAT_WHIRLWIND
						skill_reqs = list(LEAF_WHIRLWIND)
					Leaf_Gale
						cost = 1800
						sindex = LEAF_GALE
						skill_reqs = list(LEAF_GREAT_WHIRLWIND)
					Morning_Peacock
						cost = 1800
						sindex = MORNING_PEACOCK
						skill_reqs = list(GATE6)
				weapons
					Manipulate_Advancing_Blades
						sindex = MANIPULATE_ADVANCING_BLADES
						cost = 1000
					Shuriken_Shadow_Clone
						sindex = SHUIRKEN_KAGE_BUNSHIN
						cost = 1300
						skill_reqs = list(KAGE_BUNSHIN)
					Exploding_Note
						sindex = EXPLODING_NOTE
						cost = 800
					Windmill_Shuriken
						sindex = WINDMILL_SHURIKEN
						cost = 600
					Shadow_Windmill_Shuriken
						sindex = SHADOW_WINDMILL_SHURIKEN
						cost = 900
						skill_reqs = list(WINDMILL_SHURIKEN)
					Exploding_Kunai
						sindex = EXPLODING_KUNAI
						cost = 600
					Triple_Exploding_Kunai
						sindex = TRIPLE_EXPLODING_KUNAI
						cost = 900
						skill_reqs = list(EXPLODING_KUNAI)
					Twin_Rising_Dragons
						sindex = TWIN_RISING_DRAGONS
						cost = 2500
					Dancing_Blade
						sindex = DANCING_BLADE
						cost = 1500
					Iai_Beheading
						sindex = IAI_BEHEADING
						cost = 1200
					Instant
						sindex = INSTANT_SLASH
						cost = 1800
						skill_reqs = list(IAI_BEHEADING)
				Body_Flicker
					sindex = SHUNSHIN
					cost = 50
				Body_Replacement
					sindex = KAWARIMI
					cost = 100
				Exploding_Body_Replacement
					sindex = EXPLODING_KAWARIMI
					cost = 750
					skill_reqs = list(KAWARIMI)
				Rasengan
					sindex = RASENGAN
					cost = 1500
				Large_Rasengan
					sindex = OODAMA_RASENGAN
					cost = 2500
					skill_reqs = list(RASENGAN)
				Camouflaged_Hiding
					sindex = CAMOFLAGE_CONCEALMENT
					cost = 1200
				Chakra_Leech
					sindex = CHAKRA_LEECH
					cost = 1700
				Transform
					sindex = HENGE
					cost = 50
			medical
				Healing
					sindex = MEDIC
					cost = 2000
				Delicate_Extraction
					sindex = DELICATE_EXTRACTION
					cost = 500
					skill_reqs = list(MEDIC)
				Poison_Mist
					sindex = POISON_MIST
					cost = 1500
					skill_reqs = list(MEDIC)
				Poisoned_Needles
					sindex = POISON_NEEDLES
					cost = 1500
					skill_reqs = list(POISON_MIST)
				Chakra_Scalpel
					sindex = MYSTICAL_PALM
					cost = 1000
					skill_reqs = list(MEDIC)
				Cherry_Blossom_Impact
					sindex = CHAKRA_TAI_RELEASE
					cost = 1700
					skill_reqs = list(MEDIC)
				Chakra_Enhancement
					sindex = CHAKRA_ENHANCEMENT
					cost = 1800
					skill_reqs = list(MEDIC,CHAKRA_TAI_RELEASE)
				Menacing_Palm
					sindex = MENACING_PALM
					cost = 1200
					skill_reqs = list(MEDIC)
				Creation_Rebirth
					sindex = PHOENIX_REBIRTH
					cost = 2500
					skill_reqs = list(IMPORTANT_BODY_PTS_DISTURB, CHAKRA_TAI_RELEASE)
				Body_Disruption_Stab
					sindex = IMPORTANT_BODY_PTS_DISTURB
					cost = 1000
					skill_reqs = list(MYSTICAL_PALM)
				eye_extract
					sindex = EYE_EXTRACT
					cost = 1500
					skill_reqs = (MEDIC)
				sharingan_implant
					sindex = SHARINGAN_IMPLANT
					cost = 1000
					skill_reqs = (EYE_EXTRACT)
				byakugan_implant
					sindex = BYAKUGAN_IMPLANT
					cost = 1000
					skill_reqs = (EYE_EXTRACT)
