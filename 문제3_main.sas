/* [문제3_main.sas] */

*** 작업 (1) ****************;
libname raw "C:\Class";
libname mylib "C:\Class\Final";
data mylib.one;	infile "C:\Class\q3_customer_01.txt" firstobs=9;
	%include "C:\Class\Final\문제3_sub.sas";     
run;
data mylib.two;
	infile "C:\Class\q3_customer_02.txt" firstobs=9;
	%include "C:\Class\Final\문제3_sub.sas"; 
run;

*** 작업 (2) ****************;
ods pdf file="C:\Class\Final\result_one.pdf";
	title1 "******************************";
	title2 "첫 번째 고객에 대한 결과";
	title3 "******************************";
	proc print data=mylib.one split="/";
		id year;	
		label year_int="각 년도에 / 갚은 / 총 이자액" cum_total_int="각 년도차에 / 갚은 /누적 이자액";
	run;
ods pdf close;
ods pdf file="C:\Class\Final\result_two.pdf";
	title1 "******************************";
	title2 "두 번째 고객에 대한 결과";
	title3 "******************************";
	proc print data=mylib.two split="/";
		id year;
		label year_int="각 년도에 / 갚은 / 총 이자액" cum_total_int="각 년도차에 / 갚은 /누적 이자액";
	run;
ods pdf close;

