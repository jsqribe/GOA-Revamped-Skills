mob/proc
	Load_OlayRet()
		usr.underlays=0
		var/L[0]
		var/h1i


		switch(src.hair_type)
			if(1)
				h1i='icons/hair1.dmi'
			if(2)
				h1i='icons/hair2.dmi'
			if(3)
				h1i='icons/hair3.dmi'
			if(4)
				h1i='icons/hair4.dmi'
			if(5)
				h1i='icons/hair5.dmi'
			if(6)
				h1i='icons/hair6.dmi'
			if(7)
				h1i='icons/hair7.dmi'
			if(8)
				h1i='icons/hair8.dmi'
			if(9)
				h1i='icons/hair9.dmi'
			if(10)
				h1i='icons/hair10.dmi'
			if(11)
				h1i='icons/hair11.dmi'
			if(12)
				h1i='icons/hair12.dmi'
			if(13)
				h1i='icons/hair13.dmi'
			if(14)
				h1i='icons/hair14.dmi'
			if(15)
				h1i='icons/hair15.dmi'
			if(16)
				h1i='icons/hair16.dmi'
			if(17)
				h1i='icons/hair17.dmi'
			if(18)
				h1i='icons/hair18.dmi'
			if(19)
				h1i='icons/hair19.dmi'
			if(20)
				h1i='icons/hair20.dmi'
			if(21)
				h1i='icons/hair21.dmi'
			if(22)
				h1i='icons/hair22.dmi'
			if(23)
				h1i='icons/hair23.dmi'
			if(24)
				h1i='icons/hair24.dmi'
			if(25)
				h1i='icons/hair25.dmi'
			if(26)
				h1i='icons/hair26.dmi'

		if(h1i)
			h1i += src.hair_color
			var/h2i
			if(src.hair_type==11)
				h2i='icons/hair11o.dmi'
				h2i += src.hair_color

			L+= h1i
			if(h2i)
				L+= h2i

		if(special)
			var/atom/T = new special()

			if(T.icon)L+=T.icon
		if(undershirt)
			var/atom/T = new undershirt()

			if(T.icon)L+=T.icon
		if(pants)
			var/atom/T = new pants()

			if(T.icon)L+=T.icon
		if(overshirt)
			var/atom/T = new overshirt()

			if(T.icon)L+=T.icon
		if(shoes)
			var/atom/T = new shoes()

			if(T.icon)L+=T.icon
		if(legarmor)
			var/atom/T = new legarmor()

			if(T.icon)L+=T.icon
		if(armor)
			var/atom/T = new armor()

			if(T.icon)L+=T.icon
		if(armarmor)
			var/atom/T = new armarmor()

			if(T.icon)L+=T.icon
		if(armarmor2)
			var/atom/T = new armarmor2()

			if(T.icon)L+=T.icon
		if(glasses)
			var/atom/T = new glasses()

			if(T.icon)L+=T.icon
		if(facearmor)
			var/atom/T = new facearmor()

			if(T.icon)L+=T.icon
		if(cloak)
			var/atom/T = new cloak()

			if(T.icon)L+=T.icon
		if(sholder)
			var/atom/T = new sholder()

			if(T.icon)L+=T.icon
		if(back)
			var/atom/T = new back()

			if(T.icon)L+=T.icon

		if(jutsu_overlay)
			var/atom/T = new jutsu_overlay()

			if(T.icon)L+=T.icon

		return L
