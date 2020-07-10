/* [����3_main.sas] */

*** �۾� (1) ****************;
libname raw "C:\Class";
libname mylib "C:\Class\Final";
data mylib.one;	infile "C:\Class\q3_customer_01.txt" firstobs=9;
	%include "C:\Class\Final\����3_sub.sas";     
run;
data mylib.two;
	infile "C:\Class\q3_customer_02.txt" firstobs=9;
	%include "C:\Class\Final\����3_sub.sas"; 
run;

*** �۾� (2) ****************;
ods pdf file="C:\Class\Final\result_one.pdf";
	title1 "******************************";
	title2 "ù ��° ���� ���� ���";
	title3 "******************************";
	proc print data=mylib.one split="/";
		id year;	
		label year_int="�� �⵵�� / ���� / �� ���ھ�" cum_total_int="�� �⵵���� / ���� /���� ���ھ�";
	run;
ods pdf close;
ods pdf file="C:\Class\Final\result_two.pdf";
	title1 "******************************";
	title2 "�� ��° ���� ���� ���";
	title3 "******************************";
	proc print data=mylib.two split="/";
		id year;
		label year_int="�� �⵵�� / ���� / �� ���ھ�" cum_total_int="�� �⵵���� / ���� /���� ���ھ�";
	run;
ods pdf close;

