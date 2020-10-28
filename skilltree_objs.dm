obj
	mapcontrol
		World
			Click()
				if(usr.client && usr.spectate)
					usr.client.eye=locate(MAP_START_X+5,MAP_START_Y+5,MAP_START_Z)
					usr.area = null
	skilltree
		Back
			Click()
				if(usr.build_creating)
					usr.client.eye = locate_tag("maptag_skilltree_select")
					usr.spectate = 1
				//	usr.hidestat = 0
					usr:Refresh_Stat_Screen()
				else
					usr.client.eye = usr.client.mob
				//	usr.hidestat = 0
					usr.spectate = 0
					usr:Refresh_Stat_Screen()

		Passive_C
			Click()
				usr.client.eye=locate_tag("maptag_skilltree_passive")
				usr.spectate = 1
			//	usr.hidestat = 0
				for(var/obj/gui/passives/gauge/Q in gameLists["passives"])
					if(Q.pindex == POINTS_STRENGTH || Q.pindex == POINTS_REFLEX || Q.pindex == POINTS_INTELLIGENCE || Q.pindex == POINTS_CONTROL)
						var/client/C = usr.client
						if(C) C.Passive_Refresh(Q)
		Nonclan_C
			Click()
				usr.client.eye = locate_tag("maptag_skilltree_nonclan")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:refreshskills()
		Nonclan2_C
			Click()
				usr.client.eye = locate_tag("maptag_skilltree_nonclan2")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:refreshskills()
		Clan_C
			Click()
				usr.client.eye = locate_tag("maptag_skilltree_clan")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:refreshskills()

