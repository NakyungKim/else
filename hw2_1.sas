/* HW2_1 */

/* ¹®Á¦1 */

data one;
	do a=2 to 18 by 1;
		do b=1 to 18 by 1;
			ab=a*b;
			output;
		end;
	end;
run;

data two;
	set one;
	if a <= 9 and b <= 9;
	dan = a || "´Ü";
 	file print;
	if _n_=1 then put "*******************";
	put a "X " b "= " ab 5.2;
	if b=9 then put "*******************";
run;



