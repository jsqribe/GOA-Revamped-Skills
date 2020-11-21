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
						sleep(30)



			var/r = 0
			//var/sound

			if(src.butterfly_bombing)
				src.Chodan_Bakugeki()
				return


			if(rasengan)
				onHit(M,"rasengan")
				return

			if(sakpunch)
				onHit(M,"sakpunch")
				return

			if(tsupunch)
				onHit(M,"tsupunch")
				return

			if(Partial || Size)
				onHit(M,"Size")
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