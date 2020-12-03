skill
	hyuuga
		copyable = 0




		byakugan
			id = BYAKUGAN
			name = "Byakugan"
			description = "Allows you to use most Hyuuga skills, and boosts your ability to react to unexpected threats."
			icon_state = "byakugan"
			default_chakra_cost = 80
			default_cooldown = 0//240



	/*	*	IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.byakugan)
						Error(user, "Byakugan is already active")
						return 0*/


			Cooldown(mob/user)
				return default_cooldown


			Use(mob/user)
				var/buffcon=round(user.con*0.30)
				var/buffrfx=round(user.rfx*0.30)
				if(user.byakugan)
					user.see_infrared = 0
					user.byakugan = 0
					user.combat("Your Byakugan deactivates.")
					user.conbuff-=round(buffcon)
					user.rfxbuff-=round(buffrfx)
					user.Affirm_Icon()
					user.Load_Overlays()

					if(user.gentlefist)
						user.gentlefist=0
						user.overlays-='icons/hakkehand.dmi'
						user.special=0
					if(user.twinlion>=1)
						user.twinlion=0
						user.overlays-='icons/twinl.dmi'
						user.Affirm_Icon()
					ChangeIconState("byakugan")
					for(var/obj/trigger/byakuugan_icon/T in user.triggers)
						if(T) user.RemoveTrigger(T)

				else
					viewers(user) << output("[user]: Byakugan!", "combat_output")
					user.byakugan=1
					user.see_infrared = 1
					user.conbuff+=round(buffcon)
					user.rfxbuff+=round(buffrfx)
					ChangeIconState("byakugan_cancel")
					user.Affirm_Icon()
					user.Load_Overlays()

					var/obj/trigger/byakuugan_icon/T = new/obj/trigger/byakuugan_icon
					user.AddTrigger(T)

/*					spawn(Cooldown(user)*10)
						if(user)
							user.byakugan=0
							user.see_infrared = 0
							user.combat("The Byakugan wore off")
							if(user.gentlefist==1)
								user.gentlefist=0
								user.overlays-='icons/hakkehand.dmi'
								user.special=0
								user.Load_Overlays()*/




		kaiten
			id = KAITEN
			name = "Eight Trigrams Palm: Turning the Tide"
			description = "Creates a barrier of rapidly spinning chakra."
			icon_state = "kaiten"
			default_chakra_cost = 120
			default_cooldown = 30
			stamina_damage_fixed = list(100, 100)
			stamina_damage_con = list(50, 50)



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.byakugan)
						Error(user, "Byakugan is required to use this skill")
						return 0


			Use(mob/human/user)
				var/obj/b1=new/obj/kbl(locate(user.x,user.y,user.z))
				var/obj/b2=new/obj/kbr(locate(user.x,user.y,user.z))
				var/obj/b3=new/obj/ktl(locate(user.x,user.y,user.z))
				var/obj/b4=new/obj/ktr(locate(user.x,user.y,user.z))
				var/obj/b5=new/obj/kta(locate(user.x,user.y,user.z))
				var/obj/b6=new/obj/ktb(locate(user.x,user.y,user.z))
				var/obj/b7=new/obj/ktc(locate(user.x,user.y,user.z))
				var/obj/b8=new/obj/ktd(locate(user.x,user.y,user.z))
				var/obj/b9=new/obj/kte(locate(user.x,user.y,user.z))
				spawn()AOExk(user.x,user.y,user.z,2,100+150*user.ControlDamageMultiplier(),30,user,0,1,1)
				user.kaiten=1
				user.Timed_Stun(32)
				user.Protect(32)
				sleep(30)
				user.kaiten=0
				b1.loc = null
				b2.loc = null
				b3.loc = null
				b4.loc = null
				b5.loc = null
				b6.loc = null
				b7.loc = null
				b8.loc = null
				b9.loc = null





		trigrams_64_palms
			id = HAKKE_64
			name = "Eight Trigrams: 64 Palms"
			description = "Blocks off all of your enemy's chakra with precise strikes."
			icon_state = "64 palms"
			default_chakra_cost = 500
			default_cooldown = 120
			face_nearest = 1
			stamina_damage_fixed = list(1500, 1500)
			stamina_damage_con = list(500, 500)



			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/player/etarget = user.NearestTarget()
					if(!etarget)
						for(var/mob/human/M in ohearers(1,user))
							if(!M.ko && !M.IsProtected())
								etarget=M
					else
						var/distance = get_dist(user, etarget)
						if(etarget && distance > 1)
							Error(user, "Target too far ([distance]/1 tiles)")
							return 0
					if(!etarget || (etarget && etarget.chambered))
						Error(user, "No Valid Target")
						return 0
					if(!user.byakugan)
						Error(user, "Byakugan is required to use this skill")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Eight Trigrams: 64 Palms!", "combat_output")

				var/mob/human/player/etarget = user.NearestTarget()
				if(!etarget)
					for(var/mob/human/M in ohearers(1,user))
						if(!M.ko && !M.IsProtected())
							etarget=M
				if(etarget && !etarget.ko)
					etarget = etarget.Replacement_Start(user)
					spawn() Hakke_Circle(user,etarget)
					sleep(10)
					if((etarget in ohearers(1, user)) && !etarget.ko)
						user.FaceTowards(etarget)
						spawn() user.Taijutsu(etarget)
						user.Hakke_Pwn(etarget)
						if(etarget && user)
							etarget.curchakra=0
							etarget.ChakraBlock(60)
							etarget.Damage(1500+user.ControlDamageMultiplier()*500,0,user,"64 Palms","Normal")
							spawn()etarget.Hostile(user)
							spawn(5) if(etarget) etarget.Replacement_End()
				else
					Hakke_Circle(user,0)




		gentle_fist
			id = GENTLE_FIST
			name = "Gentle Fist"
			description = "Allows your normal hits to drain your enemy's chakra and do internal damage."
			icon_state = "gentle_fist"
			default_chakra_cost = 100
			default_cooldown = 30



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.byakugan)
						Error(user, "Byakugan is required to use this skill")
						return 0
					if(user.gentlefist)
						Error(user, "Gentle Fist is already active")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Gentle Fist!", "combat_output")
				user.gentlefist=1
				user.overlays+='icons/hakkehand.dmi'
				user.special=/obj/hakkehand


		twin_lion
			id = TWIN_LION
			name = "Twin Lion"
			description = "Allows your normal hits to drain your enemy's chakra and do internal damage."
			icon_state = "Lion"
			default_chakra_cost = 100
			default_cooldown = 30



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.byakugan)
						Error(user, "Byakugan is required to use this skill")
						return 0
					if(user.twinlion)
						Error(user, "Twin Lions is already active")
						return 0
					if(user.gentlefist)
						Error(user, "Gentlefist cant be used with this skill active")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Twin Lion!", "combat_output")
				user.twinlion=1
				user.overlays+='icons/twinl.dmi'
				//user.special=/obj/hakkehand


		chidori_current
			id = chidori_current
			name = "Chidori Current"
			icon_state = 'mouse_dome.dmi'
			default_chakra_cost = 200
			default_cooldown = 10
			stamina_damage_fixed = list(100, 100)
			stamina_damage_con = list(50, 50)


			Use(mob/human/user)
				var/obj/b1=new/obj/chidori_current(locate(user.x,user.y,user.z))
	//			var/time = 4

				charge2 = 1
				spawn()
					user.Begin_Stun()
					while(charge2 && user.curchakra >= 200)
						user.curchakra-=200
						//user.Begin_Stun()
						user.icon_state="Throw2"
						AOEcc(user.x,user.y,user.z,2,100+150*user.ControlDamageMultiplier(),(50+25*user.ControlDamageMultiplier()),1,user,0,1,0)
						//time--
						sleep(1)
					if(!charge2 || user.curchakra < 200)
						user.End_Stun()
						b1.loc=null
						user.icon_state=""

/*				user.Timed_Stun(32)
				user.Protect(32)
				sleep(30)
				b1.loc = null*/


		trigrams_128_palms
			id = HAKKE_128
			name = "Eight Trigrams: 128 Palms"
			description = "Blocks off all of your enemy's chakra with precise strikes."
			icon_state = "64 palms"
			default_chakra_cost = 500
			default_cooldown = 120
			face_nearest = 1
			stamina_damage_fixed = list(3000, 3000)
			stamina_damage_con = list(1000, 1000)



			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/player/etarget = user.NearestTarget()
					if(!etarget)
						for(var/mob/human/M in ohearers(2,user))
							if(!M.ko && !M.IsProtected())
								etarget=M
					else
						var/distance = get_dist(user, etarget)
						if(etarget && distance > 2)
							Error(user, "Target too far ([distance]/2 tiles)")
							return 0
					if(!etarget || (etarget && etarget.chambered))
						Error(user, "No Valid Target")
						return 0
					if(!user.byakugan)
						Error(user, "Byakugan is required to use this skill")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Eight Trigrams: 128 Palms!", "combat_output")

				var/mob/human/player/etarget = user.NearestTarget()
				if(!etarget)
					for(var/mob/human/M in ohearers(2,user))
						if(!M.ko && !M.IsProtected())
							etarget=M
				if(etarget && !etarget.ko)
					etarget = etarget.Replacement_Start(user)
					spawn() Hakke_Circle(user,etarget)
					sleep(10)
					if((etarget in ohearers(2, user)) && !etarget.ko)
						user.FaceTowards(etarget)
						spawn() user.Taijutsu(etarget)
						user.Hakke_Pwn2(etarget)
						if(etarget && user)
							etarget.curchakra=0
							etarget.ChakraBlock(120)
							etarget.Damage(3000+user.ControlDamageMultiplier()*1000,0,user,"64 Palms","Normal")
							spawn()etarget.Hostile(user)
							spawn(5) if(etarget) etarget.Replacement_End()
				else
					Hakke_Circle(user,0)


mob/human/proc
	ChakraBlock(num)
		chakrablocked++
		spawn(num*10) if(src) chakrablocked--
