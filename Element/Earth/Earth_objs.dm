obj/earthcage
	var/crushed = 0
	var/crumbled = 0
	icon = 'icons/dotoncage.dmi'
	layer = MOB_LAYER
	pixel_x = -32
	pixel_y = -32
	density = 0

obj
	doton_shield
		icon = 'icons/doton shield.dmi'
		icon_state = "center"
		density = 1
		layer = MOB_LAYER + 0.1

		New(location)
			..(location)

			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "bottom_left", pixel_x = -32, pixel_y = -32)
			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "bottom_center", pixel_y = -32)
			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "bottom_right", pixel_x = 32, pixel_y = -32)

			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "center_left", pixel_x = -32)
			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "center_right", pixel_x = 32)

			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "top_left", pixel_x = -32, pixel_y = 32)
			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "top_center", pixel_y = 32)
			overlays += image(icon = 'icons/doton shield.dmi', icon_state = "top_right", pixel_x = 32, pixel_y = 32)

obj/shield
	icon='icons/doton_crush.dmi'
	one
		layer=MOB_LAYER+1
		density=1
		pixel_x = 32
		pixel_y = -32
		New()
			..()
			flick("bottom_right",src)
	two
		layer=MOB_LAYER+1
		density=1
		pixel_x = -32
		pixel_y = -32
		New()
			..()
			flick("bottom_left",src)
	three
		layer=MOB_LAYER+1
		density=1
		New()
			..()
			flick("center",src)
	four
		layer=MOB_LAYER+1
		density=1
		pixel_x = -32
		New()
			..()
			flick("center_left",src)
	five
		layer=MOB_LAYER+1
		density=1
		pixel_x = 32
		New()
			..()
			flick("center_right",src)
	six
		layer=MOB_LAYER+1
		density=1
		pixel_x = -32
		pixel_y = 32
		New()
			..()
			flick("top_left",src)
	seven
		layer=MOB_LAYER+1
		density=1
		pixel_y = 32
		New()
			..()
			flick("top_center",src)
	eight
		layer=MOB_LAYER+1
		density=1
		pixel_x = 32
		pixel_y = 32
		New()
			..()
			flick("top_right",src)
	nine
		layer=MOB_LAYER+1
		density=1
		pixel_y = -32
		New()
			..()
			flick("bottom_center",src)



earth_dragon
	parent_type = /obj
	icon = 'icons/Earth_Dragon.dmi'
	density = 1
	New(loc)
		..(loc)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "0,0",pixel_x = -48,pixel_y = 0)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "1,0",pixel_x = -16,pixel_y = 0)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "2,0",pixel_x = 16,pixel_y = 0)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "3,0",pixel_x = 48,pixel_y = 0)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "0,1",pixel_x = -48,pixel_y = 32)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "1,1",pixel_x = -16,pixel_y = 32)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "2,1",pixel_x = 16,pixel_y = 32)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "3,1",pixel_x = 48,pixel_y = 32)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "0,2",pixel_x = -48,pixel_y = 64)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "1,2",pixel_x = -16,pixel_y = 64)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "2,2",pixel_x = 16,pixel_y = 64)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "3,2",pixel_x = 48,pixel_y = 64)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "0,3",pixel_x = -48,pixel_y = 96)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "1,3",pixel_x = -16,pixel_y = 96)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "2,3",pixel_x = 16,pixel_y = 96)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "3,3",pixel_x = 48,pixel_y = 96)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "0,4",pixel_x = -48,pixel_y = 128)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "1,4",pixel_x = -16,pixel_y = 128)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "2,4",pixel_x = 16,pixel_y = 128)
		overlays += image(icon = 'Earth_Dragon.dmi',icon_state = "3,4",pixel_x = 48,pixel_y = 128)

obj
	earthcrush_one
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-80
		New()
			..()
			flick("0,0",src)
	earthcrush_two
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-48
		New()
			..()
			flick("1,0",src)
	earthcrush_three
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-16
		New()
			..()
			flick("2,0",src)
	earthcrush_four
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=16
		New()
			..()
			flick("3,0",src)
	earthcrush_five
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=48
		New()
			..()
			flick("4,0",src)
	earthcrush_six
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=80
		New()
			..()
			flick("5,0",src)
	earthcrush_seven
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-80
		pixel_y=32
		New()
			..()
			flick("0,1",src)
	earthcrush_eight
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-48
		pixel_y=32
		New()
			..()
			flick("1,1",src)
	earthcrush_nine
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-16
		pixel_y=32
		New()
			..()
			flick("2,1",src)
	earthcrush_ten
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=16
		pixel_y=32
		New()
			..()
			flick("3,1",src)
	earthcrush_eleven
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=48
		pixel_y=32
		New()
			..()
			flick("4,1",src)
	earthcrush_twelve
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=80
		pixel_y=32
		New()
			..()
			flick("5,1",src)
	earthcrush_thirteen
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-80
		pixel_y=64
		New()
			..()
			flick("0,2",src)
	earthcrush_fourteen
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-48
		pixel_y=64
		New()
			..()
			flick("1,2",src)
	earthcrush_fifteen
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=-16
		pixel_y=64
		New()
			..()
			flick("2,2",src)
	earthcrush_sixteen
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=16
		pixel_y=64
		New()
			..()
			flick("3,2",src)
	earthcrush_seventeen
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=48
		pixel_y=64
		New()
			..()
			flick("4,2",src)
	earthcrush_eighteen
		icon='icons/ground_tremble.dmi'
		layer=MOB_LAYER+1
		pixel_x=80
		pixel_y=64
		New()
			..()
			flick("5,2",src)

obj/ground_destruction
	var
		list/ground=new
	New()
		spawn()..()
		spawn()
			ground+=new/obj/earthcrush_one(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_two(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_three(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_four(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_five(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_six(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_seven(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_eight(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_nine(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_ten(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_eleven(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_twelve(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_thirteen(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_fourteen(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_fifteen(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_sixteen(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_seventeen(locate(src.x,src.y,src.z))
			ground+=new/obj/earthcrush_eighteen(locate(src.x,src.y,src.z))
	Del()
		for(var/obj/x in src.ground)
			del(x)
		..()
