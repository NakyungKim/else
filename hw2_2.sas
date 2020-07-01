/* HW2_2 */

/* 문제2 */

*** <작업1> *** 
     1반 학생들에 대한 자료를 합하여 SAS 데이터셋 (work 밑에) class1 생성 (변수 SSN 기준) 
     변수 class=1 생성;

libname mine "c:\전산통계\과제";

proc sort data=mine.class1_math out=class1_math;
	by descending ssn;
run;
proc sort data=mine.class1_eng out=class1_eng;
	by descending ssn;
run;
proc sort data=mine.class1_info out=class1_info;
	by descending ssn;
run;

data class1;
	merge class1_math class1_eng class1_info;
	by descending ssn;
	class="1반";
run;

*** <작업2> ***
     2반 학생들에 대한 자료를 합하여 SAS 데이터셋 (work 밑에) class1 생성 (변수 SSN 기준) 
     변수 class=2 생성;

proc sort data=mine.class2_math out=class2_math;
	by descending ssn;
run;
proc sort data=mine.class2_eng out=class2_eng;
	by descending ssn;
run;
proc sort data=mine.class2_info out=class2_info;
	by descending ssn;
run;

data class2;
	merge class2_math class2_eng class2_info;
	by descending ssn;
	class="2반";
run;

*** <작업3> ***
     1반, 2반 학생들 자료를 합하여 SAS 데이터셋 (work 밑에) all 생성 (변수 SSN 내림차순 기준) 
     추가 변수들 생성 (fullname, total, average, grade) 
	 math 값이 결측이면 0으로, eng 값이 결측이면 0으로 각각 재부여 ;

data all (drop=lastname firstname);
	set class1 class2;
	by descending ssn;
	if eng=. then eng=0;
	if math=. then math=0;
	fullname=compress(lastname) || ", " || compress(firstname) ;
	total=sum(math, eng);          
	average=mean(math, eng);   
	if average >= 90 then grade="A";
		else if average >= 80 then grade="B";
		else if average >= 70 then grade="C";
		else if average >= 60 then grade="D";
		else grade="F";
	* select/when 구문으로도 가능;
run;

*** <작업4> ***
     작업3에서 생성된 SAS 데이터셋 all 에서 
               grade = A인 관측치는 데이터셋 (C:\전산통계\과제 밑에) highpass로 내보내고 변수 status="HIGH PASS" ,
               grade = B, C, D인 관측치는 데이터셋 (C:\전산통계\과제 밑에) pass로 내보내고 변수 status="PASS" ,
               grade = F 인 관측치는 데이터셋 (C:\전산통계\과제 밑에) fail로 내보내고 변수 status="FAIL"       
     데이터셋 highpass 에는 변수 ssn,average, fullname, status 만 keep
     데이터셋 pass 에는 변수 ssn, average, grade, status 만 keep 
     데이터셋 fail 에는 변수 ssn, average, grade, status 만 keep ;

data mine.highpass(keep=ssn average fullname status) mine.pass(keep=ssn average grade status) mine.fail(keep=ssn average grade status);
	set all;
	if grade="A" then                     do; 
								                   status="HIGH PASS";
                                                   output mine.highpass;
						                       end;
		else if grade in ("B", "C", "D") then do;
													status="PASS";
                                                    output mine.pass;
												end;
		else                                  do;
													 status="FAIL";
                                                     output mine.fail;
												end;	
	* select/when 구문으로도 가능;
run;


