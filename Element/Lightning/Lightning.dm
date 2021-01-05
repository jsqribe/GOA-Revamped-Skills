mob/var/chidori = 0

skill
	lightning

		copyable = 1

		raiton_element
			id = RAITON_ELEMENT
			icon_state = "raiton"
			name = "Lightning: Element Control"
			description = "Allows you to control the lighhtning element and use fast jutsu."
			stack = "false"//don't stack
			element = 1

		chidori
			id = CHIDORI
			name = "Lightning: Chidori"
			description = "Pierces through enemies with a quick charge for heavy internal damage."
			icon_state = "chidori"
			default_chakra_cost = 300
			default_cooldown = 90
			default_seal_time = 5
			stamina_damage_fixed = list(1500, 2500)
			stamina_damage_con = list(500, 650)
			wound_damage_fixed = list(0, 50)
			wound_damage_con = list(0, 0)
			cost = 1500
			skill_reqs = list(RAITON_ELEMENT)

			Use(mob/human/player/user)
				viewers(user) << output("[user]: Lightning: Chidori!", "combat_output")
				user.Timed_Stun(10)
				var/obj/x = new(locate(user.x,user.y,user.z))
				x.layer=MOB_LAYER+1
				x.icon='icons/chidori.dmi'
				x.dir=user.dir
				user.jutsu_overlay=/obj/chidori
				spawn(10)
					x.loc = null
				sleep(10)
				if(user && !user.ko)
					user.chidori=1
					user.Load_Overlays()
					user.combat("Press <b>A</b> to use Chidori on someone. If you take damage it will dissipate!")
					user.on_hit.add(src, "Cancel")



			proc
				Cancel(mob/human/player/user, mob/human/player/attacker, event/event)
					event.remove(src, "Cancel")
					if(user && user.chidori == 1)
						user.Chidori_Fail()


		chidori_spear
			id = CHIDORI_SPEAR
			name = "Lightning: Chidori Spear"
			description = "Pierces through enemies with a spear of electricity."
			icon_state = "raton_sword_form_assasination_technique"
			default_chakra_cost = 350
			default_cooldown = 150
			face_nearest = 1
			stamina_damage_fixed = list(1500, 2000)
			stamina_damage_con = list(500, 500)
			wound_damage_fixed = list(10, 20)
			wound_damage_con = list(0, 0)
			cost = 2500
			skill_reqs = list(RAITON_ELEMENT)


			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning: Chidori Spear!", "combat_output")
				var/conmult = user.ControlDamageMultiplier()

				user.Begin_Stun()

				user.overlays+='icons/ratonswordoverlay.dmi'
				//snd(user,'sounds/chidori.wav',vol=30)
				sleep(5)

				var/dir = user.dir
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					dir = get_dir(user,etarget)



				var/obj/trailmaker/o=new/obj/trailmaker/Raton_Sword()
				var/mob/result=Trail_Straight_Projectile(user.x,user.y,user.z,dir,o,14,user)
				if(result)
					//snd(user,'sounds/chidori_static2sec.wav',vol=30)
					spawn(20)
						o.loc = null
					result = result.Replacement_Start(user)
					spawn()Blood2(result,user)
					spawn()result.Hostile(user)
					result.Timed_Stun(10)
					result.Timed_Move_Stun(50)
					result.Damage(rand(1500,2000)+conmult*500,rand(5,12),user,"Lightning: Chidori Spear","Normal")
					if(istype(result,/mob/human/ironsand))
						del(result)
					spawn(5) if(result) result.Replacement_End()
					spawn(20)
						user.End_Stun()
						user.overlays-='icons/ratonswordoverlay.dmi'
				else
					user.End_Stun()
					user.overlays-='icons/ratonswordoverlay.dmi'




		chidori_current
			id = CHIDORI_CURRENT
			name = "Lightning: Chidori Current"
			description = "Creates a field of electricity surrounding you, damaging anyone near you."
			icon_state = "chidori_nagashi"
			default_chakra_cost = 100
			default_cooldown = 30
			face_nearest = 1
			stamina_damage_fixed = list(250, 400)
			stamina_damage_con = list(150, 250)
			cost = 600
			skill_reqs = list(RAITON_ELEMENT)

			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning: Chidori Current!", "combat_output")

				user.icon_state="Seal"
				user.Begin_Stun()
				user.noknock++

				var/conmult = user.ControlDamageMultiplier()

				//snd(user,'sounds/chidori_nagashi.wav',vol=30)
				if(!user.waterlogged)
					for(var/turf/x in oview(1))
						spawn()Electricity(x.x,x.y,x.z,30)
					spawn()AOEcc(user.x,user.y,user.z,1,(250+150*conmult),(50+25*conmult),30,user,0,1.5,1)
				else
					for(var/turf/x in oview(2))
						spawn()Electricity(x.x,x.y,x.z,30)
					spawn()AOEcc(user.x,user.y,user.z,2,(250+150*conmult),(50+25*conmult),30,user,0,1.5,1)
				Electricity(user.x,user.y,user.z,30)

				user.End_Stun()
				user.noknock--
				user.icon_state=""




		chidori_needles
			id = CHIDORI_NEEDLES
			name = "Lightning: Chidori Needles"
			description = "Charges needles with electricty, temporarily slowing the movements of anyone they hit."
			icon_state = "chidorisenbon"
			default_chakra_cost = 200
			default_cooldown = 30
			face_nearest = 1
			stamina_damage_fixed = list(100, 100)
			stamina_damage_con = list(50, 50)
			wound_damage_fixed = list(1, 1)
			wound_damage_con = list(0, 0)
			cost = 1500
			skill_reqs = list(RAITON_ELEMENT)


			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning: Chidori Needles!", "combat_output")
				var/eicon='icons/chidorisenbon.dmi'
				var/estate=""

				//snd(user,'sounds/chidori_static1sec.wav',vol=30)
				user.icon_state="Throw1"
				user.overlays+='icons/raitonhand.dmi'
				spawn(10)
					user.icon_state=""
					user.overlays-='icons/raitonhand.dmi'

				var/dir
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					dir = get_dir(user,etarget)
					user.dir=dir

				var/angle
				var/speed = 32
				var/spread = 9

				if(etarget)
					angle = dir2angle(dir)
				else
					angle = dir2angle(user.dir)

				var/damage = 100+50*user.ControlDamageMultiplier()


				spawn() advancedprojectile_angle(eicon, estate, user, speed, angle+spread*2, distance=10, damage=damage, wounds=1, daze=15)
				spawn() advancedprojectile_angle(eicon, estate, user, speed, angle+spread, distance=10, damage=damage, wounds=1, daze=15)
				spawn() advancedprojectile_angle(eicon, estate, user, speed, angle, distance=10, damage=damage, wounds=1, daze=15)
				spawn() advancedprojectile_angle(eicon, estate, user, speed, angle-spread, distance=10, damage=damage, wounds=1, daze=15)
				spawn() advancedprojectile_angle(eicon, estate, user, speed, angle-spread*2, distance=10, damage=damage, wounds=1, daze=15)


		four_pillar_bind
			id = FOUR_PILLAR_BIND
			name = "Lightning: Four Pillar Bind"
			description = "Four giant rock pillars are summoned around the enemy, then shoot bolts of lightning, immobilising the target and doing minimal damage to them."
			icon_state = "pillar_binding"
			default_chakra_cost = 350
			default_cooldown = 110
			default_seal_time = 10
			stamina_damage_fixed = list(40, 1000)
			stamina_damage_con = list(20, 230)
			wound_damage_fixed = list(0, 0)
			wound_damage_con = list(0, 0)
			cost = 1200
			skill_reqs = list(RAITON_ELEMENT)

			IsUsable(mob/human/user)
				if(..())
					var/mob/human/etarget = user.MainTarget()
					if(!etarget)
						Error(user, "No Target")
						return 0
					else
						return 1

			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning: Four Pillar Bind!", "combat_output")
				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/etarget = user.MainTarget()
				user.icon_state = "HandSeals"
				user.Timed_Stun(10)
				spawn(10) if(user.icon_state == "HandSeals") user.icon_state = ""
				sleep(5)//delay user jutsu use by half a second after this jutsu
				if(etarget)
					var/turf/eloc = etarget.loc
					new/obj/four_pillar(locate(eloc.x-2,eloc.y-2,eloc.z),"Left")
					new/obj/four_pillar(locate(eloc.x+2,eloc.y-2,eloc.z),"Right")
					new/obj/four_pillar(locate(eloc.x-2,eloc.y+2,eloc.z),"Left")
					new/obj/four_pillar(locate(eloc.x+2,eloc.y+2,eloc.z),"Right")
					sleep(10)
					for(var/turf/x in oview(2,eloc))
						if(!(locate(/obj/four_pillar) in x))
							spawn() Electricity(x.x,x.y,x.z,40)
					spawn()
						AOEcc(eloc.x,eloc.y,eloc.z,2,(rand(600,800)+150*conmult),(40+20*conmult),40,user,0,1.5,0)
						Electricity(eloc.x,eloc.y,eloc.z,40)

		false_darkness
			id = FALSE_DARKNESS
			name = "False Darkness"
			description = "Releases a piercing lightning attack that will home in on one to three enemies."
			icon_state = "false_darkness"
			default_chakra_cost = 300
			default_seal_time = 8
			default_cooldown = 90
			cost = 1800
			skill_reqs = list(RAITON_ELEMENT)
			var
				active_needles = 0

			stamina_damage_fixed = list(800, 1000)
			stamina_damage_con = list(150, 200)
			wound_damage_fixed = list(1, 4)
			wound_damage_con = list(0, 2)

			Use(mob/human/user)
				viewers(user) << output("[user]: Lightning: False Darkness!", "combat_output")
				user.icon_state="Seal"
				spawn(10)
					user.icon_state = ""
				user.Begin_Stun()
				var/conmult = user.ControlDamageMultiplier()
				var/targets[] = user.NearestTargets(num=3)
				if(targets.len)
					for(var/mob/human/player/target in targets)
						++active_needles
						spawn()
							var/obj/trailmaker/o=new/obj/trailmaker/False_Darkness(locate(user.x,user.y,user.z))
							var/mob/result = Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,8,target,1,1,0,0,1,user)
							if(result)
								result = result.Replacement_Start(user)
								result.Damage(rand(800,1000)+rand(150,200)*conmult,rand(0,1)+rand(0,1)*conmult,user,"Lightning: False Darkness","Normal")
								if(istype(result,/mob/human/ironsand))
									del(result)
								if(!result.ko && !result.IsProtected())
									result.Timed_Move_Stun(50)
									spawn()Blood2(result,user)
									o.icon_state="still"
									spawn()result.Hostile(user)
								spawn(5) if(result) result.Replacement_End()
							--active_needles
							if(active_needles <= 0)
								user.End_Stun()
							o.loc = null
				else
					++active_needles
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/False_Darkness(locate(user.x,user.y,user.z))
						var/mob/result = Trail_Straight_Projectile(user.x, user.y, user.z, user.dir, o, 8, user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(800,1000)+rand(150,200)*conmult,rand(0,1)+rand(0,1)*conmult,user,"Lightning: False Darkness","Normal")
							if(istype(result,/mob/human/ironsand))
								del(result)
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(50)
								spawn()Blood2(result,user)
								o.icon_state="still"
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
						--active_needles
						if(active_needles <= 0)
							user.End_Stun()
						o.loc = null


		kirin
			id = KIRIN
			name = "Lightning Release: Kirin"
			icon_state = "kirin"
			default_chakra_cost = 2500
			default_cooldown = 550
			default_seal_time = 15
			skill_reqs = list(RAITON_ELEMENT)

			Use(mob/human/user)
				//user.stunned=2
				viewers(user) << output("[user]:<font color =aqua>Lightning Release: Kirin!", "combat_output")
				spawn()
					var/mob/human/player/etarget = user.NearestTarget()
					if(etarget==null)
						usr<<"Need a target to Kirin!"
						return
					else
						var/ex=etarget.x
						var/ey=etarget.y
						var/ez=etarget.z
						var/mob/x=new/mob(locate(ex,ey,ez))
						var/obj/K = new/obj/Kirin(locate(ex,ey+3,ez))
						sleep(3.5)
						step_towards(K,x)
						sleep(3.5)
						step_towards(K,x)
						sleep(3.5)
						step_towards(K,x)
						user.curchakra=50
						user.Damage(rand(500,900),0,user)
						etarget.Damage(rand(1500,2000),user)
						for(var/turf/t in oview(x,7))
							spawn()Electricity(t.x,t.y,t.z,200)
						spawn()AOExk(x.x,x.y,x.z,6,user.con*2.5+user.conbuff+user.rfx*2+user.rfxbuff,200,user,0,1.5,1)
						Electricity(x.x,x.y,x.z,200)
						spawn(80)
							del(x)
							del(K)
/*						var/conmult = user.ControlDamageMultiplier()
						for(var/turf/New_Turfs/Outside/Wire/w in oview(7))
							spawn()Electricity(w.x,w.y,w.z,50)
							spawn()AOExk(w.x,w.y,w.z,1,(user.con+user.conbuff+conmult/2),50,user,0,1.5,1)
						for(var/turf/New_Turfs/Outside/Electricity/e in oview(10))
							spawn()Electricity(e.x,e.y,e.z,50)
							spawn()AOExk(e.x,e.y,e.z,1,(user.con+user.conbuff+conmult/2),50,user,0,1.5,1)*/
