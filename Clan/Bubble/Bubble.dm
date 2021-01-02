skill
	bubble
		copyable = 0

		bubble_clan
			id = BUBBLE_CLAN
			icon_state = "doton"
			name = "Bubble"
			description = "Bubble Clan Jutsu."
			stack = "false"//don't stack
			clan=1
			canbuy=0

		blinding_bubbles
			id = BLINDING_BUBBLES
			name = "Bubble Jutsu: Blinding Bubbles"
			icon_state = "blinding"
			default_chakra_cost = 150
			default_cooldown = 120

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.MainTarget()
				if(.)
					if(!target)
						Error(user, "No Target")
						return 0
					var/distance = get_dist(user, target)
					if(distance > 10)
						Error(user, "Target too far ([distance]/10 tiles)")
						return 0

			Use(mob/human/user)
				var/conmult = user.ControlDamageMultiplier()
				flick("Seal",user)
				var/hit=0
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					if(!etarget.protected && !etarget.ko)
						hit=1
				if(hit)
					var/mob/human/clay/bubble/A=new/mob/human/clay/bubble(locate(user.x,user.y,user.z),rand(200,(200+150*conmult)),user)
					spawn(1)Poof(A.x,A.y,A.z)
					A.target=etarget
					spawn(3)Homing_Projectile_bang(user,A,8,etarget,1)
					spawn(50)
						if(A)
							spawn() A.Explode()



		bubblebarrage
			id = BUBBLE_BARRAGE
			name = "Bubble Jutsu: Bubble Control"
			icon_state = "barrage"
			default_chakra_cost = 200
			default_cooldown = 180

			Use(mob/human/user)
				viewers(user) << output("[user]: Secret Art: Bubble Control!", "combat_output")
				var/eicon='icons/projectiles.dmi'
				var/estate="bubble-m"

				if(!user.icon_state)
					user.icon_state="Seal"
					spawn(20)
						user.icon_state=""

				var/angle
				var/speed = 20
				var/spread = 18
				if(user.MainTarget()) angle = get_real_angle(user, user.MainTarget())
				else angle = dir2angle(user.dir)

				var/damage = 65*user.ControlDamageMultiplier()

				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*4, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*3, distance=10, damage=damage, wounds=0)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*2, distance=10, damage=damage, wounds=1)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=1)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=1)




		exploding_bubbles
			id = EXPLODING_BUBBLES
			name = "Bubble Jutsu: Exploding Bubbles"
			icon_state = "exploding"
			default_chakra_cost = 200
			default_cooldown = 30

			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.MainTarget()
				if(.)
					if(!target)
						Error(user, "No Target")
						return 0
					var/distance = get_dist(user, target)
					if(distance > 10)
						Error(user, "Target too far ([distance]/10 tiles)")
						return 0

			Use(mob/human/user)
				flick("Seal",user)
				var/hit=0
				var/mob/human/player/etarget = user.MainTarget()
				if(etarget)
					if(!etarget.protected && !etarget.ko)
						hit=1
				if(hit)
					var/conmult = user.ControlDamageMultiplier()
					var/mob/human/clay/bubble/B=new/mob/human/clay/bubble(locate(etarget.x-2,etarget.y,etarget.z),rand(250,(100+100*conmult)),user)
					var/mob/human/clay/bubble/A=new/mob/human/clay/bubble(locate(etarget.x+2,etarget.y,etarget.z),rand(250,(100+100*conmult)),user)
					var/mob/human/clay/bubble/C=new/mob/human/clay/bubble(locate(etarget.x,etarget.y-2,etarget.z),rand(250,(100+100*conmult)),user)
					var/mob/human/clay/bubble/D=new/mob/human/clay/bubble(locate(etarget.x,etarget.y+2,etarget.z),rand(250,(100+100*conmult)),user)
					spawn(1)Poof(D.x,D.y,D.z)
					spawn(3)Homing_Projectile_bang(user,D,8,etarget,1)
					spawn(1)Poof(C.x,C.y,C.z)
					spawn(3)Homing_Projectile_bang(user,C,8,etarget,1)
					spawn(1)Poof(B.x,B.y,B.z)
					spawn(3)Homing_Projectile_bang(user,B,8,etarget,1)
					spawn(1)Poof(A.x,A.y,A.z)
					spawn(3)Homing_Projectile_bang(user,A,8,etarget,1)
					spawn(50)
						if(B)
							flick("bubble-pop",B)
							B.Explode()
						if(A)
							flick("bubble-pop",A)
							A.Explode()
						if(C)
							flick("bubble-pop",C)
							A.Explode()
						if(D)
							flick("bubble-pop",D)
							A.Explode()

		bubble_dome
			id = PROTECTING_BUBBLES
			name = "Bubble Dome"
		//	description = "Creates a barrier of rapidly spinning chakra."
			icon_state = "kaiten"
			default_chakra_cost = 200
			default_cooldown = 500



			Use(mob/human/user)
				var/timer = (user.con * 3)
				user.combat("You got protected for [timer/10] seconds")
				user.overlays+='bubble_dome.dmi'
				user.bdome=1
				user.Protect(timer)
