obj/sandprotection
	icon = 'icons/defence.dmi'

obj/sandshield
	//icon = 'icons/sandshield.dmi'
	layer = MOB_LAYER + 1
	pixel_x = -32
	pixel_y = -20
	var
		list/dependants = new

	New()
		..()
		spawn()
			dependants += new /obj/sandparts/bl(locate(src.x-1, src.y, src.z))
			dependants += new /obj/sandparts/bm(locate(src.x, src.y, src.z))
			dependants += new /obj/sandparts/br(locate(src.x+1, src.y, src.z))
			dependants += new /obj/sandparts/tl(locate(src.x-1, src.y+1, src.z))
			dependants += new /obj/sandparts/tm(locate(src.x, src.y+1, src.z))
			dependants += new /obj/sandparts/tr(locate(src.x+1, src.y+1, src.z))

	Del()
		for(var/obj/x in src.dependants)
			x.loc = null
		..()



obj
	sandparts
		icon = 'icons/Gaara.dmi'
		layer = MOB_LAYER + 1

		bl
			icon_state = "B-L"

			New()
				..()
				flick("bottom-L", src)

		br
			icon_state = "B-R"

			New()
				..()
				flick("bottom-R", src)

		bm
			icon_state = "B-M"

			New()
				..()
				flick("bottom-mid", src)

		tl
			icon_state = "T-L"

			New()
				..()
				flick("top-L", src)

		tr
			icon_state = "T-R"

			New()
				..()
				flick("top-R", src)

		tm
			icon_state = "T-M"

			New()
				..()
				flick("top-mid", src)
