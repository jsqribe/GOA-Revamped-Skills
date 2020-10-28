mob
	verb
		interactv()
			set name="Interact"
			set hidden = 1

			//if(usr.inslymind==1)
			//	return

			if(usr.inmap == 1)
				usr.inmap = 0

			if(usr.spectate && usr.client)
				usr.spectate=0
				usr.client.eye=usr.client.mob
			//	src.hidestat=0
				if(usr.halfb==1)
					usr.client.screen += new /obj/black2
				if(usr.shopping)
					usr.shopping=0
					usr.canmove=1
					usr.see_invisible=0
				return
			if(usr.camo)
				usr.camo=0
				usr.Affirm_Icon()
				usr.Load_Overlays()

			if(usr.lastwitnessing &&( usr.sharingan || usr.impsharingan) && usr:HasSkill(SHARINGAN_COPY))
				var/skill/uchiha/sharingan_copy/copy = usr:GetSkill(SHARINGAN_COPY)
				var/skill/copied = copy.CopySkill(usr.lastwitnessing)
				if(copied)
					usr.combat("<b><font color=#faa21b>Copied [copied]!</b></font>")
				usr.lastwitnessing=0
				return

			if(usr.incombo)
				return


			if(src.hydrated==1)
				if(usr.hozuki==0)
					var/time=rand(3,4)
					usr << "Hydrification <br><font color=green>On</br>"
					usr.hozuki=1
					usr.usemove=1
					usr.Affirm_Icon()
					spawn()
						while(time > 0)
							usr.protected=100
							time--
							sleep(10)
							if(time <= 0)
								usr.hozuki=0
								usr.usemove=0
								usr.Affirm_Icon()
								usr << "Hydrification <br><font color=red>Off</br>"
								usr.protected=0
					return
				else
					usr << "Stop trying to spam this you noob!"
					return

			if(src.boil_active)
				if(src.boil_damage==6)
					src << "PH Balance = <font color=#FF0000>Two"
					src.boil_damage=5
				else if(src.boil_damage==5)
					src << "PH Balance = <font color=#F62217>Three"
					src.boil_damage=4
				else if(src.boil_damage==4)
					src << "PH Balance = <font color=#FF3300>Four"
					src.boil_damage=3
				else if(src.boil_damage==3)
					src << "PH Balance = <font color=#FF6600>Five"
					src.boil_damage=2
				else if(src.boil_damage==2)
					src << "PH Balance = <font color=#FF6633>Six"
					src.boil_damage=1
				else if(src.boil_damage==1)
					src << "PH Balance = <font color=#C80000>One"
					src.boil_damage=6

			if(usr.c4)
				usr.c4 = 0
				var/hit=(5 + 230*usr.con/50)*3
				for(var/mob/human/player/x in infectedby)
					if(!x.ko && !istype(x,/mob/corpse))
						spawn()explosion(hit,x.x,x.y,x.z,usr,0,6)
						spawn()explosion(hit,x.x,x.y,x.z,usr,0,6)
						infectedby.Remove(x)
						x.Hostile(usr)
						return

			if(((usr.usedelay>0&&usr.pk)||(usr.stunned&&!usr.controlmob)||handseal_stun||usr.paralysed)&&!usr.ko)
				return
			usr.usedelay++

			var/o=0
			var/inttype=0
			if(leading)
				leading.stop_following()
				return

			if(usr.controlmob || usr.tajuu)
				for(var/mob/human/player/npc/kage_bunshin/X in world)
					if(X.ownerkey==usr.key || X.owner==usr)
						var/dx=X.x
						var/dy=X.y
						var/dz=X.z
						if(usr && usr.client && usr.client.eye != usr.client.mob) usr.client.eye = usr.client.mob
						if(dx&&dy&&dz)
							if(!X:exploading)
								spawn()Poof(dx,dy,dz)
							else
								X:exploading=0
								spawn()explosion(rand(1000,2500),dx,dy,dz,usr)
								X.icon=0
								X.targetable=0
								X.invisibility=100
								X.density=0
								sleep(30)
						if(X)
							if(locate(X) in usr.pet)
								usr.pet-=X
							X.loc=null
						if(usr.client && usr.client.mob)
							usr.client.eye=usr.client.mob
							//src.hidestat=0
				usr.tajuu=0
				usr.RecalculateStats()
				usr.controlmob=0
			spawn(30)
				usr.Respawn()
			for(var/obj/interactable/oxe in oview(1))
				oxe:Interact()
				return

			if(usr.henged)
				usr.name=usr.realname
				usr.henged=0
				usr.mouse_over_pointer=faction_mouse[usr.faction.mouse_icon]
				Poof(usr.x,usr.y,usr.z)
				usr:CreateName(255, 255, 255)
				usr.Affirm_Icon()
				usr.Load_Overlays()

			for(var/turf/warp/w in oview(1))
				if(w.requires_owner)
					w:Owner()

			for(var/mob/human/npc/x in ohearers(1))
				if(x == usr.MainTarget())
					o=1
					inttype=x.interact
				if(o)
					if(inttype=="Talk")
						x:Talk()
					if(inttype=="Shop")
						x:Shop()
					if(inttype=="Doctor")
						x:Heal()
					if(inttype=="Faction")
						x:Faction()

			for(var/mob/human/player/npc/x in ohearers(1))
				if(x == usr.MainTarget())
					o=1
					inttype=x.interact
					if(x.MainTarget()&& !usr.Missionstatus)
						o=0
				if(o)
					if(inttype=="Talk")
						x:Talk()
					if(inttype=="Shop")
						x:Shop()

			for(var/mob/human/Puppet/p in ohearers(1))
				if(Puppet1 && !Primary)
					Primary = Puppet1
					walk(Primary, 0)
					client.eye = Puppet1
					return
				else if(Puppet2 && Puppet2 != Primary)
					if(!Puppet1 || Puppet1 == Primary)
						Primary = Puppet2
						walk(Primary, 0)
						client.eye = Puppet2
						return
			if(Primary && (Puppet1 || Puppet2))
				Primary = 0
				client.eye =  client.mob
				return

			if(!usr.MainTarget())
				for(var/obj/explosive_tag/U in oview(0,usr))
					usr.Tag_Interact(U)
					return
				var/new_target
				for(var/mob/human/M in ohearers(2, usr))
					if(!M.mole)
						if(!new_target)
							new_target = M
						if(get_dist(M, usr) < get_dist(usr, new_target))
							new_target = M
				if(new_target) usr.AddTarget(new_target, active=1)
				return