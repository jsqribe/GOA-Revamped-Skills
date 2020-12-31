mob/var
	Tree_Creation=0
	Tree_Creation_Attack=0
	Earth_Wall=0

obj/SenjuuTree
	icon_state="S"
	var/OwnedBy
	var/obj/proj
	density=1
	layer=100
	New()
		for(var/mob/M in world)
			if(src.OwnedBy==M)
				M.TreesOut+=1
				if(M.TreesOut>M.TreesOutMax)
					del(src)
		src.overlays+=image('icons/SenjuuTrees.dmi')

obj/EarthWall
	icon_state="S"
	var/OwnedBy2
	density=1
	layer=10
	New()
		for(var/mob/M in world)
			if(src.OwnedBy2==M)
				M.EWalls+=1
				if(M.EWalls>M.EWallsM)
					del(src)
		src.overlays+=image('New/Walll.dmi',pixel_x=-32)

mob/var
	TreesOut=0
	TreesOutMax=15
	EWalls=0
	EWallsM=5
	Can_Tree_Attack=0

obj/SenjuuT/
	Trail
		var/Attacker
		var/ID
		icon='icons/SenjuuTreeAttack.dmi'
		layer=1000
obj/SenjuuT/
	Attack
		icon='icons/SenjuuTreeAttack.dmi'
		layer=1000
		density=1
		var/Attacker
		var/Hit
		var/ID
		Move()
			for(var/mob/Q in src.loc)
				if(Q.ko==0&&Q.protected<1&&Q.pk>=1)
					Blood(Q.x,Q.y,Q.z)
					Blood(Q.x,Q.y,Q.z)
					Blood(Q.x,Q.y,Q.z)
					Q.Damage(rand(50,380),0,src.Attacker)
			if(src.Hit==1)
				return
			sleep(2)
			..()
		New()
			src.ID=rand(1,153123)
			src.pixel_y=rand(-15,15)
			src.pixel_x=rand(-15,15)
			spawn(rand(10,30))
				del(src)

		Bump(A)
			if(ismob(A))
				var/mob/M = A
				src.Hit=1
				src.x=M.x
				src.z=M.z
				src.y=M.y
				for(var/mob/Q in src.loc)
					if(Q.ko==0&&Q.protected<1&&Q.pk>=1)
						Blood(Q.x,Q.y,Q.z)
						Blood(Q.x,Q.y,Q.z)
						Blood(Q.x,Q.y,Q.z)
						Q.Damage(rand(50,380),0,src.Attacker)
			else
				var/mob/M = A
				src.x=M.x
				src.z=M.z
				src.y=M.y

/*mob
	var
		shadow_caught
		shadow_use*/


