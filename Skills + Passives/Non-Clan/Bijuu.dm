mob/var
	shukaku=0
	nibi=0
	sanbi=0
	yonbi=0
	gobi=0
	rokubi=0
	shichibi=0
	hachibi=0
	kyuubi=0

obj/Kyuubi
	icon='ninetails.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/ninetails.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "5",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "6",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "6.5",pixel_x=-64,pixel_y=64)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "7",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "8",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "9",pixel_x=32,pixel_y=64)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "9.5",pixel_x=64,pixel_y=64)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "10",pixel_x=-64,pixel_y=96)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "11",pixel_x=-32,pixel_y=96)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "12",pixel_x=0,pixel_y=96)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "13",pixel_x=32,pixel_y=96)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "14",pixel_x=64,pixel_y=96)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "15",pixel_x=0,pixel_y=128)
		src.overlays+=image('icons/ninetails.dmi',icon_state = "16",pixel_x=32,pixel_y=128)
		..()
		spawn(500)
			if(src)
				del(src)


obj/Shukaku
	icon='shukaku.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/shukaku.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "5",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "6",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "7",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "8",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/shukaku.dmi',icon_state = "9",pixel_x=32,pixel_y=64)
		..()
		spawn(500)
			if(src)
				del(src)

obj/Hachibi
	icon='hachibi.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/hachibi.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "4",pixel_x=-96,pixel_y=32)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "5",pixel_x=-64,pixel_y=32)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "6",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "7",pixel_x=-0,pixel_y=32)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "8",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "9",pixel_x=64,pixel_y=32)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "10",pixel_x=96,pixel_y=32)

		src.overlays+=image('icons/hachibi.dmi',icon_state = "11",pixel_x=-96,pixel_y=64)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "12",pixel_x=-64,pixel_y=64)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "13",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "14",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "15",pixel_x=32,pixel_y=64)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "16",pixel_x=64,pixel_y=64)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "17",pixel_x=96,pixel_y=64)

		src.overlays+=image('icons/hachibi.dmi',icon_state = "18",pixel_x=-96,pixel_y=96)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "19",pixel_x=-64,pixel_y=96)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "20",pixel_x=-32,pixel_y=96)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "21",pixel_x=0,pixel_y=96)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "22",pixel_x=32,pixel_y=96)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "23",pixel_x=64,pixel_y=96)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "24",pixel_x=96,pixel_y=96)

		src.overlays+=image('icons/hachibi.dmi',icon_state = "25",pixel_x=-96,pixel_y=128)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "26",pixel_x=-64,pixel_y=128)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "27",pixel_x=-32,pixel_y=128)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "28",pixel_x=0,pixel_y=128)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "29",pixel_x=32,pixel_y=128)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "30",pixel_x=64,pixel_y=128)
		src.overlays+=image('icons/hachibi.dmi',icon_state = "31",pixel_x=96,pixel_y=128)
		..()
		spawn(500)
			if(src)
				del(src)


obj/Sanbi
	icon='threetails.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/threetails.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/threetails.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/threetails.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/threetails.dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/threetails.dmi',icon_state = "5",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/threetails.dmi',icon_state = "6",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/threetails.dmi',icon_state = "7",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/threetails.dmi',icon_state = "8",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/threetails.dmi',icon_state = "9",pixel_x=32,pixel_y=64)
		src.overlays+=image('icons/threetails.dmi',icon_state = "10",pixel_x=-32,pixel_y=96)
		src.overlays+=image('icons/threetails.dmi',icon_state = "11",pixel_x=0,pixel_y=96)
		src.overlays+=image('icons/threetails.dmi',icon_state = "12",pixel_x=32,pixel_y=96)
		..()
		spawn(500)
			if(src)
				del(src)


obj/Yonbi
	icon='fourtails.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/fourtails.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "4",pixel_x=64,pixel_y=0)

		src.overlays+=image('icons/fourtails.dmi',icon_state = "5",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "6",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "7",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "8",pixel_x=64,pixel_y=32)

		src.overlays+=image('icons/fourtails.dmi',icon_state = "9",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "10",pixel_x=-0,pixel_y=64)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "11",pixel_x=32,pixel_y=64)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "12",pixel_x=64,pixel_y=64)

		src.overlays+=image('icons/fourtails.dmi',icon_state = "13",pixel_x=-32,pixel_y=96)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "14",pixel_x=-0,pixel_y=96)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "15",pixel_x=32,pixel_y=96)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "16",pixel_x=64,pixel_y=96)

		src.overlays+=image('icons/fourtails.dmi',icon_state = "17",pixel_x=-32,pixel_y=128)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "18",pixel_x=-0,pixel_y=128)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "19",pixel_x=32,pixel_y=128)
		src.overlays+=image('icons/fourtails.dmi',icon_state = "20",pixel_x=64,pixel_y=128)
		..()
		spawn(500)
			if(src)
				del(src)

obj/Nibi
	icon='Nibi.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/Nibi.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "2",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "3",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "5",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "6",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "7",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "8",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "9",pixel_x=32,pixel_y=64)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "10",pixel_x=-32,pixel_y=96)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "11",pixel_x=0,pixel_y=96)
		src.overlays+=image('icons/Nibi.dmi',icon_state = "12",pixel_x=32,pixel_y=96)
		..()
		spawn(500)
			if(src)
				del(src)


obj/Shichibi
	icon='Nanabi.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "1",pixel_x=-64,pixel_y=0)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "2",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "3",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "4",pixel_x=32,pixel_y=0)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "5",pixel_x=64,pixel_y=0)

		src.overlays+=image('icons/Nanabi.dmi',icon_state = "6",pixel_x=-64,pixel_y=32)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "7",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "8",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "9",pixel_x=32,pixel_y=32)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "10",pixel_x=64,pixel_y=32)

		src.overlays+=image('icons/Nanabi.dmi',icon_state = "11",pixel_x=-64,pixel_y=64)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "12",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "13",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "14",pixel_x=32,pixel_y=64)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "15",pixel_x=64,pixel_y=64)

		src.overlays+=image('icons/Nanabi.dmi',icon_state = "16",pixel_x=-64,pixel_y=96)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "17",pixel_x=-32,pixel_y=96)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "18",pixel_x=0,pixel_y=96)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "19",pixel_x=32,pixel_y=96)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "20",pixel_x=64,pixel_y=96)

		src.overlays+=image('icons/Nanabi.dmi',icon_state = "21",pixel_x=-64,pixel_y=128)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "22",pixel_x=-32,pixel_y=128)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "23",pixel_x=0,pixel_y=128)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "24",pixel_x=32,pixel_y=128)
		src.overlays+=image('icons/Nanabi.dmi',icon_state = "25",pixel_x=64,pixel_y=128)
		..()
		spawn(500)
			if(src)
				del(src)

obj/Gobi
	icon='Gobi.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/Gobi.dmi',icon_state = "1",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "2",pixel_x=0,pixel_y=0)

		src.overlays+=image('icons/Gobi.dmi',icon_state = "3",pixel_x=-64,pixel_y=32)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "4",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "5",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "6",pixel_x=32,pixel_y=32)

		src.overlays+=image('icons/Gobi.dmi',icon_state = "7",pixel_x=-64,pixel_y=64)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "8",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "9",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "10",pixel_x=32,pixel_y=64)

		src.overlays+=image('icons/Gobi.dmi',icon_state = "11",pixel_x=-64,pixel_y=96)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "12",pixel_x=-32,pixel_y=96)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "13",pixel_x=0,pixel_y=96)
		src.overlays+=image('icons/Gobi.dmi',icon_state = "14",pixel_x=32,pixel_y=96)
		..()
		spawn(500)
			if(src)
				del(src)

obj/Rokubi
	icon='Rokubi.dmi'
	density=0
	layer=MOB_LAYER
	New()
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "1",pixel_x=-64,pixel_y=0)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "2",pixel_x=-32,pixel_y=0)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "3",pixel_x=0,pixel_y=0)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "4",pixel_x=32,pixel_y=0)

		src.overlays+=image('icons/Rokubi.dmi',icon_state = "5",pixel_x=-64,pixel_y=32)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "6",pixel_x=-32,pixel_y=32)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "7",pixel_x=0,pixel_y=32)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "8",pixel_x=32,pixel_y=32)

		src.overlays+=image('icons/Rokubi.dmi',icon_state = "9",pixel_x=-64,pixel_y=64)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "10",pixel_x=-32,pixel_y=64)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "11",pixel_x=0,pixel_y=64)
		src.overlays+=image('icons/Rokubi.dmi',icon_state = "12",pixel_x=32,pixel_y=64)
		..()
		spawn(500)
			if(src)
				del(src)

skill
	bijuu
		copyable=0

		shukaku
			id = SHUKAKU
			name = "Shukaku"
			icon_state = "shukaku"
			default_chakra_cost = 100
			default_cooldown = 10

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				if(user.shukaku == 1)
					user.shukaku=0
					user.overlays-=image('icons/shukakuaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("shukaku")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/shukakuaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.shukaku=1
					ChangeIconState("shukaku_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.shukaku=0
						user.overlays-=image('icons/shukakuaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						ChangeIconState("shukaku")
						user.RecalculateStats()

			/*		while(user && user.shukaku && user.curchakra>0)
						if(user.curchakra<=0)
							user.overlays-=image('icons/shukakuaura.dmi')
							user.overlays-=image('icons/bijuuaura.dmi')
							user.shukaku=0
							user.combat("Your control over your beast fades and your chakra drops back to normal.")
							ChangeIconState("shukaku")*/


/*			Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Shukaku!", "combat_output")
				var/buffcon=round(user.con*0.80)
				var/buffstr=round(user.str*0.80)
				user.conbuff+=buffcon
				user.strbuff+=buffstr
				user.shukaku=1
				user.protected=10
				var/obj/S = new/obj/Shukaku(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/shukakuaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.conbuff-=round(buffcon)
					user.strbuff-=round(buffstr)
					user.overlays-=image('icons/shukakuaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.shukaku=0*/

		nibi
			id = NIBI
			name = "Nibi"
			icon_state = "nibi"
			default_chakra_cost = 100
			default_cooldown = 10

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				if(user.nibi == 1)
					user.nibi=0
					user.overlays-=image('icons/nibiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("nibi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/nibiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.nibi=1
					ChangeIconState("nibi_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.nibi=0
						user.overlays-=image('icons/nibiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						ChangeIconState("nibi")
						user.RecalculateStats()


			/*	while(user && user.nibi && user.curchakra>0)
						sleep(10)*/
				/*	if(user && user.curchakra<=0)
						user.overlays-=image('icons/nibiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.nibi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("nibi")*/

				/*viewers(user) << output("[user]: Ughh.. Tailed Beast: Nibi!", "combat_output")
				var/buffcon=round(user.con*0.80)
				var/buffrfx=round(user.rfx*0.80)
				user.conbuff+=buffcon
				user.rfxbuff+=buffrfx
				user.nibi=1
				user.protected=10
				var/obj/S = new/obj/Nibi(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/nibiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.conbuff-=round(buffcon)
					user.rfxbuff-=round(buffrfx)
					user.overlays-=image('icons/nibiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.nibi=0*/

		sanbi
			id = SANBI
			name = "Sanbi"
			icon_state = "sanbi"
			default_chakra_cost = 100
			default_cooldown = 10

		/*	IsUsable(mob/user)
				. = ..()
				if(.)
					if(usr.shukaku==1||usr.nibi==1||usr.yonbi==1||usr.sanbi==1||usr.gobi==1||usr.rokubi==1||usr.shichibi==1||usr.hachibi==1||usr.kyuubi==1)
						Error(user, "You're currently using a different bijuu. Please wait for it to end.")
						return 0*/

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				if(user.sanbi == 1)
					user.sanbi=0
					user.overlays-=image('icons/sanbiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("sanbi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/sanbiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.sanbi=1
					ChangeIconState("sanbi_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.sanbi=0
						user.overlays-=image('icons/sanbiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						ChangeIconState("sanbi")
						user.RecalculateStats()

				/*	while(user && user.sanbi && user.curchakra>0)
						sleep(10)*/
					/*if(user && user.curchakra<=0)
						user.overlays-=image('icons/sanbiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.sanbi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("sanbi")*/

/*			Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Sanbi!", "combat_output")
				var/buffcon=round(user.con*0.80)
				var/buffint=round(user.int*0.80)
				user.conbuff+=buffcon
				user.intbuff+=buffint
				user.sanbi=1
				user.protected=10
				var/obj/S = new/obj/Sanbi(locate(user.x,user.y,user.z))
				spawn()explosion(, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/sanbiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.conbuff-=round(buffcon)
					user.intbuff-=round(buffint)
					user.overlays-=image('icons/sanbiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.sanbi=0*/

		yonbi
			id = YONBI
			name = "Yonbi"
			icon_state = "yonbi"
			default_chakra_cost = 100
			default_cooldown = 10

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				if(user.yonbi == 1)
					user.yonbi=0
					user.overlays-=image('icons/yonbiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("yonbi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/yonbiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.yonbi=1
					ChangeIconState("yonbi_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.yonbi=0
						user.overlays-=image('icons/yonbiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						ChangeIconState("yonbi")
						user.RecalculateStats()

				/*	while(user && user.yonbi && user.curchakra>0)
						sleep(10)
					if(user)
						user.overlays-=image('icons/yonbiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.yonbi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("yonbi")*/


	/*		Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Yonbi!", "combat_output")
				var/buffstr=round(user.str*0.80)
				var/buffrfx=round(user.rfx*0.80)
				user.strbuff+=buffstr
				user.rfxbuff+=buffrfx
				user.yonbi=1
				user.protected=10
				var/obj/S = new/obj/Yonbi(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/yonbiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.strbuff-=round(buffstr)
					user.rfxbuff-=round(buffrfx)
					user.overlays-=image('icons/yonbiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.yonbi=0*/

		gobi
			id = GOBI
			name = "Gobi"
			icon_state = "gobi"
			default_chakra_cost = 100
			default_cooldown = 10

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				if(user.gobi == 1)
					user.gobi=0
					user.overlays-=image('icons/gobiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("gobi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/gobiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.gobi=1
					ChangeIconState("gobi_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.gobi=0
						user.overlays-=image('icons/gobiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						ChangeIconState("gobi")
						user.RecalculateStats()

			/*		while(user && user.gobi && user.curchakra>0)
						sleep(10)
					if(user)
						user.overlays-=image('icons/gobiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.gobi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("gobi")*/

	/*		Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Gobi!", "combat_output")
				var/buffint=round(user.int*0.80)
				var/buffrfx=round(user.rfx*0.80)
				user.intbuff+=buffint
				user.rfxbuff+=buffrfx
				user.gobi=1
				user.protected=10
				var/obj/S = new/obj/Gobi(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/gobiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.intbuff-=round(buffint)
					user.rfxbuff-=round(buffrfx)
					user.overlays-=image('icons/gobiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.gobi=0*/

		rokubi
			id = ROKUBI
			name = "Rokubi"
			icon_state = "rokubi"
			default_chakra_cost = 100
			default_cooldown = 10

			Cooldown(mob/user)
				return default_cooldown

			Use(mob/human/user)
				if(user.rokubi == 1)
					user.rokubi=0
					user.overlays-=image('icons/rokubiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("rokubi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/rokubiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.rokubi=1
					ChangeIconState("rokubi_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.rokubi=0
						user.overlays-=image('icons/rokubiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						ChangeIconState("rokubi")
						user.RecalculateStats()


				/*	while(user && user.rokubi && user.curchakra>0)
						sleep(10)
					if(user)
						user.overlays-=image('icons/rokubiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.rokubi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("rokubi")*/

	/*		Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Rokubi!", "combat_output")
				var/buffint=round(user.int*0.60)
				var/buffrfx=round(user.rfx*0.60)
				var/buffcon=round(user.con*0.60)
				user.intbuff+=buffint
				user.rfxbuff+=buffrfx
				user.conbuff+=buffcon
				user.rokubi=1
				user.protected=10
				var/obj/S = new/obj/Rokubi(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/rokubiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.intbuff-=round(buffint)
					user.rfxbuff-=round(buffrfx)
					user.conbuff-=round(buffcon)
					user.overlays-=image('icons/rokubiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.rokubi=0*/

		shichibi
			id = SHICHIBI
			name = "Shichibi"
			icon_state = "shichibi"
			default_chakra_cost = 100
			default_cooldown = 10


			Use(mob/human/user)
				if(user.shichibi == 1)
					user.shichibi=0
					user.overlays-=image('icons/shichibiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("shichibi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/shichibiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.shichibi=1
					ChangeIconState("shichibi_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.shichibi=0
						user.overlays-=image('icons/shichibiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						ChangeIconState("shichibi")
						user.RecalculateStats()

				/*	while(user && user.shichibi && user.curchakra>0)
						sleep(10)
					if(user)
						user.overlays-=image('icons/shichibiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.shichibi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("shichibi")*/

/*			Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Shichibi!", "combat_output")
				var/buffstr=round(user.str*0.60)
				var/buffrfx=round(user.rfx*0.60)
				var/buffcon=round(user.con*0.60)
				user.strbuff+=buffstr
				user.rfxbuff+=buffrfx
				user.conbuff+=buffcon
				user.shichibi=1
				user.protected=10
				var/obj/S = new/obj/Shichibi(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/shichibiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.strbuff-=round(buffstr)
					user.rfxbuff-=round(buffrfx)
					user.conbuff-=round(buffcon)
					user.overlays-=image('icons/shichibiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.shichibi=0*/


		hachibi
			id = HACHIBI
			name = "Hachibi"
			icon_state = "hachibi"
			default_chakra_cost = 100
			default_cooldown = 10


			Use(mob/human/user)
				var/buffstr=round(user.str*0.40)
				var/buffrfx=round(user.rfx*0.40)
				if(user.hachibi == 1)
					user.hachibi=0
					user.overlays-=image('icons/hachibiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.strbuff-=round(buffstr)
					user.rfxbuff-=round(buffrfx)
					ChangeIconState("hachibi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/hachibiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.strbuff+=buffstr
					user.rfxbuff+=buffrfx
					user.hachibi=1
					ChangeIconState("hachibi_cancel")
					user.RecalculateStats()
					user.ChakraDrains()
					if(user.curchakra<=0)
						user.hachibi=0
						user.overlays-=image('icons/hachibiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.strbuff-=round(buffstr)
						user.rfxbuff-=round(buffrfx)
						ChangeIconState("hachibi")
						user.RecalculateStats()


				/*	while(user && user.hachibi && user.curchakra>0)
						sleep(10)
					if(user)
						user.overlays-=image('icons/hachibiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.hachibi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("hachibi")*/

	/*		Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Hachibi!", "combat_output")
				var/buffstr=round(user.str*0.60)
				var/buffrfx=round(user.rfx*0.70)
				var/buffcon=round(user.con*0.50)
				var/buffint=round(user.int*0.50)
				user.intbuff+=buffint
				user.rfxbuff+=buffrfx
				user.conbuff+=buffcon
				user.strbuff+=buffstr
				user.hachibi=1
				user.protected=10
				var/obj/S = new/obj/Hachibi(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/hachibiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.intbuff-=round(buffint)
					user.rfxbuff-=round(buffrfx)
					user.conbuff-=round(buffcon)
					user.strbuff-=round(buffstr)
					user.overlays-=image('icons/hachibiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.hachibi=0*/

		kyuubi
			id = KYUUBI
			name = "Kyuubi"
			icon_state = "kyuubi"
			default_chakra_cost = 100
			default_cooldown = 10


			Use(mob/human/user)
				if(user.kyuubi == 1)
					user.kyuubi=0
					user.overlays-=image('icons/kyuubiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					ChangeIconState("kyuubi")
					user.RecalculateStats()
				else
					user.overlays+=image('icons/kyuubiaura.dmi')
					user.overlays+=image('icons/bijuuaura.dmi')
					user.kyuubi=1
					ChangeIconState("kyuubi_cancel")
					user.Kyuubi_Regen()
					user.ChakraDrains()
						//	spawn(10)


				/*		sleep(10)
					if(user)
						user.overlays-=image('icons/kyuubiaura.dmi')
						user.overlays-=image('icons/bijuuaura.dmi')
						user.kyuubi=0
						user.combat("Your control over your beast fades and your chakra drops back to normal.")
						ChangeIconState("kyuubi")*/


	/*		Use(mob/user)
				viewers(user) << output("[user]: Ughh.. Tailed Beast: Kyuubi!", "combat_output")
				var/buffstr=round(user.str*0.80)
				var/buffrfx=round(user.rfx*0.50)
				var/buffcon=round(user.con*0.70)
				var/buffint=round(user.int*0.50)
				user.intbuff+=buffint
				user.rfxbuff+=buffrfx
				user.conbuff+=buffcon
				user.strbuff+=buffstr
				user.protected=10
				user.kyuubi=1
				var/obj/S = new/obj/Kyuubi(locate(user.x,user.y,user.z))
				spawn()explosion(100, S.x, S.y, S.z, user, 0, 2)
				user.overlays+=image('icons/kyuubiaura.dmi')
				user.overlays+=image('icons/bijuuaura.dmi')
				spawn(150) del(S)
				spawn(5) user.protected=0

				spawn(600)
					if(!user) return
					user.intbuff-=round(buffint)
					user.rfxbuff-=round(buffrfx)
					user.conbuff-=round(buffcon)
					user.strbuff-=round(buffstr)
					user.overlays-=image('icons/kyuubiaura.dmi')
					user.overlays-=image('icons/bijuuaura.dmi')
					user.combat("Your control over your beast fades and your chakra drops back to normal.")
					user.kyuubi=0*/


		bijuu_extraction
			id = BIJUU_EXTRACTION
			name = "Bijuu Extraction"
			icon_state = "extraction"
			default_chakra_cost = 2000
			default_cooldown = 10

			IsUsable(mob/user)
				.=..()
				if(.)
					var/mob/human/T = user.MainTarget()
					var/distance = get_dist(user, T)
					if(distance > 1)
						Error(user, "Your target needs to be next to you.")
						return 0
					if(!T.stunned)
						Error(user, "Your target isn't stunned.")
						return 0
					if(!T.HasSkill(SHUKAKU)&&!T.HasSkill(NIBI)&&!T.HasSkill(SANBI)&&!T.HasSkill(YONBI)&&!T.HasSkill(GOBI)&&!T.HasSkill(ROKUBI)&&!T.HasSkill(HACHIBI)&&!T.HasSkill(SHICHIBI)&&!T.HasSkill(KYUUBI))
						Error(user, "Your target does not have a bijuu.")
						return 0
					if(istype(T,/mob/corpse))
						Error(user, "Your target must be alive! Cannot be used on corpses!")
						return 0
					if(T.curwound <= 80)
						Error(user, "Your target's wounds must be higher!")
						return 0

			Use(mob/human/user)
				var/mob/human/T = user.MainTarget()
				if(!T) return
				viewers(user) << output("[user] attempts to take [T]'s Bijuu!", "combat_output")
				spawn(10)
					user.stunned = 20
					T.stunned = 20
					T.cantreact = 1
					var/B=20
					if(prob(B))
						viewers(user) << output("[user] has successfully took [T]'s Bijuu!", "combat_output")
						usr<<"You have gained [T]'s bijuu. Please relog to finish the operation!"
						T.Wound(200)
						if(T.HasSkill(GOBI))
							T.RemoveSkill(GOBI)
							usr.AddSkill(GOBI)
						else if(T.HasSkill(SHUKAKU))
							T.RemoveSkill(SHUKAKU)
							usr.AddSkill(SHUKAKU)
						else if(T.HasSkill(NIBI))
							T.RemoveSkill(NIBI)
							usr.AddSkill(NIBI)
						else if(T.HasSkill(SANBI))
							T.RemoveSkill(SANBI)
							usr.AddSkill(SANBI)
						else if(T.HasSkill(YONBI))
							T.RemoveSkill(YONBI)
							usr.AddSkill(YONBI)
						else if(T.HasSkill(ROKUBI))
							T.RemoveSkill(ROKUBI)
							usr.AddSkill(ROKUBI)
						else if(T.HasSkill(HACHIBI))
							T.RemoveSkill(HACHIBI)
							usr.AddSkill(HACHIBI)
						else if(T.HasSkill(SHICHIBI))
							T.RemoveSkill(SHICHIBI)
							usr.AddSkill(SHICHIBI)
						else  if(T.HasSkill(KYUUBI))
							T.RemoveSkill(KYUUBI)
							usr.AddSkill(KYUUBI)
						usr.RefreshSkillList()
						T.RefreshSkillList()
					else
						viewers(user) << output("[user] has failed to take [T]'s Bijuu.", "combat_output")
						B-=3
						if(B <= 0)
							B=2
					user.stunned = 0
					T.stunned = 0


		bijuu_bomb
			id = BIJUU_BOMB
			name = "Bijuu Bomb"
			description = "Blasts enemies with a ball of compressed air."
			icon_state = "fuuton_air_bullet"
			default_chakra_cost = 350
			default_cooldown = 30
			default_seal_time = 10
			stamina_damage_fixed = list(750, 750)
			stamina_damage_con = list(500, 500)



			Use(mob/human/user)
				var/ux=user.x
				var/uy=user.y
				var/uz=user.z
				var/startdir=user.dir

				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/player/etarget = user.MainTarget()

				if(!etarget)
					var/ex=ux
					var/ey=uy
					var/ez=uz
					var/angle = dir2angle(startdir)
					var/exmod = 8 * round(cos(angle), 1)
					var/eymod = 8 * round(sin(angle), 1)

					etarget=straight_proj(/obj/bijuu_bomb,8,user,1)
					if(etarget)
						ex=etarget.x
						ey=etarget.y
						ez=etarget.z
						if(user.shukaku==1)
							spawn()explosion((3050+700*conmult),ex,ey,ez,user,0,6)
						else
							spawn()explosion((2750+500*conmult),ex,ey,ez,user,0,6)
					else
						if(user.shukaku==1)
							spawn()explosion((3050+700*conmult),ex+exmod,ey+eymod,ez,user,0,6)
						else
							spawn()explosion((2750+500*conmult),ex+exmod,ey+eymod,ez,user,0,6)
				else
					var/ex=etarget.x
					var/ey=etarget.y
					var/ez=etarget.z

					projectile_to2(/obj/bijuu_bomb,user,locate(ex,ey,ez))
					if(user.shukaku==1)
						spawn()explosion((3050+700*conmult),ex,ey,ez,user,0,6)
					else
						spawn()explosion((2750+500*conmult),ex,ey,ez,user,0,6)