skill
	passives
		icon = 'icons/gui2.dmi'
		str
			str_element
				id = STR_ELEMENT
				icon_state = "str"
				name = "Strength"
				description = "Strength passives"
				stack = "false"//don't stack
				canbuy=0

			Better_Criticals
				icon_state = "2"
				max=10
				id=BETTER_CRITICALS
				name = "Better Criticals"
				description="For every level of this passive, Critical hits do +10% damage"
				skill_reqs = list(STR_ELEMENT)

			Built_Solid
				icon_state = "9"
				max=10
				id=BUILT_SOLID
				name = "Built Solid"
				description="For every level of this passive, taijutsu daze resistance is increased by 8% and Defend damage resistence is increased by 1%"
				skill_reqs = list(STR_ELEMENT)

			Piercing_Strike
				icon_state = "10"
				max=20
				id=PIERCING_STRIKE
				name = "Piercing Strike"
				description="For every level of this passive, 3% of Taijutsu damage blows through all forms of defence."
				skill_reqs = list(STR_ELEMENT)

			Impact
				icon_state = "11"
				max=10
				id=IMPACT
				name = "Impact"
				description="For every level of this passive, Daze effect duration is increased by 10%"
				skill_reqs = list(STR_ELEMENT)

			Deflection
				icon_state = "12"
				max=20
				id=DEFLECTION
				name = "Deflection"
				description="For every level of this passive, there is a 3% chance per point of wound damage to convert 1 wound damage into 100 stamina damage."
				skill_reqs = list(STR_ELEMENT)

			Combo
				icon_state = "13"
				max=5
				id=COMBO
				name = "Combo"
				description="Stackable Effect; every taijutsu attack does +20% extra damage than the last until you are hit. Stack limit is 1 + the level of this passive."
				skill_reqs = list(STR_ELEMENT)