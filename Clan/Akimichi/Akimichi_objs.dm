obj
	achu
		layer=MOB_LAYER+0.1

	Aki_Explosion
		pixel_y=-12
		layer=MOB_LAYER+0.1
		icon='aki_explosion.dmi'
		Top_Left
			icon_state="1,0"
			New(location)
				src.loc=location
				src.loc=locate(src.x-1,src.y+1,src.z)
				spawn(14)
					src.loc=null
		Bottom_Left
			icon_state="0,0"
			New(location)
				src.loc=location
				src.loc=locate(src.x-1,src.y,src.z)
				spawn(14)
					src.loc=null
		Top_Middle
			icon_state="1,1"
			New(location)
				src.loc=location
				src.loc=locate(src.x+1,src.y,src.z)
				spawn(14)
					src.loc=null
		Bottom_Middle
			icon_state="0,1"
			New(location)
				src.loc=location
				src.loc=locate(src.x,src.y,src.z)
				spawn(14)
					src.loc=null
		Top_Right
			icon_state="1,2"
			New(location)
				src.overlays+=image('aki_explosion.dmi',icon_state="l,3",pixel_x=32,layer=MOB_LAYER+0.1)
				src.loc=location
				src.loc=locate(src.x+1,src.y+1,src.z)
				spawn(14)
					src.loc=null
		Bottom_Right
			icon_state="0,2"
			New(location)
				src.overlays+=image('aki_explosion.dmi',icon_state="0,3",pixel_x=32,layer=MOB_LAYER+0.1)
				src.loc=location
				src.loc=locate(src.x+1,src.y,src.z)
				spawn(14)
					src.loc=null