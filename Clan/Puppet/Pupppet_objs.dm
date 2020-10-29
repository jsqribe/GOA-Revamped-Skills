obj
	Shield
		layer=MOB_LAYER+3
		density=0
		var/list/owners[] = list()
		New()
			..()
			src.owner = usr
			src.overlays+=image('icons/shield.dmi',icon_state="tl",pixel_x=-16,pixel_y=16)
			src.overlays+=image('icons/shield.dmi',icon_state="tr",pixel_x=16,pixel_y=16)
			src.overlays+=image('icons/shield.dmi',icon_state="bl",pixel_x=-16,pixel_y=-16)
			src.overlays+=image('icons/shield.dmi',icon_state="br",pixel_x=16,pixel_y=-16)
			sleep(70)
			loc = null


obj/items
	Puppet
		var
			inuse=0
			incarnation=0
			summon=/mob/human/Puppet/Karasu
		verb/Change_Name()
			var/newname=input_text(usr,"Change [src]'s name to what?")
			if(!world.Name_No_Good(newname))
				var/oldname=src.name
				var/xname=newname
				newname=world.Name_Correct(xname)
				src.name=newname
				usr<<"[oldname]'s name has been changed to [src.name]"
			else
				usr<<"Thats a bad name!"
		verb/Destroy()
			switch(input2(usr,"Really Destroy [src]?!", list("No","Yes")))
				if("Yes")
					del(src)
		Karasu
			code=105
			summon=/mob/human/Puppet/Karasu
			icon='icons/puppet1.dmi'
			icon_state="gui"

		Advanced_Karasu
			code=218
			summon=/mob/human/Puppet/Karasu/Advanced
			icon='icons/puppet1.dmi'
			icon_state="gui"

		Master_Karasu
			code=219
			summon=/mob/human/Puppet/Karasu/Master
			icon='icons/puppet1.dmi'
			icon_state="gui"

		Click()
			Use(usr)

		proc/Use(var/mob/u)
			set hidden=1
			set category=null
			usr=u
			if(usr.ko|| usr.stunned||usr.handseal_stun)
				return
			if(usr.busy==0)
				var/list/listpuppets=new
				if(usr:HasSkill(PUPPET_SUMMON1))
					listpuppets+="Puppet 1"
				if(usr:HasSkill(PUPPET_SUMMON2))
					listpuppets+="Puppet 2"
				listpuppets+="Unequip"
				listpuppets+="Nevermind"
				usr.Puppets.len=2
				switch(input2(usr,"Which Puppet slot do you want to assign [src] to?","Puppet Equip",listpuppets))
					if("Puppet 1")
						if(!usr.Puppet1)
							usr.Puppets[1]=src
							src.overlays+='icons/Equipped1.dmi'
						else
							usr<<"Put away Puppet 1 first."

					if("Puppet 2")
						if(!usr.Puppet2)
							usr.Puppets[2]=src
							src.overlays+='icons/Equipped2.dmi'
						else
							usr<<"Put away Puppet 2 first."
					if("Unequip")
						src.overlays=0
						for(var/obj/x in usr.Puppets)
							if(x==src)
								usr.Puppets.Remove(x)

	Puppet_Stuff
		MouseDrop(obj/over_object, src_location, over_location, src_control, over_control, params_text)
			//need to fix this
			usr << "This has been disabled as it's breaking saving"
			return 0//Dipic: Disabled as it's breaking saves
			if(src == over_object)
				return

			var/params = params2list(params_text)

			var/screen_loc = params["screen-loc"]
			var/screen_loc_lst = dd_text2list(screen_loc, ",")
			var/screen_loc_non_pixel_lst = list()

			for(var/loc in screen_loc_lst)
				var/loc_lst = dd_text2list(loc, ":")
				screen_loc_non_pixel_lst += loc_lst[1]

			screen_loc = dd_list2text(screen_loc_non_pixel_lst, ",")

			if(istype(over_object, /obj/gui/hud/skillbar) || istype(over_object, /skillcard) || istype(over_object, /obj/items/Puppet_Stuff))
				var/spot
				switch(screen_loc)
					if("3,1")
						spot=1
					if("4,1")
						spot=2
					if("5,1")
						spot=3
					if("6,1")
						spot=4
					if("7,1")
						spot=5
					if("8,1")
						spot=6
					if("9,1")
						spot=7
					if("10,1")
						spot=8
					if("11,1")
						spot=9
					if("12,1")
						spot=10
					if("13,1")
						spot=11
					if("14,1")
						spot=12
					if("15,1")
						spot=13

				if(spot)
					if(usr.vars["macro[spot]"])
						if(istype(usr.vars["macro[spot]"], /skillcard))
							var/skill/s = usr.vars["macro[spot]"]
							for(var/skillcard/c in s.skillcards)
								if(c.screen_loc == screen_loc)
									usr.client.screen -= c
									usr.client.player_gui -= c
						if(istype(usr.vars["macro[spot]"], /obj/items/Puppet_Stuff))
							for(var/obj/items/Puppet_Stuff/p in usr.client.screen)
								if(p.screen_loc == screen_loc)
									usr.client.screen -= p
									usr.client.player_gui -= p

					usr.client.player_gui += src
					src.screen_loc = screen_loc
					usr.client.screen += src
					usr.vars["macro[spot]"] = src

		var/oindex=0
		var/costz=5
		Hidden_Knife_Shot
			icon='icons/gui.dmi'
			icon_state="mouthknife"
			oindex=1
			costz=2
			code=106
		Poison_Bomb
			icon='icons/gui.dmi'
			icon_state="poisonbomb"
			oindex=2
			costz=5
			code=107
		Body_Crush
			icon='icons/gui.dmi'
			icon_state="armbind"
			oindex=3
			costz=5
			code=108
		Poison_Tipped_Blade
			icon='icons/gui.dmi'
			icon_state="mild-poison"
			oindex=4
			costz=3
			code=109
		Needle_Gun
			icon='icons/gui.dmi'
			icon_state="needlegun"
			oindex=5
			code=110
			costz=5
		Chakra_Shield
			icon='icons/gui.dmi'
			icon_state="chakrashield"
			oindex=6
			costz=10
			code=111

		Click()
			Activate(usr)

		proc/Activate(var/mob/u)
			set hidden=1
			set category=null
			usr=u
			if(usr.ko|| usr.stunned||usr.handseal_stun)
				return
			if(usr.busy==0&&usr.pk==1&&src.equipped)
				var/obj/items/Puppet/host=usr.Puppets[src.equipped]
				if(host)
					var/mob/human/Puppet/T=host.incarnation
					if(T && (T in ohearers(20,usr))&& !T.coold &&!T.coold2[oindex])
						T.coold2[oindex]=costz*10
						src.overlays += 'icons/dull.dmi'
						spawn(costz*50) src.overlays -= 'icons/dull.dmi'
						T.PuppetSkill(oindex,u)

		verb
			Install()
				var/list/equipto=new
				for(var/obj/X in usr.Puppets)
					equipto+=X
				var/obj/items/Puppet/P = input4(usr,"Equip to which puppet?","Equip", equipto)
				if(!P)
					usr<<"Equip some puppets first maybe."
					return
				if(P.incarnation)
					usr<<"You cannot Install Components while your puppet is out!"
					return

				var/ind=0
				var/count=0
				if(usr.Puppets.len < 2)
					usr.Puppets.len = 2
				if(usr.Puppets[1]==P)
					ind=1
				if(usr.Puppets[2]==P)
					ind=2
				for(var/obj/items/Puppet_Stuff/W in usr.contents)
					if(W.equipped==ind)
						count++
				if(count>2)
					usr<<"A puppet can only equip 3 items."
					return
				if(ind==1)
					src.overlays+='icons/Equipped1.dmi'
				if(ind==2)
					src.overlays+='icons/Equipped2.dmi'
				src.install=ind
				src.equipped=ind

			UnInstall()
				src.equipped=0
				src.overlays=0

	/*		custom_macro(var/S as text)//custommac
				set name ="custom_macro"
				set hidden=1
				if(!istype(usr,/mob/human/player))return
				for(var/obj/O in usr.contents)
					if(O.cust_macro==S)
						spawn()O.Click()
						return

			Set_Custom_Macro()
				set category=null
				var/C
				var/S=null
				if(!S)
					C=input(usr,"Bind Key to Card","Custom Macro") in Bindables
					if(C=="Remove Bind")
						src.cust_macro=null
						src.overlays-=src.macover
						src.macover=null
						winset(usr, "custom_macro_[C]", "parent=")
						return
				else
					C=S
				for(var/obj/O in usr.contents)
					if(O.cust_macro==C)
						O.cust_macro=null
						O.overlays-=O.macover
						O.macover=null

				src.cust_macro=C
				src.macover=image('fonts/Cambriacolor.dmi',icon_state="[C]")
				src.overlays+=src.macover
				winset(usr, "custom_macro_[C]", "parent=macro;name=[C]+REP;command=custom-macro [C]")
*/

obj
	var
		install=0
