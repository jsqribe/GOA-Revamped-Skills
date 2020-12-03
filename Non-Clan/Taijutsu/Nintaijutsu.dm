mob/var
	lightning_armor=0

	player_target=0

skill
	nintaijutsu
		copyable = 0


		ligar_bomb
			id = LIGAR_BOMB
			name = "Ligar Bomb"
			icon_state = "ligarbomb"
			default_chakra_cost = 400
			default_cooldown = 80

			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/etarget=user.MainTarget()
					var/distance = get_dist(user, etarget)
					if(distance > 3)
						Error(user, "Target too far ([distance]/3 tiles)")
						return 0
	/*				if(!user.lightning_armor)
						Error(user, "Lightning Armor must be activated")
						return 0*/


			Use(mob/human/user)
				var/mob/human/etarget=user.MainTarget()
				if(etarget)
					flick("Bomb2",user)
					etarget.Begin_Stun()
					user.Begin_Stun()
					user.AppearBehind(etarget)
					etarget.pixel_y+=2
					CHECK_TICK
					etarget.pixel_y+=4
					CHECK_TICK
					etarget.pixel_y+=5
					CHECK_TICK
					etarget.pixel_y+=6
					user.icon_state="Bomb3"
					spawn(20)
					viewers(user) << output("[user]: Ligar Bomb!", "combat_output")
					flick("Bomb1",user)
					etarget.pixel_y-=2
					CHECK_TICK
					etarget.pixel_y-=4
					CHECK_TICK
					etarget.pixel_y-=5
					CHECK_TICK
					etarget.pixel_y-=6
					user.icon_state=""
					spawn(1)
						var/conmult = user.ControlDamageMultiplier()
						var/result=Roll_Against(user.con+user.strbuff-user.strneg,etarget.con+etarget.strbuff-etarget.strneg,60)
						if(etarget)
							if(result>=6)
								etarget.Damage((400 + 800*conmult),0,user)
								spawn()
									explosion(50,etarget.x,etarget.y,etarget.z,usr,1)
									spawn()Blood2(etarget,user)
									spawn()Blood2(etarget,user)
									spawn()Blood2(etarget,user)
									spawn()Blood2(etarget,user)
									etarget.Wound(rand(0, 25), 0, user)
								//	etarget.stunned=7
									etarget.Hostile(user)
							if(result==5)
								etarget.Damage((400 + 700*conmult),0,user)
								spawn()
									explosion(50,etarget.x,etarget.y,etarget.z,usr,1)
									spawn()Blood2(etarget,user)
									spawn()Blood2(etarget,user)
									spawn()Blood2(etarget,user)
									etarget.Wound(rand(0, 20), 0, user)
								//	etarget.stunned=6
									etarget.Hostile(user)
							if(result==4)
								etarget.Damage((400 + 600*conmult),0,user)
								spawn()
									explosion(50,etarget.x,etarget.y,etarget.z,usr,1)
									spawn()Blood2(etarget,user)
									spawn()Blood2(etarget,user)
									etarget.Wound(rand(0, 10), 0, user)
								//	etarget.stunned=5
									etarget.Hostile(user)
							if(result==3)
								etarget.Damage((300 + 500*conmult),0,user)
								spawn()
									explosion(50,etarget.x,etarget.y,etarget.z,usr,1)
									spawn()Blood2(etarget,user)
									etarget.Wound(rand(0, 5), 0, user)
								//	etarget.stunned=4
									etarget.Hostile(user)
							if(result==2)
								etarget.Damage((300 + 400*conmult),0,user)
								spawn()
									explosion(50,etarget.x,etarget.y,etarget.z,usr,1)
									spawn()Blood2(etarget,user)
									etarget.Wound(rand(0, 4), 0, user)
								//	etarget.stunned=4
									etarget.Hostile(user)
							if(result==1)
								etarget.Damage((300 + 300*conmult),0,user)
								spawn()
									explosion(50,etarget.x,etarget.y,etarget.z,usr,1)
									spawn()Blood2(etarget,user)
									etarget.Wound(rand(0, 2), 0, user)
									//etarget.stunned=4
									etarget.Hostile(user)
					spawn(5)
						var/conmult = user.ControlDamageMultiplier()
						var/mob/human/target = user.NearestTarget()
						//etarget.stunned=10
						var/obj/s = new
						s.icon = 'icons/static.dmi'
						flick("on",s)
						target.icon_state="Hurt"
						spawn()
							spawn()Lightning(etarget.x+1,etarget.y,etarget.z,30)
							spawn()Lightning(etarget.x-1,etarget.y,etarget.z,30)
							spawn()Lightning(etarget.x,etarget.y+1,etarget.z,30)
							spawn()Lightning(etarget.x,etarget.y-1,etarget.z,30)
							spawn()Lightning(etarget.x+1,etarget.y+1,etarget.z,30)
							spawn()Lightning(etarget.x-1,etarget.y+1,etarget.z,30)
							spawn()Lightning(etarget.x+1,etarget.y-1,etarget.z,30)
							spawn()Lightning(etarget.x-1,etarget.y-1,etarget.z,30)
						spawn(2)
							spawn()Lightning(etarget.x+2,etarget.y,etarget.z,30)
							spawn()Lightning(etarget.x-2,etarget.y,etarget.z,30)
							spawn()Lightning(etarget.x,etarget.y+2,etarget.z,30)
							spawn()Lightning(etarget.x,etarget.y-2,etarget.z,30)
							spawn()Lightning(etarget.x+2,etarget.y+2,etarget.z,30)
							spawn()Lightning(etarget.x-2,etarget.y+2,etarget.z,30)
							spawn()Lightning(etarget.x+2,etarget.y-2,etarget.z,30)
							spawn()Lightning(etarget.x-2,etarget.y-2,etarget.z,30)
							spawn()Lightning(etarget.x+2,etarget.y+1,etarget.z,30)
							spawn()Lightning(etarget.x-1,etarget.y+2,etarget.z,30)
							spawn()Lightning(etarget.x+1,etarget.y-2,etarget.z,30)
							spawn()Lightning(etarget.x-2,etarget.y-1,etarget.z,30)
							spawn()Lightning(etarget.x+2,etarget.y-1,etarget.z,30)
							spawn()Lightning(etarget.x-2,etarget.y+1,etarget.z,30)
							spawn()Lightning(etarget.x+1,etarget.y+2,etarget.z,30)
							spawn()Lightning(etarget.x-1,etarget.y-2,etarget.z,30)
						spawn()AOExk(etarget.x,etarget.y,etarget.z,2,(50+100*conmult),30,user,0,1.5,1)
						etarget.Knockback(2,user.dir)
						Lightning(etarget.x,etarget.y,etarget.z,30)

						spawn()etarget.Hostile(user)
						etarget.End_Stun()
						user.End_Stun()
						flick("off",s)
						etarget.icon_state=""


		lariat
			id = LARIAT
			name = "Lariat"
			icon_state = "lariat"
			description = "You put all your strenght into your arm and throw yourself at you enemies neck to finish him in 1 attack."
			stamina_damage_fixed = list(1000, 1000)
			stamina_damage_con = list(0, 0)
			default_chakra_cost = 100
			default_stamina_cost = 200
			default_cooldown = 35

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.NearestTarget()
				if(. && target)
					var/distance = get_dist(user, target)
					if(distance > 3&&!target.player_target)
						Error(user, "Target too far ([distance]/3 tiles)")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Lariat!", "combat_output")
				var/mob/human/etarget = user.MainTarget()
				flick("PunchA-1",user)

				if(etarget)
					if(etarget.player_target)
						etarget.player_target=0

				else return

				if(user&&etarget)

					user.dir=etarget.loc
					user.AppearBefore(etarget)
					spawn(3) user.AppearBehind(etarget)

					var/result=Roll_Against(user.str+user.strbuff-user.strneg,etarget.str+etarget.strbuff-etarget.strneg,60)

					if(etarget)
						if(result>=6)
							etarget.Damage(1800,0,user)
							spawn()Blood2(etarget,user)
							etarget.Wound(rand(0, 2), 0, user)
							etarget.movepenalty+=3
						if(result==5)
							etarget.Damage(1500,0,user)
							spawn()Blood2(etarget,user)
							etarget.Wound(rand(0, 1), 0, user)
						if(result==4)
							etarget.Damage(1200,0,user)
							spawn()Blood2(etarget,user)
							etarget.Wound(rand(0, 1), 0, user)
						if(result==3)
							etarget.Damage(1000,0,user)
							spawn()Blood2(etarget,user)

						if(result==2)
							etarget.Damage(800,0,user)

						if(result==1)
							etarget.Damage(600,0,user)

						spawn()etarget.Hostile(user)


		lightning_release_armor
			id = LIGHTNING_ARMOR
			name = "Nintaijutsu: Lightning Release Armor"
			icon_state = "lightning_armor"
			description = "You create a lightning armor to increase your fighting stats."
			default_chakra_cost = 100
			default_cooldown = 280

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.lightning_armor)
						Error(user, "This jutsu is already active")
						return 0
					if(user.ironskin)
						Error(user, "Earth: Iron Skin is already active.")
						return 0

			Use(mob/user)
				if(user.gate)
					user.combat("[usr] closes the gates.")
					user.CloseGates()
				viewers(user) << output("[user]: Lightning Armor!", "combat_output")
				user.lightning_armor=1

				var/buffcon=round(user.con*0.25)
				var/buffstr=round(user.str*0.25)

				user.strbuff+=buffstr
				user.conbuff+=buffcon
				user.Affirm_Icon()

				spawn(Cooldown(user)*10)
					if(!user) return
					user.conbuff-=round(buffcon)
					user.strbuff-=round(buffstr)

					user.lightning_armor=0

					user.Affirm_Icon()


					user.combat("The lightning Release Armor wore off.")


		lightning_oppression_horizontal
			id = HORIZONTAL_OPPRESSION
			name = "Nintaijutsu: Lightning Oppression Horizontal"
			icon_state = "oppression"
			description = "You perform a simple backhanded horizontal chop against his opponent, which is powerful enough to snap even the bones."
			stamina_damage_fixed = list(200, 200)
			stamina_damage_con = list(300, 300)
			default_stamina_cost = 200
			default_cooldown = 15

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.NearestTarget()
				if(. && target)
					var/distance = get_dist(user, target)
					if(!user.NearestTarget())
						Error(user, "No Target")
						return 0
					if(distance > 2&&!target.player_target)
						Error(user, "Target too far ([distance]/2 tiles)")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning Oppression Horizontal!", "combat_output")

				var/mob/human/x = user.MainTarget()

			/*	if(x.player_target&&x)
					x.player_target=0*/


				user.AppearBehind(x)
				flick("PunchA-1",user)

				var/generate = pick(1,3)

				if(generate==1)
					x.Damage(rand(5,200)*user.ControlDamageMultiplier()+300,0,user)
					x.Knockback(4,user.dir)
					x.Wound(rand(0, 1), 0, user)
					x.movepenalty+=4
					spawn(6) user.AppearBehind(x)
				if(generate>=2)
					x.Damage(rand(20,150)*user.ControlDamageMultiplier()+300,0,user)
					x.movepenalty+=4
					x.icon_state="hurt"
					spawn(10) x.icon_state=""

				if(x&&user) spawn()x.Hostile(user)


		lightning_release_armor_2nd
			id = LIGHTNING_ARMOR_2ND
			name = "Lightning Release Armor 2nd State"
			icon_state = "lightning_armor_2nd"
			description = "Lightning Armor strongest state. In this sate your speed can be compared even to Yondaime Hokage speed."
			default_chakra_cost = 500
			default_cooldown = 160

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.lightning_armor)
						Error(user, "You need lightning armor on to activate this jutsu")
						return 0
					if(user.lightning_armor>=2)
						Error(user, "This jutsu is already active")
						return 0
					if(user.ironskin)
						Error(user, "Earth: Iron Skin is already active.")
						return 0

			Use(mob/user)
				if(user.gate)
					user.combat("[usr] closes the gates.")
					user.CloseGates()
				viewers(user) << output("[user]: Lightning Release Armor 2nd State!", "combat_output")

				usr.lightning_armor=2

				var/buffstr=round(user.str*0.05)
				var/buffcon=round(user.con*0.05)
				user.strbuff+=buffstr
				user.conbuff+=buffcon



				user.Affirm_Icon()

				spawn(Cooldown(user)*5)
					if(!user) return

				user.strbuff-=round(buffstr)
				user.conbuff-=round(buffcon)
				//user.lightning_armor=0
				user.Affirm_Icon()
				if(user.lightning_armor>=1)
					user.lightning_armor=0

					user.combat("The lightning Release Armor wore off.")


		tiger
			id=LIGHTNING_OPPRESSION_HORIZONTAL
			name="Horizontal Lightning Oppression"
			icon_state="hlo"
			default_stamina_cost = 1000
			default_cooldown = 300

			var canUse = 1

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.NearestTarget()
				if(. && target)
					var/distance = get_dist(user, target)
					if(distance > 1)
						Error(user, "Target too far ([distance]/1 tiles)")
						return 0

			Use(mob/user)
				if (canUse == 0)
					return

				//var/mob/human/target = user.NearestTarget()
				viewers(user)<<output("[user]: Horizontal Lightning Oppression!", "combat_output")
				CHECK_TICK
				//user.stunned+=2
				var/O = user.str*0.0
				var/O2 = user.rfx*0.0
				user.intiger2 = 1
				user.strbuff += O
				user.rfxbuff += O2
				spawn()
					if(user)
						while(user.intiger2)
							sleep(50)
				spawn(50)
				/*	if(user.stunned>=2)
						user.stunned = 0*/
					spawn(rand(600, 1200))
					spawn(Cooldown(user)*0.5)
					if(!user) return
					user.intiger2 = 0
					user.strbuff -= O
					user.rfxbuff -= O

					canUse = 0
					sleep(150)
					canUse = 1