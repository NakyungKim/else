/* [문제2] */

*** 작업 (1) ****************;
libname mylib "C:\Class\Final";
libname raw "C:\Class";
proc sort data=raw.q2_math out=mylib.q2_math_sorted;   * <<== 정렬된 자료 별도로 저장;
	by no;
run;
proc sort data=raw.q2_sci out=mylib.q2_sci_sorted;        * <<== 정렬된 자료 별도로 저장;
	by no;
run;
proc sort data=raw.q2_eng out=mylib.q2_eng_sorted;     * <<== 정렬된 자료 별도로 저장;
	by no;
run;

*** 작업 (2) ****************;
data mylib.q2_all (drop=math sci eng);
	merge mylib.q2_math_sorted mylib.q2_sci_sorted mylib.q2_eng_sorted; 
	by no course; 
	if status="student" then ave=sum(math, sci, eng)/3;  *<<= 결측인 점수는 0점으로 처리하여 계산; 
run;

*** 작업 (3) ****************;
proc sort data=mylib.q2_all out=q2_all_sorted;
	by descending ave;
run;
data mylib.student(drop=teachername course today) mylib.teacher(keep=teachername status course birthday age);
	set q2_all_sorted;
	if today=. then today=22096;
	age=compress("만" || (int((today-birthday)/365))) || "세";   *<<== 만 연령 ;
	if status="student" then  do;
	                                     if ave >= 90 then A_count+1;
										 	else if ave >= 80 then B_count+1;
											else CDF_count+1;
                                         rank=_n_ || "등";
									     output mylib.student;
	                                 end;
		else output mylib.teacher;
	format birthday date9. ave 6.2;
run;


