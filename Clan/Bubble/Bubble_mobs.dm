mob/human/clay

	bubble
		icon='projectiles.dmi'
		icon_state="bubble-m"
		tmp/target



		Explode()
			//world << "[get_dist(src,target)]"
			if(target && get_dist(src,target) <= 2)
				target.sight=(BLIND|SEE_SELF|SEE_OBJS)
				spawn(100)
					target.sight=0

			..()

