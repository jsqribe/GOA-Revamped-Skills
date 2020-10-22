skill
	copyable=0
	Shiki_Fujin
		id = SHIKI_FUJIN
		name = "Forbbiden:Shiki Fu-jin"
		icon_state = "DeathGOD"
		default_chakra_cost = 1500
		default_cooldown = 1500
		default_seal_time = 5
		copyable = 0

		IsUsable(mob/user)
			. = ..()
			if(.)
				if(!user.MainTarget())
					Error(user, "No Target")
					return 0


		Use(mob/human/user)
			viewers(user) << output("[user]: Forbbiden:Shiki Fu-jin", "combat_output")

			var/mob/human/player/etarget = user.MainTarget()
			if(!etarget)
				for(var/mob/human/M in oview(1))
					if(!M.protected && !M.ko)
						etarget=M

			var/ex=user.x
			var/ey=user.y
			var/ez=user.z
			spawn()Death_God(ex,ey,ez,200)
			for(var/mob/human/X in oview(10,user))
				user.stunned=100
				user.dir=SOUTH
				etarget.stunned=100
				etarget.dir=SOUTH
				sleep(50)
				user.overlays+='icons/base_chakra.dmi'
				etarget.overlays+='icons/base_chakra.dmi'
				user.icon_state="hurt"
				etarget.icon_state="hurt"
				sleep(100)
				var/kill=rand(1,2)
				switch(kill)
					if(1)
						user.Wound(900,3,user)
						user.combat("The Death Reaper chose you to kill!")
						Blood2(user)
						Blood2(user)
						Blood2(user)
					if(2)
						etarget.Wound(900,3,etarget)
						etarget.combat("The Death Reaper chose you to kill!")
						Blood2(etarget)
						Blood2(etarget)
						Blood2(etarget)
				sleep(5)
				user.overlays-='icons/base_chakra.dmi'
				etarget.overlays-='icons/base_chakra.dmi'
				user.icon_state=""
				etarget.icon_state=""
				etarget.Reset_Stun()
				user.Reset_Stun()






obj
	deathgod_botleft
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="bot-left"
		pixel_x=-64
	deathgod_botleft2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="bot-left2"
		pixel_x=-32
	deathgod_botmid1
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="bot-mid"
	deathgod_botmid2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="bot-mid2"
		pixel_x=32
	deathgod_botright2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="bot-right2"
		pixel_x=64
	deathgod_botright
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="bot-right"
		pixel_x=96
	deathgod_mid_left
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid-left"
		pixel_x=-64
		pixel_y=32
	deathgod_mid_left2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid-left2"
		pixel_x=-32
		pixel_y=32
	deathgod_mid_mid
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid-mid"
		pixel_y=32
	deathgod_mid_mid2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid-mid2"
		pixel_y=32
		pixel_x=32
	deathgod_mid_right2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid-right2"
		pixel_y=32
		pixel_x=64
	deathgod_mid_right
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid-right"
		pixel_y=32
		pixel_x=96
	deathgod_mid2_left
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid2-left"
		pixel_y=64
		pixel_x=-64
	deathgod_mid2_left2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid2-left2"
		pixel_y=64
		pixel_x=-32
	deathgod_mid2_mid
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid2-mid"
		pixel_y=64
	deathgod_mid2_mid2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid2-mid2"
		pixel_y=64
		pixel_x=32
	deathgod_mid2_right2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid2-right2"
		pixel_y=64
		pixel_x=64
	deathgod_mid2_right
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="mid2-right"
		pixel_y=64
		pixel_x=96
	deathgod_top_left
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top-left"
		pixel_y=96
		pixel_x=-64
	deathgod_top_left2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top-left2"
		pixel_y=96
		pixel_x=-32
	deathgod_top_mid
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top-mid"
		pixel_y=96
	deathgod_top_mid2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top-mid2"
		pixel_y=96
		pixel_x=32
	deathgod_top_right2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top-right2"
		pixel_y=96
		pixel_x=64
	deathgod_top_right
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top-right"
		pixel_y=96
		pixel_x=96
	deathgod_top1_left
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top1-left"
		pixel_y=128
		pixel_x=-64
	deathgod_top1_left2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top1-left2"
		pixel_y=128
		pixel_x=-32
	deathgod_top1_mid
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top1-mid"
		pixel_y=128
	deathgod_top1_mid2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top1-mid2"
		pixel_y=128
		pixel_x=32
	deathgod_top1_right2
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top1-right2"
		pixel_y=128
		pixel_x=64
	deathgod_top1_right
		density=1
		layer=MOB_LAYER+1
		icon='deathgod2.dmi'
		icon_state="top1-right"
		pixel_y=128
		pixel_x=96










proc/Death_God(dx,dy,dz,dur)
	var/obj/w1=new/obj/deathgod_botleft(locate(dx,dy+3,dz))
	var/obj/w2=new/obj/deathgod_botleft2(locate(dx,dy+3,dz))
	var/obj/w3=new/obj/deathgod_botmid1(locate(dx,dy+3,dz))
	var/obj/w4=new/obj/deathgod_botmid2(locate(dx,dy+3,dz))
	var/obj/w5=new/obj/deathgod_botright2(locate(dx,dy+3,dz))
	var/obj/w6=new/obj/deathgod_botright(locate(dx,dy+3,dz))
	var/obj/w7=new/obj/deathgod_mid_left(locate(dx,dy+3,dz))
	var/obj/w8=new/obj/deathgod_mid_left2(locate(dx,dy+3,dz))
	var/obj/w9=new/obj/deathgod_mid_mid(locate(dx,dy+3,dz))
	var/obj/w10=new/obj/deathgod_mid_mid2(locate(dx,dy+3,dz))
	var/obj/w11=new/obj/deathgod_mid_right2(locate(dx,dy+3,dz))
	var/obj/w12=new/obj/deathgod_mid_right(locate(dx,dy+3,dz))
	var/obj/w13=new/obj/deathgod_mid2_left(locate(dx,dy+3,dz))
	var/obj/w14=new/obj/deathgod_mid2_left2(locate(dx,dy+3,dz))
	var/obj/w15=new/obj/deathgod_mid2_mid(locate(dx,dy+3,dz))
	var/obj/w16=new/obj/deathgod_mid2_mid2(locate(dx,dy+3,dz))
	var/obj/w17=new/obj/deathgod_mid2_right2(locate(dx,dy+3,dz))
	var/obj/w18=new/obj/deathgod_mid2_right(locate(dx,dy+3,dz))
	var/obj/w19=new/obj/deathgod_top_left(locate(dx,dy+3,dz))
	var/obj/w20=new/obj/deathgod_top_left2(locate(dx,dy+3,dz))
	var/obj/w21=new/obj/deathgod_top_mid(locate(dx,dy+3,dz))
	var/obj/w22=new/obj/deathgod_top_mid2(locate(dx,dy+3,dz))
	var/obj/w23=new/obj/deathgod_top_right2(locate(dx,dy+3,dz))
	var/obj/w24=new/obj/deathgod_top_right(locate(dx,dy+3,dz))
	var/obj/w25=new/obj/deathgod_top1_left(locate(dx,dy+3,dz))
	var/obj/w26=new/obj/deathgod_top1_left2(locate(dx,dy+3,dz))
	var/obj/w27=new/obj/deathgod_top1_mid(locate(dx,dy+3,dz))
	var/obj/w28=new/obj/deathgod_top1_mid2(locate(dx,dy+3,dz))
	var/obj/w29=new/obj/deathgod_top1_right2(locate(dx,dy+3,dz))
	var/obj/w30=new/obj/deathgod_top1_right(locate(dx,dy+3,dz))
	sleep(dur)
	del(w1)
	del(w2)
	del(w3)
	del(w4)
	del(w5)
	del(w6)
	del(w7)
	del(w8)
	del(w9)
	del(w10)
	del(w11)
	del(w12)
	del(w13)
	del(w14)
	del(w15)
	del(w16)
	del(w17)
	del(w18)
	del(w19)
	del(w20)
	del(w21)
	del(w22)
	del(w23)
	del(w24)
	del(w25)
	del(w26)
	del(w27)
	del(w28)
	del(w29)
	del(w30)

