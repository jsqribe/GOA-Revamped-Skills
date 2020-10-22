skill
	aburame
		copyable = 0


		bug_summoning
			id = BUG_SUMMONING
			name = "Bug Summoning"
			icon_state = "bug_summoning"
			default_chakra_cost = 300
			default_cooldown = 10


			Use(mob/user)
				if(user.bugs_summoned)
					user.bugs_summoned=0
					user.bug_cooldown=0
					user.overlays-='icons/bug_summoning.dmi'
					ChangeIconState("bug_summoning")
					return
				viewers(user) << output("[user]: Bug Summoning!", "combat_output")
				ChangeIconState("cancel_bugs")
				user.bugs_summoned=1
				user.bug_cooldown=0
				user.overlays+='icons/bug_summoning.dmi'
				spawn(600*10)
					if(user&&user.bugs_summoned)
						user.bugs_summoned=0
						user.bug_cooldown=0
						user.overlays-='icons/bug_summoning.dmi'
						ChangeIconState("bug_summoning")
						return

		insect_breakthrough
			id = INSECT_BREAKTHROUGH
			name = "Insect Breakthrough"
			icon_state = "insect_breakthrough"
			default_chakra_cost = 500
			default_cooldown = 60
			default_seal_time = 5


			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.bugs_summoned)
						Error(user, "Cannot be used without summoned bugs")
						return 0
			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.insectcocoon)
						Error(user, "Can only be used when insect cocoon is active")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Insect Breakthrough!", "combat_output")

				user.icon_state="HandSeals"
				user.stunned=2

				var/dir = user.dir
				var/mob/human/player/etarget = user.MainTarget()
				var/conmult = user.ControlDamageMultiplier()
				if(etarget)
					etarget.Damage((25 + 25*conmult),0,user)
					dir = angle2dir_cardinal(get_real_angle(user, etarget))
					user.dir = dir

				spawn()
					InsectWaveDamage(user,3,(25+25*user.ControlDamageMultiplier()),3,14)
				InsectGust(user.x,user.y,user.z,user.dir,2,14)

				user.stunned=0
				user.icon_state=""

		insect_cocoon_technique
			id = INSECT_COCOON_TECHNIQUE
			name = "Insect Cocoon Technique"
			icon_state = "insect_cocoon_technique"
			default_chakra_cost = 550
			default_cooldown = 70



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.bugs_summoned)
						Error(user, "Cannot be used without summoned bugs")
						return 0




			Use(mob/human/user)
				if(user.insect_cocoon)
					user.insect_cocoon=0
					user.overlays-='icons/bug_summoning.dmi'
					ChangeIconState("insect_cocoon_technique")
					return
				viewers(user) << output("[user]: Secret Technique: Insect Cocoon Technique!", "combat_output")
				ChangeIconState("cancel_cocoon")
				user.overlays+='icons/bug_shield.dmi'
				user.insectcocoon=1
				user.insect_cocoon=3
				spawn()
					while(user && user.insect_cocoon)
						CHECK_TICK
					if(!user) return
					user.overlays-='icons/bug_shield.dmi'
					user.insectcocoon=0
					ChangeIconState("insect_cocoon_technique")

		nano_sized_venomous_insects/////Made so it hurts the user when used cause i wasn't sure what you ment by "doesn't hurt"
			id = NANO
			name = "Jutsu Parasitic Destruction Insect Technique (Nano-Sized, Venomous Insects)"
			icon_state = "nano"
			default_chakra_cost = 500
			default_cooldown = 200

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.nano)
						Error(user, "Venomous Insects are already activated")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Jutsu Parasitic Destruction Insect Technique (Nano-Sized, Venomous Insects)!", "combat_output")
				var/buffcon=round(user.con*0.08)
				user.nano=1
				user.stunned = 10
				user.nanokiller()
				user.special+=/obj/nano
				user.Affirm_Icon()

				user.conbuff+=buffcon

				flick('nanoformation.dmi',user)
				sleep(10)

				if(user.stunned > 1)
					user.stunned = 0

				spawn(Cooldown(user)*10)
					if(user)
						user.nano=0
						user.special-=/obj/nano
						user.conbuff-=round(buffcon)

mob/proc
	nanokiller()
		src.Wound(rand(10,15),1)
		src.curstamina-=round(rand(500,800),1)


mob/var
	bugs_summoned=0
	insectcocoon=0
	insect_cocoon=0
	bug_cooldown=0
	nano=0

obj
	bug_projectile
		icon='icons/bug_projectile.dmi'
		density=1
		var
			mob/Owner=null
			hit=0

		New(mob/human/player/p, dx, dy, dz, ddir)
			..()
			src.Owner=p
			src.dir=ddir
			src.loc=locate(dx,dy,dz)
			walk(src,src.dir)
			spawn(100)
				if(src&&!src.hit) del(src)

		Bump(O)
			if(src.hit) return
			if(istype(O,/mob))
				src.hit=1
				if(!istype(O,/mob/human/player)||O==src.Owner)
					del(src)
				src.icon=0
				var/mob/p = O
				var/mob/M = src.Owner
				p.Bug_Projectile_Hit(p,M)
				spawn() del(src)

			if(istype(O,/turf))
				var/turf/T = O
				if(T.density)
					src.hit=1
					del(src)

			if(istype(O,/obj))
				var/obj/T = O
				if(T.density)
					src.hit=1
					del(src)

mob/proc
	Bug_Projectile_Hit(mob/human/player/M,mob/human/player/P)
		var/mob/gotcha=0
		var/turf/getloc=0
		var/obj/b = new/obj()
		b.layer=MOB_LAYER+1
		if(!M.ko && !M.protected)
			b.icon='insect_sphere.dmi'
			b.loc=locate(M.x,M.y,M.z)
			flick("form",b)
			b.icon_state="formed"
			M.stunned=5
			M.paralysed=1
			gotcha=M
			getloc=locate(M.x,M.y,M.z)
		var/drains=0
		while(gotcha && gotcha.loc==getloc)
			sleep(10)
			if(!gotcha||drains>=5) break
			drains++
			gotcha.curchakra-= round(150)
			gotcha.curstamina-= round(150)
			gotcha.Hostile(P)
			if(gotcha.curchakra<0||gotcha.curstamina<0)
				gotcha.paralysed=0
				gotcha.curstamina=0
				gotcha=0

		M.paralysed=0
		del(b)




