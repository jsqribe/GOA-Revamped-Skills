mob/var/Size=0

var/Sizeup_Compat=0
mob/var/list
	iSizeup1=new
	iSizeup2=new
mob
	proc
		Akimichi_Revert()
			usr.Aki=0

			usr.Affirm_Icon()
			usr.Load_Overlays()
			usr.layer=MOB_LAYER

		Akimichi_Grow(Sc)//64 or 96
			usr=src
			src.Begin_Stun()
			src.icon_state="Seal"


			if(Sizeup_Compat)
				Akimichi_Grow_C(Sc)
				return

			usr.Aki=1
			var/icon/I=usr.Affirm_Icon_Ret()

			if(Sc>96)
				Sc=96

			I.Scale(Sc,Sc)
			usr.layer=MOB_LAYER+100

			var/pixel_x = -((I.Width()-world.IconSizeX())/2)

			var/list/Olay=usr.Load_OlayRet()
			var/list/scaled_olay = list()
			for(var/X in Olay)
				CHECK_TICK

				var/icon/O

				if(istype(X, /icon))
					O = X
				else
					O = new /icon (X)

				O.Scale(Sc, Sc)
				scaled_olay += O

			usr.icon = null
			usr.overlays.Cut()

			var/obj/icon = new
			icon.icon = I
			icon.pixel_x = pixel_x
			icon.layer = -100
			usr.overlays += icon

			for(var/icon/J in scaled_olay)
				CHECK_TICK
				var/obj/overlay = new
				overlay.icon = J
				overlay.pixel_x = pixel_x
				overlay.layer = -1
				usr.overlays += overlay

			usr.End_Stun()
			usr.icon_state=""

		Akimichi_Grow_C(Sc)//64 or 96
			CHECK_TICK
			usr=src
			src.Begin_Stun()
			src.icon_state="Seal"
			usr.Aki=1
			if(Sc>96)
				Sc=96
			var/pix=0
			if(Sc>32 && Sc<65)
				pix=16
			usr.layer=MOB_LAYER+5

			var/obj/X1=new/obj/achu
			var/obj/X2=new/obj/achu
			var/obj/X3=new/obj/achu
			var/obj/X4=new/obj/achu
			var/obj/X5=new/obj/achu
			var/obj/X6=new/obj/achu
			var/obj/X7=new/obj/achu
			var/obj/X8=new/obj/achu
			var/obj/X9=new/obj/achu

			X1.pixel_x=-32+pix
			X2.pixel_x=pix

			X3.pixel_x=32+pix

			X4.pixel_y=32
			X4.pixel_x=-32+pix
			X5.pixel_y=32
			X5.pixel_x=pix

			X6.pixel_x=32+pix
			X6.pixel_y=32

			X7.pixel_y=64
			X7.pixel_x=-32+pix
			X8.pixel_y=64
			X8.pixel_x=pix

			X9.pixel_x=32+pix
			X9.pixel_y=64

			usr.overlays=0
			usr.icon=0
			usr.End_Stun()
			usr.icon_state=""
			if(Sc==64)
				if(usr.icon_name=="base_m1")
					X1.icon='icons-x2/base_m1-1-1.dmi'
					X2.icon='icons-x2/base_m1-2-1.dmi'
					X4.icon='icons-x2/base_m1-1-2.dmi'
					X5.icon='icons-x2/base_m1-2-2.dmi'
				if(usr.icon_name=="base_m2")
					X1.icon='icons-x2/base_m2-1-1.dmi'
					X2.icon='icons-x2/base_m2-2-1.dmi'
					X4.icon='icons-x2/base_m2-1-2.dmi'
					X5.icon='icons-x2/base_m2-2-2.dmi'
				if(usr.icon_name=="base_m3")
					X1.icon='icons-x2/base_m3-1-1.dmi'
					X2.icon='icons-x2/base_m3-2-1.dmi'
					X4.icon='icons-x2/base_m3-1-2.dmi'
					X5.icon='icons-x2/base_m3-2-2.dmi'

				iSizeup1=new/list()
				iSizeup1+=X1
				iSizeup1+=X2

				iSizeup1+=X4
				iSizeup1+=X5
				X3.loc = null
				X6.loc = null
				X7.loc = null
				X8.loc = null
				X9.loc = null

			else
				if(usr.icon_name=="base_m1")
					X1.icon='icons-x3/base_m1-1-1.dmi'
					X2.icon='icons-x3/base_m1-2-1.dmi'
					X3.icon='icons-x3/base_m1-3-1.dmi'
					X4.icon='icons-x3/base_m1-1-2.dmi'
					X5.icon='icons-x3/base_m1-2-2.dmi'
					X6.icon='icons-x3/base_m1-3-2.dmi'
					X7.icon='icons-x3/base_m1-1-3.dmi'
					X8.icon='icons-x3/base_m1-2-3.dmi'
					X9.icon='icons-x3/base_m1-3-3.dmi'
				if(usr.icon_name=="base_m2")
					X1.icon='icons-x3/base_m2-1-1.dmi'
					X2.icon='icons-x3/base_m2-2-1.dmi'
					X4.icon='icons-x3/base_m2-1-2.dmi'
					X5.icon='icons-x3/base_m2-2-2.dmi'
					X6.icon='icons-x3/base_m1-3-2.dmi'
					X7.icon='icons-x3/base_m2-1-3.dmi'
					X8.icon='icons-x3/base_m2-2-3.dmi'
					X9.icon='icons-x3/base_m2-3-3.dmi'
				if(usr.icon_name=="base_m3")
					X1.icon='icons-x3/base_m3-1-1.dmi'
					X2.icon='icons-x3/base_m3-2-1.dmi'
					X4.icon='icons-x3/base_m3-1-2.dmi'
					X5.icon='icons-x3/base_m3-2-2.dmi'
					X6.icon='icons-x3/base_m3-3-2.dmi'
					X7.icon='icons-x3/base_m3-1-3.dmi'
					X8.icon='icons-x3/base_m3-2-3.dmi'
					X9.icon='icons-x3/base_m3-3-3.dmi'
				iSizeup2=new/list()
				iSizeup2+=X1
				iSizeup2+=X2
				iSizeup2+=X3
				iSizeup2+=X4
				iSizeup2+=X5
				iSizeup2+=X6
				iSizeup2+=X7
				iSizeup2+=X8
				iSizeup2+=X9
			usr.overlays+=X1//image(spliticon1,usr,pixel_x=-32,pixel_y=0)
			usr.overlays+=X2//image(spliticon2,usr,pixel_x=0,pixel_y=0)
			usr.overlays+=X3//image(spliticon3,usr,pixel_x=32,pixel_y=0)
			usr.overlays+=X4//image(spliticon4,usr,pixel_x=-32,pixel_y=32)
			usr.overlays+=X5//image(spliticon5,usr,pixel_x=0,pixel_y=32)
			usr.overlays+=X6//image(spliticon6,usr,pixel_x=32,pixel_y=32)
			usr.overlays+=X7//image(spliticon7,usr,pixel_x=-32,pixel_y=64)
			usr.overlays+=X8//image(spliticon8,usr,pixel_x=0,pixel_y=64)
			usr.overlays+=X9//image(spliticon9,usr,pixel_x=32,pixel_y=64)


mob
	proc
		Chodan_Bakugeki()
			var/mob/user=src

			user.Timed_Stun(20)

			var/skill/skill=user:GetSkill(BUTTERFLY_BOMBING)
			if(!skill) return
			var/stam_cost=skill:stam_cost
			var/chakra_cost=skill:chakra_cost

			skill:stam_cost=0
			skill:chakra_cost=0

			spawn()
				spawn(4)new/obj/Aki_Explosion/Top_Left(user.loc)
				spawn(4)new/obj/Aki_Explosion/Bottom_Left(user.loc)
				spawn(4)new/obj/Aki_Explosion/Top_Middle(user.loc)
				spawn(4)new/obj/Aki_Explosion/Bottom_Middle(user.loc)
				spawn(4)new/obj/Aki_Explosion/Top_Right(user.loc)
				spawn(4)new/obj/Aki_Explosion/Bottom_Right(user.loc)
				spawn()
					flick("PunchA-1",user)
			spawn(4)
				if(!user) return
				spawn()user.Earthquake(20)
				for(var/mob/M in oview(2,user))
					if(M!=user&&!M.ko&&!istype(M,/mob/corpse))
						spawn()
							if(M)
								M.Knockback(rand(5,8),user.dir)
							spawn()
								if(M)
									flick(M,"hurt")
							if(M)
								Blood2(M)
//								M.Wound(round((stam_cost+chakra_cost)/rand(300,750),1),xpierce=3,attacker=user)
								M.Damage(stam_cost+chakra_cost,0,user, "Butterfly Bomb", "Normal")
			user.butterfly_bombing=0






