skill
	passives
		icon = 'icons/gui2.dmi'
		rfx
			cost = 500
			passive=1
			rfx_element
				id = RFX_ELEMENT
				icon_state = "rfx"
				name = "Reflex"
				description = "Reflex passives"
				stack = "false"//don't stack
				canbuy=0

			Weak_Spot
				icon_state = "14"
				max=5
				id=WEAK_SPOT
				name = "Weakspot"
				description="5% chance on hit for a set projectiles to cause 1-4 wound damage per level of this passive."
				skill_reqs = list(RFX_ELEMENT)
				pindex=14

			Projectile_Master
				icon_state = "15"
				max=10
				name = "Projectile Mastery"
				description="+20 Max Supply capacity for every level of this passive."
				id=PROJECTILE_MASTERY
				skill_reqs = list(RFX_ELEMENT)
				pindex=15

			Blindside
				icon_state = "16"
				max=10
				id=BLINDSIDE
				name = "Blindside"
				description="For every level of this passive, All damage done to an opponent who has not targeted you is increased by 10%"
				skill_reqs = list(RFX_ELEMENT)
				pindex=16

			Speed_Demon
				icon_state = "4"
				max=5
				id=SPEED_DEMON
				name = "Speed Demon"
				description="For every level of this passive, the stun after using Shunshin is reduced by 20%"
				skill_reqs = list(RFX_ELEMENT)
				pindex=4

			Rend
				icon_state = "17"
				max=10
				id=REND
				name = "Rend"
				description="Knives and Swords have a 3% COH to cause serious bleeding damage per level of this passive."
				skill_reqs = list(RFX_ELEMENT)
				pindex=17

			Sword_Mastery
				icon_state = "18"
				max=20
				id=SWORD_MASTERY
				name = "Sword Mastery"
				description="For every level of this passive, Sword damage increased by 3%"
				skill_reqs = list(RFX_ELEMENT)
				pindex=18