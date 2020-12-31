obj/chidori
	icon = 'icons/chidori.dmi'

obj/Kirin
	icon='Kirin(smaller).dmi'
	density=0
	New()
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "2",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "3",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "5",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "6",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "7",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "8",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/Kirin(smaller).dmi',icon_state = "6",pixel_x=32,pixel_y=64)
		..()