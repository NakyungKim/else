/* <HW3> [����1] */
/* main.sas */

*== (1) rawdata �ҷ����� ============================================;
DATA one;
	INFILE 'C:\�������\����\q1_rawdata.txt' FIRSTOBS=22;
	INPUT id @8 birth MMDDYY10. @19 date MMDDYY10. dept $ 30-44 @47 salary YEN10. y2018m12 y2019m01-y2019m11 goal;
RUN;


*== calculation.sas ���α׷� ����(�۾� (2) �κ�) �ҷ����� ==============;
%INCLUDE 'C:\�������\����\calculation.sas';


*== (3) �����ͼ� final ���� ============================================;
PROC SORT DATA=two OUT=two_sorted;
	BY DESCENDING dept;  
RUN; 
DATA final (KEEP=dept total_dept);
	SET two_sorted; 
	BY DESCENDING dept;
	IF FIRST.dept=1 THEN total_dept=0;
	total_dept + total_income;
	IF LAST.dept=1 THEN OUTPUT;
		* (�Ǵ�) IF LAST.dept;
	FORMAT total_dept YEN14.1 ;
RUN;


*== (4) �����ͼ� two & final ���� pdf ���Ϸ� ��� =======================;

ODS PDF FILE='C:\�������\����\results.pdf';

	TITLE '���κ� (2019��) ���ʽ� �� �޿�';
	PROC PRINT DATA=two; 
	RUN;

	TITLE '�μ��� (2019��) �� ���޵� ���ʽ� �� �޿�';
	PROC PRINT DATA=final SPLIT='*';
		LABEL total_dept='�μ��� * (2019��) * �����޾�';
	RUN;

ODS PDF CLOSE;
