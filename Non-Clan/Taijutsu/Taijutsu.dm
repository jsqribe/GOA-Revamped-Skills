skill
	taijutsu
		face_nearest = 1
		copyable = 1

		shadow_dance
			id = SHADOW_DANCE
			name = "Taijutsu: Shadow of the Dancing Leaf"
			description = "coming soon."
			icon_state = "shadow_dance"
			default_cooldown = 30


			Cooldown(mob/user)
				return default_cooldown


			Use(mob/user)
				if(user.shadowleaf)
					user.shadowleaf = 0
					ChangeIconState("shadow_dance")
				else
					viewers(user) << output("[user]: Shadow of the Dancing Leaf!", "combat_output")
					user.shadowleaf=1
					ChangeIconState("shadow_dance_cancel")

		leaf_gale
			id = LEAF_GALE
			name = "Taijutsu: Leaf Gale"
			description = "Swiftly kicks your enemy knocking them down."
			icon_state = "gale"
			default_stamina_cost = 600
			default_cooldown = 100

			IsUsable(mob/human/user)
				. = ..()
				if(.)
					var/mob/human/etarget = user.NearestTarget()
					var/distance = get_dist(user, etarget)
					if(distance > 3)
						Error(user, "Target too far ([distance]/1 tiles)")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Leaf Gale!", "combat_output")

				var/mob/human/etarget = user.NearestTarget()

				if(etarget)
					var/dist = get_dist(user, etarget)
					if(dist != 1)
						etarget = null
				else
					for(var/mob/human/X in get_step(user,user.dir))
						if(!X.ko && !X.IsProtected())
							etarget=X

				spawn()
					user.overlays+='icons/senpuu.dmi'
					spawn(8)
						user.overlays-='icons/senpuu.dmi'
					user.icon_state="KickA-1"
					spawn(8)
						user.icon_state=""
					sleep(4)
					user.dir=turn(user.dir,90)
					sleep(4)
					user.dir=turn(user.dir,90)

				if(etarget)
					//snd(user,'sounds/spin_kick.wav',vol=30)
					etarget = etarget.Replacement_Start(user)
					user.AppearBefore(etarget)
					user.FaceTowards(etarget)
					spawn()user.Taijutsu(etarget)
					if(!etarget.icon_state)
						flick("hurt",etarget)
					var/result=Roll_Against(user.str+user.strbuff-user.strneg,etarget.str+etarget.strbuff-etarget.strneg,60)
					switch(result)
						if(6)
							etarget.Leaf_Gale_Stun(25)
						if(5)
							etarget.Leaf_Gale_Stun(20)
						if(4)
							etarget.Leaf_Gale_Stun(15)
						if(3)
							etarget.Leaf_Gale_Stun(10)
						if(2)
							etarget.Leaf_Gale_Stun(5)
						if(1)
							etarget.Leaf_Gale_Stun(0)

					spawn()
						if(etarget)
							etarget.Hostile(user)
					spawn(5) if(etarget) etarget.Replacement_End()

				user.Timed_Stun(2)



		dynamic_entry
			id = DYNAMIC_ENTRY
			name = "Taijutsu: Dynamic Entry"
			description = "An heavy kick right on target face."
			icon_state = "dynamic"
			default_stamina_cost = 800
			default_cooldown = 90
			stamina_damage_fixed = list(500, 2500)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(0, 0)
			wound_damage_con = list(0, 0)



			Use(mob/human/user)
				viewers(user) << output("[user]: Dynamic Entry!", "combat_output")

				var/str_mod = user.str+user.strbuff-user.strneg
				for(var/steps = 1 to 4)

					flick("KickA-1", user)
					var
						old_loc = user.loc
						mob/enemy = locate() in get_step(user,user.dir)

					step(user,user.dir)

					if(old_loc == user.loc && enemy)
						if(enemy)
							enemy = enemy.Replacement_Start(user)
						user.loc = enemy.loc
						enemy.Damage(round((300+str_mod)*rand(1.5,3)),0,user,"Dynamic Entry","Taijutsu")
						enemy.Knockback(6,user.dir)
						spawn()user.Taijutsu(enemy)

					spawn()
						if(enemy)
							enemy.Hostile(user)
					spawn(5) if(enemy) enemy.Replacement_End()


				user.frozen++
				sleep(2)
				if(user)
					user.frozen--


		leaf_whirlwind
			id = LEAF_WHIRLWIND
			name = "Taijutsu: Leaf Whirlwind"
			description = "Swiftly kicks your enemy knocking them away. Damage decreases depending on your range from your opponent."
			icon_state = "leaf_whirlwind"
			default_stamina_cost = 100
			default_cooldown = 20
			stamina_damage_fixed = list(0, 700)
			stamina_damage_con = list(0, 0)
			stamina_damage_str = 1

			IsUsable(mob/human/user)
				. = ..()
				if(.)
					if(Issmoke(user.loc))
						return 0
					var/mob/human/etarget = user.NearestTarget()
					if(!etarget)
						for(var/mob/human/M in get_step(user,user.dir))
							etarget=M
					if(etarget)
						return 1
					else
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Leaf Whirlwind!", "combat_output")

				var/mob/human/etarget = user.NearestTarget()
				if(!etarget)
					for(var/mob/human/M in get_step(user,user.dir))
						etarget=M

				spawn()
					user.overlays+='icons/senpuu.dmi'
					spawn(8)
						user.overlays-='icons/senpuu.dmi'
					user.icon_state="KickA-1"
					spawn(8)
						user.icon_state=""
					sleep(4)
					user.dir=turn(user.dir,90)
					sleep(4)
					user.dir=turn(user.dir,90)

				if(etarget)
					var/dmg_mult = 1
					switch(get_dist(user, etarget))
						if(0,1)	dmg_mult = 1.00
						if(2)	dmg_mult = 0.90
						if(3)	dmg_mult = 0.80
						if(4)	dmg_mult = 0.70
						else	dmg_mult = 0.50
					//snd(user,'sounds/spin_kick.wav',vol=30)
					etarget = etarget.Replacement_Start(user)
					user.AppearBefore(etarget)
					user.FaceTowards(etarget)
					spawn()user.Taijutsu(etarget)
					if(!etarget.icon_state)
						flick("hurt",etarget)
					var/result=Roll_Against(user.str+user.strbuff-user.strneg,etarget.str+etarget.strbuff-etarget.strneg,60)
					var/str_mod = user.str+user.strbuff-user.strneg
					if(result>=6)
						etarget.Damage(round((700+str_mod)*dmg_mult),0,user,"Leaf Whirlwind","Normal")
						etarget.Knockback(6,user.dir)
					if(result==5)
						etarget.Damage(round((550+str_mod)*dmg_mult),0,user,"Leaf Whirlwind","Normal")
						etarget.Knockback(5,user.dir)
					if(result==4)
						etarget.Damage(round((400+str_mod)*dmg_mult),0,user,"Leaf Whirlwind","Normal")
						etarget.Knockback(4,user.dir)
					if(result==3)
						etarget.Damage(round((300+str_mod)*dmg_mult),0,user,"Leaf Whirlwind","Normal")
						etarget.Knockback(3,user.dir)
					if(result==2)
						etarget.Damage(round((150+str_mod)*dmg_mult),0,user,"Leaf Whirlwind","Normal")
						etarget.Knockback(2,user.dir)
					if(result==1)
						etarget.Damage(round((100+str_mod)*dmg_mult),0,user,"Leaf Whirlwind","Normal")
						etarget.Knockback(1,user.dir)

					spawn()
						if(etarget)
							etarget.Hostile(user)
					spawn(5) if(etarget) etarget.Replacement_End()

				user.Timed_Stun(2)


		leaf_great_whirlwind
			id = LEAF_GREAT_WHIRLWIND
			name = "Taijutsu: Leaf Great Whirlwind"
			description = "Swiftly kick your enemies three times. The first is a homing attack. The other two are area attacks around the user."
			icon_state = "leaf_great_whirlwind"
			default_stamina_cost = 250
			default_cooldown = 50
			stamina_damage_fixed = list(0, 350)
			stamina_damage_con = list(0, 0)
			stamina_damage_str = 2

			IsUsable(mob/human/user)
				. = ..()
				if(.)
					if(Issmoke(user.loc))
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Leaf Great Whirlwind!", "combat_output")

				var/mob/human/etarget = user.NearestTarget()
				if(!etarget)
					for(var/mob/human/M in get_step(user,user.dir))
						etarget=M

				//user.usedelay += round(total_times/2)

				var/total_times = 3
				var/times = total_times

				user.Timed_Move_Stun(total_times*4,1)
				while(user && !user.ko && times > 0)

					spawn()
						user.overlays+='icons/senpuu.dmi'
						spawn(8)
							user.overlays-='icons/senpuu.dmi'
						user.icon_state="KickA-1"
						spawn(8)
							user.icon_state=""
						sleep(4)
						//snd(user,'sounds/spin_kick.wav',vol=30)
						user.dir=turn(user.dir,90)
						sleep(4)
						user.dir=turn(user.dir,90)
					var/list/hit = list()
					if(times == total_times && etarget)
						if(!(user.AppearBefore(etarget)))
							var/list/xmod = list(0,0,1,1,1,-1,-1,-1)
							var/list/ymod = list(1,-1,0,1,-1,0,1,-1)
							var/list/tries = shuffle(list(1,2,3,4,5,6,7,8))
							var/attempts = 8
							var/success = 0
							while(user && attempts > 0 && !success)
								success = user.AppearAt(etarget.x+xmod[tries[attempts]],etarget.y+ymod[tries[attempts]],etarget.z, "", nofollow=0)
								attempts--
							if(!success)
								break
						user.FaceTowards(etarget)
					hit = oview(1,user)
					for(var/mob/m in hit)
						if(m!=user && !m.ko)
							m = m.Replacement_Start(user)
							spawn()user.Taijutsu(m)
							if(m && !m.icon_state)
								flick("hurt",m)
							var/result=Roll_Against(user.str+user.strbuff-user.strneg,m.str+m.strbuff-m.strneg,60)
							var/str_mod = user.str+user.strbuff-user.strneg
							var/damage
							var/knockback
							if(result>=6)
								damage = 800
								knockback = 2
							else if(result==5)
								damage = 650
								knockback = 2
							else if(result==4)
								damage = 500
								knockback = 2
							else if(result==3)
								damage = 400
								knockback = 1
							else if(result==2)
								damage = 250
								knockback = 1
							else if(result==1)
								damage = 200
								knockback = 1
							m.Damage(round((damage+str_mod)*0.80),0,user,"Leaf Great Whirlwind","Normal")
							m.Knockback(knockback,get_dir(user,m))
							user.Timed_Move_Stun(2,1)

							spawn() m.Hostile(user)
							spawn(5) if(m) m.Replacement_End()

					if(times > 1)
						sleep(5)
					times--



		lion_combo
			id = LION_COMBO
			name = "Taijutsu: Lion Combo"
			description = "Traps your enemy with multiple hits!"
			icon_state = "lioncombo"
			default_stamina_cost = 600
			default_cooldown = 60
			stamina_damage_fixed = list(0, 2000)
			stamina_damage_con = list(0, 0)



			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/target = user.NearestTarget()
					if(!target || (target && (target.chambered || target.sandshield || target.kaiten || target.ko || target.mole)))
						Error(user, "No Valid Target")
						return 0
					var/distance = get_dist(user, target)
					if(distance > 2)
						Error(user, "Target too far ([distance]/2 tiles)")
						return 0


			Use(mob/human/user)
				var/mob/human/etarget = user.NearestTarget()
				if(!etarget) return
				user.overlays+='icons/senpuu.dmi'
				spawn(20) if(user) user.overlays-='icons/senpuu.dmi'
				sleep(15)
				if(user && !user.ko && !user.stunned && etarget && (get_dist(user, etarget) <= 2) && !(etarget.ko || etarget.chambered || etarget.sandshield || etarget.kaiten || etarget.mole))
					var/vx=etarget.x
					var/vy=etarget.y
					var/vz=etarget.z
					etarget = etarget.Replacement_Start(user)
					spawn() user.Taijutsu(etarget)

					var/result = Lion_Combo(user,etarget)

					etarget.Hostile(user)
					sleep(1)
					if(etarget && user)
						if(result>=5)
							etarget.Damage(2500*multiplier,0,user,"Lion Combo","Normal")
							//etarget.Dec_Stam(2000*multiplier,0,user)
						if(result==4)
							etarget.Damage(2000*multiplier,0,user,"Lion Combo","Normal")
							//etarget.Dec_Stam(1700*multiplier,0,user)
						if(result==3)
							etarget.Damage(1500*multiplier,0,user,"Lion Combo","Normal")
							//etarget.Dec_Stam(1400*multiplier,0,user)
						if(result==2)
							etarget.Damage(1000*multiplier,0,user,"Lion Combo","Normal")
							//etarget.Dec_Stam(1000*multiplier,0,user)
						if(result==1)
							etarget.Damage(800*multiplier,0,user,"Lion Combo","Normal")
							//etarget.Dec_Stam(700*multiplier,0,user)
						if(result<=0)
							user.combat("[etarget] managed to defend himself from all of your attacks!")
							etarget.combat("You managed to defend yourself from all of [user]'s attacks!")
							(oviewers(user)-etarget) << output("[etarget] managed to defend himself from all of [user]'s attacks!", "combat_output")
						etarget.Hostile(user)
						etarget.Replacement_End()
					if(user)
						user.layer=MOB_LAYER

		Front_Lotus
			id = FRONT_LOTUS
			name = "Taijutsu: Front Lotus"
			icon_state = "primary_lotus"
			default_stamina_cost = 1000
			default_cooldown = 120
			copyable=0

			IsUsable(mob/user)
				. = ..()
				if(.)
					var/mob/human/target = user.NearestTarget()
					if(!target || (target && (target.chambered || target.sandshield || target.kaiten || target.ko || target.mole)))
						Error(user, "No Valid Target")
						return 0
					var/distance = get_dist(user, target)
					if(distance > 4)
						Error(user, "Target too far ([distance]/4 tiles)")
						return 0

					if(!user.gate)
						Error(user, "You need to activate gates first!")
						return 0

			Use(mob/human/user)
				var/mob/human/etarget = user.NearestTarget()
				if(!etarget)
					return
				if(etarget.dzed)
					etarget.stunned=0
				var/vx=etarget.x
				var/vy=etarget.y
				var/vz=etarget.z
			//	user.overlays+='icons/senpuu.dmi'
				user.overlays+=image('icons/senpuu2.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
				user.overlays+=image('icons/senpuu2.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
				user.overlays+=image('icons/senpuu2.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
				user.overlays+=image('icons/senpuu2.dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
				user.overlays+=image('icons/senpuu2.dmi',icon_state = "5",pixel_x=0,pixel_y=32)
				user.overlays+=image('icons/senpuu2.dmi',icon_state = "6",pixel_x=32,pixel_y=32)
				spawn(20)
					if(user)
						user.overlays-=image('icons/senpuu2.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
						user.overlays-=image('icons/senpuu2.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
						user.overlays-=image('icons/senpuu2.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
						user.overlays-=image('icons/senpuu2.dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
						user.overlays-=image('icons/senpuu2.dmi',icon_state = "5",pixel_x=0,pixel_y=32)
						user.overlays-=image('icons/senpuu2.dmi',icon_state = "6",pixel_x=32,pixel_y=32)
				sleep(5)
				if(etarget && etarget.ko) return
				if(user && etarget && etarget.x==vx && etarget.y==vy && etarget.z==vz)
					spawn() user.Taijutsu(etarget)

					user.AppearBefore(etarget)
					spawn()smack(etarget,5,8)
					user.icon_state="Throw2"
			//		flick("KickA-1",user)
					if(etarget.larch)
						return
					if(!user)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						return
					if(!etarget)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						return
					var/LOx=user.x
					var/LOy=user.y
					var/LOz=user.z

					user.stunned=15
					etarget.stunned=15
					spawn()smack(etarget,5,8)
					sleep(2)
					if(!user)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.loc=locate(vx,vy,vz)
					user.AppearBefore(etarget)
					spawn()smack(etarget,5,8)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					sleep(3)
					if(!user)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					user.incombo=1
					etarget.incombo=1
					spawn()smack(etarget,5,8)
					user.x=vx
					user.y=vy
					user.z=vz
					var/obj/S=new/obj(locate(vx,vy,vz))
					S.density=0
					S.icon='icons/shadow.dmi'

					etarget.dir=SOUTH
				//	user.protected=10
				//	etarget.protected=10
					user.dir=SOUTH
					var/obj/O = new/obj(locate(vx,vy,vz))
					O.density=0
					O.icon='icons/appeartai.dmi'
					spawn(5)
						del(O)

					etarget.icon_state="hurt"
					etarget.layer=MOB_LAYER+13
					user.layer=MOB_LAYER+12
					etarget.pixel_y=3
					user.pixel_y=etarget.pixel_y
					spawn()smack(etarget,5,8)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)

					etarget.y=user.y
					var/E=50
					spawn()
						user.pixel_x = 8
						user.pixel_y += 5
					while(etarget&&user&&E>0)
						etarget.pixel_y += 4
						user.pixel_y += 4

						E-=2
						sleep(1)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return

					S.loc=locate(vx,vy,vz)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					user.dir=WEST
				//	user.icon_state="Throw1"
					etarget.overlays+=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
					etarget.overlays+=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
					user.pixel_y=etarget.pixel_y+3
					etarget.y=user.y

					user.pixel_x=8
					spawn()smack(etarget,5,8)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)

			//		flick("PunchA-1",user)
					spawn()smack(etarget,5,8)
					etarget.pixel_y+=5
					sleep(1)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					user.dir=WEST
				//	user.icon_state="Throw1"
					etarget.overlays+=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
					etarget.overlays+=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
					user.pixel_y=etarget.pixel_y+3
					etarget.y=user.y

					user.pixel_x=8

			//		flick("PunchA-1",user)
					spawn()smack(etarget,5,8)
					etarget.pixel_y+=5
					sleep(1)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.pixel_y++
					sleep(1)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.pixel_y++
					sleep(1)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.pixel_y++
					sleep(1)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return

					user.pixel_y+=8
					user.icon_state=""
					user.pixel_y=etarget.pixel_y-3
					etarget.y=user.y
					user.pixel_x=8
				//	flick("KickA-1",user)
					spawn()smack(etarget,5,8)
					spawn()smack(etarget,2,4)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					sleep(4)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.layer=MOB_LAYER+12
					user.layer=MOB_LAYER+13
					spawn()smack(etarget,5,8)
			//		flick("KickA-2",user)
					spawn()smack(etarget,5,6)
					sleep(4)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					user.pixel_x=0
					user.dir=NORTH
					user.pixel_y=etarget.pixel_y+6
					etarget.y=user.y
					user.pixel_x=0
			//		flick("KickA-1",user)
					spawn()smack(etarget,5,8)
					spawn() if(etarget) smack(etarget,0,8)
					sleep(2)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.pixel_y-=2
					sleep(2)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.pixel_y-=2
					etarget.layer=MOB_LAYER+13
					user.layer=MOB_LAYER+12
					spawn()smack(etarget,5,8)

					user.dir=EAST
					user.pixel_y=etarget.pixel_y+9
					etarget.y=user.y
					user.pixel_x=-4
				//	flick("KickA-2",user)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					sleep(4)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.layer=MOB_LAYER+12
					user.layer=MOB_LAYER+13
					spawn()smack(etarget,5,8)

			//		flick("KickA-1",user)
					spawn()smack(etarget,-2,4)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					etarget.overlays+=image('icons/front.dmi',icon_state = "3",pixel_x=-16,pixel_y=0)
					etarget.overlays+=image('icons/front.dmi',icon_state = "4",pixel_x=16,pixel_y=0)
					etarget.overlays+=image('icons/front.dmi',icon_state = "5",pixel_x=-16,pixel_y=32)
					etarget.overlays+=image('icons/front.dmi',icon_state = "6",pixel_x=16,pixel_y=32)
					etarget.overlays+=image('icons/front.dmi',icon_state = "7",pixel_x=-16,pixel_y=64)
					etarget.overlays+=image('icons/front.dmi',icon_state = "8",pixel_x=16,pixel_y=64)
					sleep(2)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					etarget.pixel_y-=2
					etarget.layer=MOB_LAYER+13
					user.layer=MOB_LAYER+12
					spawn()smack(etarget,5,8)

					user.dir=EAST
					user.pixel_y=etarget.pixel_y+9
					etarget.y=user.y
					user.pixel_x=-4
				//	flick("KickA-2",user)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					spawn()smack(etarget,-5,6)
					sleep(4)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					spawn() if(etarget) etarget.Fallpwn()
					sleep(2)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						etarget.loc=locate(vx,vy,vz)
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						user.loc=locate(LOx,LOy,LOz)
						return
					user.overlays+='icons/appeartai.dmi'
					user.pixel_x=0
					user.pixel_y=0
					user.loc=locate(LOx,LOy,LOz)
					etarget.loc=locate(vx,vy,vz)
					etarget.dir=SOUTH
					user.AppearBefore(etarget)
					sleep(6)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						return
					user.overlays-='icons/appeartai.dmi'
					etarget.overlays-=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
					etarget.overlays-=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
					sleep(4)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						return
					user.protected=0
					etarget.protected=0
					sleep(2)
					if(!user)
						del(S)
						etarget.pixel_x=0
						etarget.pixel_y=0
						etarget.incombo=0
						etarget.protected=0
						etarget.icon_state=""
						etarget.stunned=0
						return
					if(!etarget)
						del(S)
						user.pixel_x=0
						user.pixel_y=0
						user.incombo=0
						user.protected=0
						user.icon_state=""
						user.stunned=0
						return
					user.incombo=0
					user.stunned=0
					etarget.overlays-=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
					etarget.overlays-=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
					etarget.overlays-=image('icons/front.dmi',icon_state = "3",pixel_x=-16,pixel_y=0)
					etarget.overlays-=image('icons/front.dmi',icon_state = "4",pixel_x=16,pixel_y=0)
					etarget.overlays-=image('icons/front.dmi',icon_state = "5",pixel_x=-16,pixel_y=32)
					etarget.overlays-=image('icons/front.dmi',icon_state = "6",pixel_x=16,pixel_y=32)
					etarget.overlays-=image('icons/front.dmi',icon_state = "7",pixel_x=-16,pixel_y=64)
					etarget.overlays-=image('icons/front.dmi',icon_state = "8",pixel_x=16,pixel_y=64)
					user.icon_state=""
					del(S)
					var/multiplier=(user.str+user.strbuff-user.strneg)/(etarget.str+etarget.strbuff-etarget.strneg)
					var/result=Roll_Against(user.rfx+user.rfxbuff-user.rfxneg,etarget.rfx+etarget.rfxbuff-etarget.rfxneg,100)
					etarget.Hostile(user)
					sleep(1)
					if(etarget && user)
						if(result>=5)
							etarget.Damage(2000*multiplier,0,user,"Front Lotus","Normal")
							etarget.curwound+=25
							user.curwound+=25
						if(result==4)
							etarget.Damage(1700*multiplier,0,user,"Front Lotus","Normal")
							etarget.curwound+=20
							user.curwound+=20
						if(result==3)
							etarget.Damage(1400*multiplier,0,user,"Front Lotus","Normal")
							etarget.curwound+=15
							user.curwound+=15
						if(result==2)
							etarget.Damage(1100*multiplier,0,user,"Front Lotus","Normal")
							etarget.curwound+=10
							user.curwound+=10
						if(result==1)
							etarget.Damage(650*multiplier,0,user,"Front Lotus","Normal")
							etarget.curwound+=5
							user.curwound+=5
						if(result<=0)
							user.combat("[etarget] managed to defend himself from all of your attacks!")
							etarget.combat("You managed to defend yourself from all of [user]'s attacks!")
							(oviewers(user)-etarget) << output("[etarget] managed to defend himself from all of [user]'s attacks!", "combat_output")
						etarget.Hostile(user)
					if(user)
						user.layer=MOB_LAYER





		nirvana_fist
			id = NIRVANA_FIST
			name = "Taijutsu: Achiever of Nirvana Fist"
			description = "Blows your opponent back and slows their movements with a hard punch."
			icon_state = "achiever_of_nirvana_fist"
			default_stamina_cost = 250
			default_cooldown = 40
			stamina_damage_fixed = list(650, 1250)
			stamina_damage_con = list(0, 0)
			stamina_damage_str = 1



			/*Dipic: Disabled as it makes this skill too easy to land
			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.NearestTarget()
				if(. && target)
					var/distance = get_dist(user, target)
					if(distance > 1)
						Error(user, "Target too far ([distance]/1 tiles)")
						return 0
			*/


			Use(mob/human/user)
				flick("PunchA-1",user)
				viewers(user) << output("[user]: Achiever of Nirvana Fist!", "combat_output")

				var/mob/human/etarget = user.NearestTarget()
				if(etarget && get_dist(user, etarget) > 1) etarget = null
				if(!etarget)
					for(var/mob/human/X in get_step(user,user.dir))
						if(X.ko && !X.IsProtected())
							etarget = X
				if(etarget)
					etarget = etarget.Replacement_Start(user)
					spawn()smack(etarget,0,0)
					spawn()smack(etarget,-6,0)
					spawn()smack(etarget,6,0)
					var/result=Roll_Against(user.str+user.strbuff-user.strneg,etarget.str+etarget.strbuff-etarget.strneg,60)
					var/str_mod = user.str+user.strbuff-user.strneg
					if(!etarget.icon_state)
						etarget.icon_state="hurt"
					if(etarget) spawn()etarget.Hostile(user)
					if(etarget)

						if(result>=6)
							etarget.Damage(450+str_mod,0,user,"Nirvana Fist","Normal")
							spawn()
								etarget.Knockback(5,user.dir)
								etarget.Timed_Move_Stun(20)

						if(result==5)
							etarget.Damage(400+str_mod,0,user,"Nirvana Fist","Normal")
							spawn()
								etarget.Knockback(3,user.dir)
								etarget.Timed_Move_Stun(15)
						if(result==4)
							etarget.Damage(275+str_mod,0,user,"Nirvana Fist","Normal")
							spawn()
								etarget.Knockback(2,user.dir)
								etarget.Timed_Move_Stun(10)
						if(result==3)
							etarget.Damage(200+str_mod,0,user,"Nirvana Fist","Normal")
							spawn()
								etarget.Knockback(1,user.dir)
								etarget.Timed_Move_Stun(5)

						if(result==2)
							etarget.Damage(100+str_mod,0,user,"Nirvana Fist","Normal")
							etarget.Timed_Move_Stun(5)

						if(result==1)
							etarget.Damage(50+str_mod,0,user,"Nirvana Fist","Normal")

						spawn()user.Taijutsu(etarget)
						//snd(user,'sounds/jab.wav',vol=30)


					spawn()
						while(etarget.move_stun>0)
							sleep(1)
							if(!etarget)
								break
						if(etarget)
							if(!etarget.ko)
								etarget.icon_state=""
					spawn() if(etarget) etarget.Hostile(user)
					spawn(5) if(etarget) etarget.Replacement_End()









