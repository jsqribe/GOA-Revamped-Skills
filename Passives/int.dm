skill
	passives
		icon = 'icons/gui2.dmi'
		int
			cost = 500
			passive=1
			int_element
				id = INT_ELEMENT
				icon_state = "int"
				name = "Intelligence"
				description = "Intelligence passives"
				stack = "false"//don't stack
				canbuy=0

			Tracking
				icon_state = "8"
				max=3
				id=TRACKING
				name = "Tracking"
				description="Each level of this passive dramatically increases the range and number of targets that you can track.  Offscreen targets will show up on the map."
				skill_reqs = list(INT_ELEMENT)
				pindex=8

			Analytical
				icon_state = "7"
				max=3
				id=ANALYTICAL
				name = "Analytical"
				description="Each level of this passive increases the information given to you about your opponent when you target them."
				skill_reqs = list(INT_ELEMENT)
				pindex=7

			Genjutsu_Mastery
				icon_state = "19"
				max=20
				id=GENJUTSU_MASTERY
				name = "Genjutsu Mastery"
				description="Each level of this passive increases intelligence by 5% for purposes of Genjutsu effects."
				skill_reqs = list(INT_ELEMENT)
				pindex=19

			Trap_Mastery
				icon_state = "20"
				max=5
				id=TRAP_MASTERY
				name = "Trap Mastery"
				description="Each level of this passive will cause explosive tags to cause +30% damage when rigged as a trap. (done by pressing interact while standing on it)"
				skill_reqs = list(INT_ELEMENT)
				pindex=20

			Bunshin_Mastery
				icon_state = "1"
				max=20
				id=BUNSHIN_MASTERY
				name = "Bunshin Mastery"
				description="For every level of this passive, Int is increased by 5% for the purpose of Bunshin targeting tricks."
				skill_reqs = list(INT_ELEMENT)
				pindex=1

			Concentration
				icon_state = "21"
				max=20
				id=CONCENTRATION
				name = "Concentration"
				description="The first level of this passive enables Genjutsu resistance and canceling. Each subequent level of this passive increases control by 5% for the purpose of resisting and canceling Genjutsu."
				skill_reqs = list(INT_ELEMENT)
				pindex=21
