/* ����2 */


/* (1) <one>, <two> �����ͼ� ���� */
data one;
	infile "C:\�������\����\q2_raw01.txt" firstobs=10;
	input no @5 math_per percent7. eng_score @19 name $6. gender $ @;
	if gender="M" then input award yen7.;
		else if gender="F" then input award dollar6.;
run;
data two;
	infile "C:\�������\����\q2_raw02.txt" firstobs=10;
	input no @5 math_per percent7. eng_score @19 name $6. gender $ @;
	if gender="M" then input award yen7.;
		else if gender="F" then input award dollar6.;
run;

/* (2) <all> �����ͼ� ���� */
*** retain ���� Ȱ���Ͽ� �ߺ� ����ġ ����� ��;    
proc sort data=one;  by no;  run;
proc sort data=two;  by no;  run;
data all (drop=oldno);
	merge one two; 
	by no;
	if oldno=no then delete;
	oldno=no;	
	ave=(math_per+(eng_score/100))/2;
	retain oldno;
run;

/* (3) final �����ͼ� ���� */  
proc sort data=all out=all_sorted;  by gender descending ave;  run;
data final (keep=no name gender f_count m_count ave rank);
	set all_sorted; 
	f_count + (gender="F");
	m_count + (gender="M");
	if gender="F" then rank = compress(gender) || " ������ "  || compress(f_count)|| "��";
		else rank = compress(gender) || " ������ "  || compress(m_count)|| "��";
	format ave percent9.2;
run;
