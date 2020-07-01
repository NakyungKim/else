/* HW2_2 */

/* ����2 */

*** <�۾�1> *** 
     1�� �л��鿡 ���� �ڷḦ ���Ͽ� SAS �����ͼ� (work �ؿ�) class1 ���� (���� SSN ����) 
     ���� class=1 ����;

libname mine "c:\�������\����";

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
	class="1��";
run;

*** <�۾�2> ***
     2�� �л��鿡 ���� �ڷḦ ���Ͽ� SAS �����ͼ� (work �ؿ�) class1 ���� (���� SSN ����) 
     ���� class=2 ����;

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
	class="2��";
run;

*** <�۾�3> ***
     1��, 2�� �л��� �ڷḦ ���Ͽ� SAS �����ͼ� (work �ؿ�) all ���� (���� SSN �������� ����) 
     �߰� ������ ���� (fullname, total, average, grade) 
	 math ���� �����̸� 0����, eng ���� �����̸� 0���� ���� ��ο� ;

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
	* select/when �������ε� ����;
run;

*** <�۾�4> ***
     �۾�3���� ������ SAS �����ͼ� all ���� 
               grade = A�� ����ġ�� �����ͼ� (C:\�������\���� �ؿ�) highpass�� �������� ���� status="HIGH PASS" ,
               grade = B, C, D�� ����ġ�� �����ͼ� (C:\�������\���� �ؿ�) pass�� �������� ���� status="PASS" ,
               grade = F �� ����ġ�� �����ͼ� (C:\�������\���� �ؿ�) fail�� �������� ���� status="FAIL"       
     �����ͼ� highpass ���� ���� ssn,average, fullname, status �� keep
     �����ͼ� pass ���� ���� ssn, average, grade, status �� keep 
     �����ͼ� fail ���� ���� ssn, average, grade, status �� keep ;

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
	* select/when �������ε� ����;
run;


