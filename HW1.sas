/* HW1 */

** �۾�(1) **;
** ������ major, id, fullname, exam1, exam2, exam3, final ������� ;
LIBNAME mine "C:\�������\����";
DATA mine.one;
	INFILE "C:\�������\����\HW1_data.txt" FIRSTOBS=9;
	INPUT major $ 1-11 id #3 @7 fullname $7. #2 exam1-exam3 #3 final;
	* INPUT major $11. id #3 fullname $ 7-13 #2 exam1 exam2 exam3 #3 final 5.; 
	* INPUT major $11. id #3 fullname $ 7-13 #2 exam1 exam2 exam3 #3 @2 final 4.;
	* INPUT major $11. id #3 fullname $ 7-13 #2 exam1 exam2 exam3 #3 final 2-5;
RUN;

** �۾�(2) **;
DATA mine.new (DROP=fullname exam1-exam3 final);
	SET mine.one;
	lastname=SUBSTR(fullname, 1, 2);
	firstname=SUBSTR(fullname, 4);
	total=SUM(of exam1-exam3 final);
	IF total GE 80 THEN grade="Pass";
		ELSE grade="Fail";
RUN;

** �۾�(3) **;
PROC SORT DATA=mine.new;
	BY DESCENDING total;
RUN;

** �۾�(4) **;
DATA mine.finaldata;
	SET mine.new;
	rank=_n_ || "��";
RUN;

** �۾�(5) **;
PROC EXPORT DATA= MINE.FINALDATA 
            OUTFILE= "C:\�������\����\finaldata" 
            DBMS=TAB REPLACE;
     PUTNAMES=YES;
RUN;

