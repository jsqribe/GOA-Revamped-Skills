mob/human/player
	verb
		check_skill_tree_old()
			if(!usr.controlmob)
				usr.client.eye = locate_tag("maptag_skilltree_select")
				usr.spectate = 1
			//	usr.hidestat = 0
				usr:Refresh_Stat_Screen()