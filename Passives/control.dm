skill
	passives
		icon = 'icons/gui2.dmi'
		con
			con_element
				id = CON_ELEMENT
				icon_state = "con"
				name = "Control"
				description = "Control passives"
				stack = "false"//don't stack
				canbuy=0

			Efficiency
				icon_state = "5"
				max=5
				id=EFFICIENCY
				name = "Efficiency"
				description="Each level of this passive reduces chakra costs for skills by 4% and when maxed allows to do Seals while running"
				skill_reqs = list(CON_ELEMENT)

			Powerhouse
				icon_state = "22"
				max=5
				id=POWERHOUSE
				name = "Powerhouse"
				description="Each level of this passive increases maximum chakra by 4% but does not impact regeneration"
				skill_reqs = list(CON_ELEMENT)

			Medic_Training
				icon_state = "23"
				max=20
				id=MEDIC_TRAINING
				name = "Medic Mastery"
				description="For each level of this passive, Wound healing effects from the medic skill are increased by 5%"
				skill_reqs = list(CON_ELEMENT)

			Pure_Power
				icon_state = "24"
				max=20
				id=PURE_POWER
				name = "Pure Power"
				description="For each level of this passive, Con for the purpose of Ninjutsu damage is increased by 5%"
				skill_reqs = list(CON_ELEMENT)

			Regeneration
				icon_state = "3"
				id=REGNERATION
				name = "Regeneration"
				description="For each level of this passive, Chakra and Stamina regenerate 3% faster."
				max=15
				skill_reqs = list(CON_ELEMENT)

			Hand_Seal_Mastery
				icon_state = "6"
				id=HAND_SEAL_MASTERY
				max=10
				name = "Handseals Mastery"
				description="For each level of this passive, cooldowns for skills are reduced by 3%"
				skill_reqs = list(CON_ELEMENT)

