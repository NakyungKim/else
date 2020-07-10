/* [문제1] */

libname mylib "C:\Class\Final";
filename mine "C:\Class";    * <<=== filename 문장 함께 이용하기 ;
data mylib.q1_math;
	infile mine(q1_math.txt) dlm="/" dsd firstobs=8 obs=12;
	length teachername name $16;
	input status $ @;
	if status="teacher" then input teachername $ course $ birthday yymmdd10. ; 
		else if status="student" then input name $ math no $ birthday yymmdd10. ; 
run;



		
