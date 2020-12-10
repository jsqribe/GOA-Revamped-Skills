mob
	proc
		Die()

			if(inctf)
				src << "You will respawn in 30 seconds if you're not healed"
				var/count=0
				while(curwound>=maxwound)
					//src.stunned=1000 //redundant since they should be KO'd at this point?
					count++
					if(count>30)
						src.loc=locate_tag("[ctfteam]")
						var/Lobby/L = LobbyManager.GetLobbyByName("[lobby_real_name]")
						if(L && L.Active)
							L.HealPlayer(src)
						return
					sleep(10)

				return

			for(var/obj/entertrigger/CTF_Flag/F in contents)
				//src<<"You dropped the [F.flagname] flag."
				F.Drop(src) //incase they die with it just reset.
			for(var/obj/entertrigger/World_Scroll/F in contents)
				F.Drop(src) //incase they die with it just reset.

			has_flag=0
			move_stun=0
			movepenalty = 0
			overlays-='icons/faction_icons/star-mouse.dmi'

			if(inbattleroyale)
				inbattlefire=0
				inbattleroyale=0
				inevent=0 //remove them from the spectate list.
				Reset_Stun()
				curwound = 0
				curstamina = stamina
				curchakra = chakra
				if(oldx && oldy && oldz)
					loc=locate(oldx, oldy, oldz)
					oldx = 0
					oldy = 0
					oldz = 0
				spawn() checkwinset() //let them watch

				var/Lobby/L = LobbyManager.GetLobbyByName("Battle Royale")
				if(L)
					L.lobby_info("[src] Has lost!")

					L.LPlayers-- //remove from the lobby LPlayers
					L.lobby_info("[L.lobby_name] Players left = [L.LPlayers]")

				return


			if(inarena)
				// TODO: CSS-ify this message
				if(!LobbyManager.Lobbies.len) world<<"<font color=Blue size= +1>[src] Has lost!</font>"
				inarena = 0
				inevent=0 //remove them from the spectate list.
				Reset_Stun()
				curwound = 0
				curstamina = stamina
				curchakra = chakra
				// TODO: ...Just store the damn loc turf already.
				if(oldx && oldy && oldz)
					loc=locate(oldx, oldy, oldz)
					oldx = 0
					oldy = 0
					oldz = 0

			else if(dojo)
				// TODO: Need a better way of finding spawn points.
				// Perhaps a property on the dojo area...
				// Also, what does the 'ei' var DO?
				var/ei = 0
				var/dist = 1000
				var/obj/SPWN = new
				for(var/obj/respawn_markers/dojorespawn/Dj in gameLists["spawns"])
					if(Dj.z == z)
						if(get_dist(Dj, src) < dist)
							dist = get_dist(Dj, src)
							SPWN = Dj
				var/obj/respawn_markers/dojorespawn/Respawn = SPWN

				ei+=5
				if(Respawn)
					curwound = 0
					loc = locate(Respawn.x, Respawn.y, Respawn.z)
					// TODO: Yet more 'let's use the coordinates instead of .loc'. Also, why is it doing y-1?
					//loc = locate(Respawn.x, Respawn.y-1, Respawn.z)
				else
					curwound = 0
				spawn(10)
					Reset_Stun()
					curwound = 0
				curstamina = 1
				// TODO: CSS-ify this message
				src << "You were Defeated"

			else
				for(var/mob/human/Xe in ContractBy)
					if(Xe.Contract2 == src)
						if(Xe.Contract)
							Xe.Contract.loc = null
							Xe.Contract = null
						if(Xe.Contract2)
							Xe.Contract2.ContractBy -= Xe
							if(Xe.Contract2.ContractBy.len < 1)
								Xe.Contract2.ContractBy = null
							Xe.Contract2 = null
						Xe.Affirm_Icon()
				if(!RP)
					// TODO: CSS-ify this message. And make the message clearer. Also: "You're"
					src<<"You're wounded beyond your limit, to respawn at a hospital press Space. If you are not brought back to life in 60 seconds you'll automatically respawn."
					var/count=0

					var/obj/mapinfo/Minfo = locate("__mapinfo__[z]")
					if(Minfo && Minfo.in_war && faction && (faction.village == Minfo.village_control || faction.village == Minfo.attacking_village))
						Respawn()
					else
						// Does this really need to be a loop? I wonder if that 'event scheduler' library (or something similar) might be interesting
						// here to actually cancel it...
						// Come to think of it, there's a LOT of stuff in GOA that having a unified scheduler/ability to cancel things centrally would be nice.
						// So: TODO: Look into Stephen001's Event Scheduler, but probably end up making my own because it might not have the right features.
						while(curwound>=maxwound)
							//src.stunned=1000 //redundant since they should be KO'd at this point?
							count++
							if(count>60)
								src.Respawn()
								return
							sleep(10)
						curstamina = stamina/2

				else
					src<<"You're wounded beyond your limit, because this is a Role-Play server if your not revived by a medic within 5 minutes you'll die and have to wait till a new round to come back.(This takes hours, your best to log in to a Non-RP server)"
					var/count=0

					var/obj/mapinfo/Minfo = locate("__mapinfo__[z]")
					if(Minfo && Minfo.in_war && faction && (faction.village == Minfo.village_control || faction.village == Minfo.attacking_village))
						if(faction.village == Minfo.village_control)
							++Minfo.defender_deaths
						else if(faction.village == Minfo.attacking_village)
							++Minfo.attacker_deaths

					// This seems a rather pointless loop? Is being dead stopping other stuff that might refill stamina?
					// Mabye we should have a general 'Heal' proc for wounds that can handle un-KOing people. The full-dead mode should just set a var or something.
					while(curwound>=maxwound && count<=300)
						sleep(10)
						//src.stunned=1000 //redundant because they should be KO'd?
						count++
						src.icon_state="Dead"

					if(count>300)
						if(client) DeathList+=src.client.computer_id
						// TODO: CSS-ify this message.
						src << "You have Died!"
						if(Minfo) Minfo.PlayerLeft(src)
						new/mob/corpse(loc,src)
						verbs.Cut()
						verbs+=/mob/Admin/verb/Spectate
						if(client)
							winset(src, "observer_menu", "parent=menu;name=\"&Observer\"")
							winset(src, "observer_verb_spectate", "parent=observer_menu;name=\"&Spectate\";command=Spectate")
					else
						curstamina = stamina/2