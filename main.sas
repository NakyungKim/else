/* <HW3> [문제1] */
/* main.sas */

*== (1) rawdata 불러오기 ============================================;
DATA one;
	INFILE 'C:\전산통계\과제\q1_rawdata.txt' FIRSTOBS=22;
	INPUT id @8 birth MMDDYY10. @19 date MMDDYY10. dept $ 30-44 @47 salary YEN10. y2018m12 y2019m01-y2019m11 goal;
RUN;


*== calculation.sas 프로그램 파일(작업 (2) 부분) 불러오기 ==============;
%INCLUDE 'C:\전산통계\과제\calculation.sas';


*== (3) 데이터셋 final 생성 ============================================;
PROC SORT DATA=two OUT=two_sorted;
	BY DESCENDING dept;  
RUN; 
DATA final (KEEP=dept total_dept);
	SET two_sorted; 
	BY DESCENDING dept;
	IF FIRST.dept=1 THEN total_dept=0;
	total_dept + total_income;
	IF LAST.dept=1 THEN OUTPUT;
		* (또는) IF LAST.dept;
	FORMAT total_dept YEN14.1 ;
RUN;


*== (4) 데이터셋 two & final 내용 pdf 파일로 출력 =======================;

ODS PDF FILE='C:\전산통계\과제\results.pdf';

	TITLE '개인별 (2019년) 보너스 및 급여';
	PROC PRINT DATA=two; 
	RUN;

	TITLE '부서별 (2019년) 총 지급된 보너스 및 급여';
	PROC PRINT DATA=final SPLIT='*';
		LABEL total_dept='부서별 * (2019년) * 총지급액';
	RUN;

ODS PDF CLOSE;
