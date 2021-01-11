skill
	nara
		copyable = 0

		naara_clan
			id = NARA_CLAN
			icon_state = "doton"
			name = "Nara"
			description = "Nara Clan Jutsu."
			stack = "false"//don't stack
			clan=1
			canbuy=0

		shadow_binding
			id = SHADOW_IMITATION
			name = "Shadow Binding"
			description = "Binds your enemies with shadows."
			icon_state = "shadow_imitation"
			default_chakra_cost = 100
			default_cooldown = 60
			skill_reqs = list(NARA_CLAN)
			cost = 1100

			ChakraCost(mob/user)
				if(!user.mane)
					return ..(user)
				else
					return 0


			Cooldown(mob/user)
				if(!user.mane)
					return ..(user)
				else
					return 0


			Use(mob/user)
				if(user.mane)
					user.combat("Remove!")
					user.mane=0
					ChangeIconState("shadow_imitation")
					var/skill/nara/shadow_neck_bind/sk = user.GetSkill(SHADOW_NECK_BIND)
					sk.ChangeIconState("shadow_neck_bind")
					return
				user.icon_state="Seal"
				user.Begin_Stun()
				sleep(15)
				user.mane=1
				user.usemove=1
				viewers(user) << output("[user]: Shadow Binding!", "combat_output")
				var/targets[] = user.NearestTargets(num=3)
				if(targets && targets.len)
					for(var/mob/human/player/etarget in targets)
						spawn()
							var/obj/trailmaker/o=new/obj/trailmaker/Shadow()
							o.density = 0

							var/mob/result=Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,8,etarget)

							if(result && !result.chambered && result != user)
								var/orig_result = result
								result = result.Replacement_Start(user)
								user.End_Stun()
								o.icon=0
								user.mane++
								ChangeIconState("cancel_shadow")


								result.underlays+='icons/shadow.dmi'
								result.maned=user.key
								var/cost=10
								var/resultx=Roll_Against(user.con+user.conbuff-user.conneg,result.str+result.strbuff-result.strneg,100)
								if(resultx>=6)
									cost=user.chakra/60
								if(resultx==5)
									cost=user.chakra/40
								if(resultx==4)
									cost=user.chakra/30
								if(resultx==3)
									cost=user.chakra/20
								if(resultx==2)
									cost=user.chakra/15
								if(resultx==1)
									cost=user.chakra/10
								result.Begin_Stun()

								if(result == orig_result) // No replacement interference, do normal loop
									while(result && user && user.mane && user.curchakra>cost+user.neckbind*25&&result && !user.ko && !user.asleep && !user.chambered && !result.ko && !result.sandshield && !result.mole && (result in view()) && user.usemove)
										user.curchakra-=cost/4+user.neckbind*25
										sleep(5)
								else // Replacement changed the target around, leave it for just a bit then end it when it becomes obvious
									user.curchakra-=cost
									sleep(20)
								o.loc=null
								if(result)
									result.underlays-='icons/shadow.dmi'
									result.maned=0
									result.End_Stun()
									spawn() result.Timed_Stun(10)
									if(user) spawn()result.Hostile(user)
									result.Replacement_End()
							if(user)
								user.mane = max(1, user.mane - 1)
								if(user.mane == 1)
									user.icon_state=""
									user.End_Stun()
									user.mane = 0
									ChangeIconState("shadow_imitation")
									var/skill/nara/shadow_neck_bind/sk = user.GetSkill(SHADOW_NECK_BIND)
									if(sk) sk.ChangeIconState("shadow_neck_bind")
									spawn() DoCooldown(user)


				else
					var/obj/trailmaker/o=new/obj/trailmaker/Shadow()
					o.density = 0
					var/mob/result=Trail_Straight_Projectile(user.x,user.y,user.z,user.dir,o,8)
					if(result && !result.chambered && result != user)
						spawn()
							var/orig_result = result
							result = result.Replacement_Start(user)
							user.End_Stun()
							o.icon=0
							ChangeIconState("cancel_shadow")
							var/cost=10
							result.underlays+='icons/shadow.dmi'
							result.maned=user.key
							var/resultx=Roll_Against(user.con+user.conbuff-user.conneg,result.str+result.strbuff-result.strneg,100)
							if(resultx>=6)
								cost=user.chakra/60
							if(resultx==5)
								cost=user.chakra/40
							if(resultx==4)
								cost=user.chakra/30
							if(resultx==3)
								cost=user.chakra/20
							if(resultx==2)
								cost=user.chakra/15
							if(resultx==1)
								cost=user.chakra/10
							result.Begin_Stun()

							if(result == orig_result) // No replacement interference, do normal loop
								while(result && user && user.mane && user.curchakra>cost+user.neckbind*25&&result && !user.ko && !user.asleep && !user.chambered && !result.ko && !result.sandshield && !result.mole && (result in hearers()) && user.usemove)
									user.curchakra-=cost/4+user.neckbind*25
									sleep(5)
							else // Replacement changed the target around, leave it for just a bit then end it when it becomes obvious
								user.curchakra-=cost
								sleep(20)

							o.loc=null

							if(result)
								result.underlays-='icons/shadow.dmi'
								result.maned=0
								result.End_Stun()
								spawn() result.Timed_Stun(10)
								if(user) spawn()result.Hostile(user)
								result.Replacement_End()
							if(user)
								user.icon_state=""
								user.End_Stun()
								user.mane=0
								ChangeIconState("shadow_imitation")
								var/skill/nara/shadow_neck_bind/sk = user.GetSkill(SHADOW_NECK_BIND)
								sk.ChangeIconState("shadow_neck_bind")
								spawn() DoCooldown(user)
					else if(user)
						user.icon_state=""
						user.End_Stun()
						user.mane=0
						o.loc=null




		shadow_neck_bind
			id = SHADOW_NECK_BIND
			name = "Shadow Neck Bind"
			description = "Chokes your enemies with shadows dealing damage over time. While this is active your shadow bind will consume more chakra."
			icon_state = "shadow_neck_bind"
			default_chakra_cost = 100
			default_cooldown = 5
			stamina_damage_fixed = list(1000, 1000)
			stamina_damage_con = list(500, 500)
			cost = 1500
			skill_reqs = list(SHADOW_IMITATION)


			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.mane)
						Error(user, "Cannot be used without Shadow Binding active")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Shadow Neck Bind!", "combat_output")
				var/conmult = user.ControlDamageMultiplier()

				for(var/mob/human/x in ohearers(8))
					if(x.maned==user.key)
						var/cost=10
						var/resultx=Roll_Against(user.con+user.conbuff-user.conneg,x.str+x.strbuff-x.strneg,100)
						if(resultx>=6)
							cost=user.chakra/6
						if(resultx==5)
							cost=user.chakra/5
						if(resultx==4)
							cost=user.chakra/4
						if(resultx==3)
							cost=user.chakra/3
						if(resultx==2)
							cost=user.chakra/2
						if(resultx==1)
							cost=user.chakra/1.5

						if(user.curchakra >= cost)
							var/obj/o =new/obj(locate(x.x,x.y,x.z))
							o.layer=MOB_LAYER+1
							o.icon='icons/shadowneckbind.dmi'
							spawn(18)
								if(x && !x.icon_state)
									flick("hurt",x)
							flick("choke",o)
							spawn(20)
								o.loc = null
							if(x)
								x.Damage((1000+(500*conmult)),0,user,"Shadow Neck Bind","Normal")
								user.curchakra-=cost

							spawn(50)if(x) x.Hostile(user)
						else
							Error(user, "You do not have enough chakra left to do this!")





		shadow_sewing
			id = SHADOW_SEWING_NEEDLES
			name = "Shadow Sewing"
			description = "Pierces your enemies with needles made of shadow."
			icon_state = "shadow_sewing_needles"
			default_chakra_cost = 220
			default_cooldown = 90

			var
				active_needles = 0
				
			cost = 1500
			skill_reqs = list(SHADOW_NECK_BIND)

			stamina_damage_fixed = list(600, 900)
			stamina_damage_con = list(0, 300)
			wound_damage_fixed = list(2, 5)
			wound_damage_con = list(0, 0)



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.MainTarget())
						Error(user, "No Target")
						return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: Shadow Sewing!", "combat_output")
				user.icon_state="Seal"
				spawn(10)
					user.icon_state = ""
				user.Begin_Stun()
				var/conmult = user.ControlDamageMultiplier()
				var/targets[] = user.NearestTargets(num=3)
				for(var/mob/human/player/target in targets)

					++active_needles
					spawn()
						var/obj/trailmaker/o=new/obj/trailmaker/Shadowneedle(locate(user.x,user.y,user.z))
						var/mob/result = Trail_Homing_Projectile(user.x,user.y,user.z,user.dir,o,20,target,1,1,0,0,1,user)
						if(result)
							result = result.Replacement_Start(user)
							result.Damage(rand(600,(900+300*conmult)),rand(1,3),user,"Shadow Sewing Needle","Normal")
							if(!result.ko && !result.IsProtected())
								result.Timed_Move_Stun(100)
								spawn()Blood2(result,user)
								o.icon_state="still"
								spawn()result.Hostile(user)
							spawn(5) if(result) result.Replacement_End()
						--active_needles
						if(active_needles <= 0)
							user.End_Stun()
						o.loc = null
