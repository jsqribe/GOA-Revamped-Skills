proc/get_steps(atom/A, var/dir, var/num)
	var/T = get_step(A, dir)
	while(num && T)
		A = T
		T = get_step(A, dir)
		--num
	return A