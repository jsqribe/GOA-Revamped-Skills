skill

	transform
		id = HENGE
		name = "Transform"
		description = "Changes your appearance to that of someone else."
		icon_state = "henge"
		default_chakra_cost = 40
		default_cooldown = 60



		IsUsable(mob/user)
			. = ..()
			if(.)
				if(!user.MainTarget())
					Error(user, "No Target")
					return 0


		Use(mob/human/player/user)

			if(!user.icon_state)
				flick(user,"Seal")

			viewers(user) << output("[user]: Transform!", "combat_output")
			var/mob/human/player/etarget = user.MainTarget()

			if(etarget && !istype(etarget, /mob/human/clay) && !istype(etarget, /mob/human/sandmonster))
				Poof(user.x, user.y, user.z)

				user.icon = etarget.icon
				user.name = etarget.name


				user.overlays= etarget.overlays
				user.mouse_over_pointer = etarget.mouse_over_pointer
				user.henged = 1

				if(!istype(etarget, /mob/human/npc) && etarget.faction)
					user.transform_chat_icon = etarget.faction.chat_icon
				else
					user.transform_chat_icon = null

				user.CreateName(255, 255, 255)


	body_flicker
		id = SHUNSHIN
		name = "Body Flicker"
		description = "Moves you at a high speed."
		icon_state = "shunshin"
		default_chakra_cost = 35
		default_stamina_cost = 70
		default_cooldown = 5

		IsUsable(mob/human/user)
			if(..())

				if(user.cantshun)
					Error(user, "Cant shunshin while your inside swamp.")
					return 0

				if(Issmoke(user.loc))
					return 0
				else
					return 1

		/*ChakraCost(mob/human/player/user) //Dipic: Pretty sure this was here because body flicker had no cost. It should no longer be needed.
			if(user.gate || user.chakrablocked)
				return 1
			return default_chakra_cost*/

		ChakraCost(mob/user)
			if(user.clan == "Youth") return 0
			else return default_chakra_cost
		StaminaCost(mob/user)
			if(user.clan == "Youth") return default_stamina_cost
			else return 0

		Use(mob/human/user)
			var/mob/human/player/etarget = user.MainTarget()

			if(user.UsrOnSwamp==1)
				return

			if(!user.icon_state)
				flick(user, "Seal")

			sleep(1)
			if(!user) return

			if(!etarget)
				user.combat("<b>Double-click</b> on an empty section of ground within 5 seconds to teleport there.")
				user.shun = 1
				spawn(50)
					if(user) user.shun = 0
			else
				if(etarget && etarget.z == user.z)
					var/did_teleport
					if(user.client)
						var/sdir = user.dir_from_keys()
						if(sdir)
							var/turf/sturf = get_step(etarget,sdir)
							if(!sturf || sturf.density)
								return
							user.client.cancel_movement_loop=1//stop move
							user.AppearAt(sturf.x,sturf.y,sturf.z)
							user.FaceTowards(etarget)
							did_teleport = 1
							user.shuned = 1
							spawn(20)
								user.shuned = 0
					if(!did_teleport)
						if(user.skillspassive[4])
							user.AppearBehind(etarget)
							user.shuned = 1
							spawn(20)
								user.shuned = 0
						else
							user.AppearBefore(etarget)
							user.shuned = 1
							spawn(20)
								user.shuned = 0

					spawn()
						user.Timed_Stun(25.5 - (5 * user.skillspassive[4]))
						user.client.cancel_movement_loop=0//allow move


		Cooldown(mob/user)
			if(user.skillspassive[4] == 5)
				return 0
			else
				return ..(user)



	camouflaged_hiding
		id = CAMOFLAGE_CONCEALMENT
		name = "Camouflaged Hiding"
		description = "Blends you into your surroundings, making it harder for your enemies to see you."
		icon_state = "Camouflage Concealment Technique"
		default_chakra_cost = 100
		default_cooldown = 60
		default_seal_time = 5



		Use(mob/human/player/user)
			user.camo=1
			user.icon='icons/base_invisible.dmi'
			user.overlays=0
			Poof(user.x,user.y,user.z)




	chakra_leech
		id = CHAKRA_LEECH
		name = "Chakra Leech"
		description = "Drains your enemies of chakra, repleshing your chakra."
		icon_state = "chakra_leach"
		default_chakra_cost = 100
		default_cooldown = 60

		IsUsable(mob/user)
			. = ..()
			var/mob/human/target = user.NearestTarget()
			if(. && target)
				var/distance = get_dist(user, target)
				if(distance > 3)
					Error(user, "Target too far ([distance]/3 tiles)")
					return 0

		Use(mob/human/player/user)

			viewers(user) << output("[user]: Chakra Leech!", "combat_output")

			user.icon_state="Throw2"
			user.overlays+='icons/leech.dmi'

			var/mob/human/player/etarget = user.NearestTarget()

			var/dmg_mult = 1
			if(etarget)
				var/dist = get_dist(user, etarget)
				if(dist == 2)
					dmg_mult = 0.5
				else if(dist != 1)
					etarget = null
			else
				for(var/mob/human/X in get_step(user,user.dir))
					if(!X.ko && !X.IsProtected())
						etarget=X

			var/mob/gotcha=0
			var/turf/getloc=0

			if(etarget)
				gotcha=etarget.Replacement_Start(user)
				gotcha.overlays+='icons/leech.dmi'
				user.Timed_Stun(20)
				gotcha.Begin_Stun()

				if(gotcha != etarget)
					gotcha.End_Stun()
					gotcha.overlays-='icons/leech.dmi'
					user.overlays-='icons/leech.dmi'
					user.icon_state=""
					return

				getloc=locate(etarget.x,etarget.y,etarget.z)


				var/max = 0
				var/turf/q=user.loc
				while(user && !user.ko && gotcha && !gotcha.ko && gotcha.loc==getloc && (abs(user.x-gotcha.x)*abs(user.y-gotcha.y))<=1 && user.x==q.x && user.y==q.y)
					var/conmult = user.ControlDamageMultiplier()
					gotcha.curchakra-= round(20*conmult*dmg_mult)
					user.curchakra+=round(20*conmult*dmg_mult)
					gotcha.Hostile(user)

					max += round(20*conmult*dmg_mult)

					if(max > 400 && gotcha)
						gotcha.End_Stun()

					if(gotcha.curchakra<0)
						gotcha.overlays-='icons/leech.dmi'
						gotcha.curstamina=0
						spawn() gotcha.KO()
						gotcha=0

					if(user.curchakra>user.chakra*1.5) user.curchakra=user.chakra*1.5
					sleep(5)

				if(gotcha)
					gotcha.End_Stun()
					gotcha.overlays-='icons/leech.dmi'
				user.icon_state=""
				user.overlays-='icons/leech.dmi'



//This is used for BodyFlicker so will leave it here
client
	DblClick(atom/thing, atom/loc, control, params)
		if(!mob.stunned && mob.pk && mob.shun && isloc(loc))
			if(!loc || !loc.Enter(usr) || !loc.icon || loc.type == /turf || !(loc in oview(mob)) || Issmoke(mob.loc))
				return

			if(!mob.loc.icon || mob.loc.type==/turf || mob.loc.density)
				return

			mob.shun = 0

			spawn() mob.Timed_Stun(30 - (5 * mob.skillspassive[4]))
			mob:AppearAt(loc.x, loc.y, loc.z)
		else
			..()








