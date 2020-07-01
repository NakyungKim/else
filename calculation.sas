/* <HW3> [문제1] */
/* calculation.sas */

*== (2) 데이터셋 two 생성 ============================================;
DATA two (drop=i y2018m12 y2019m01-y2019m11 goal salary);
	SET one;	
	age=INT((date-birth)/365);  * 입사일 현재 연령(만연령);
	ARRAY ym{12} y2018m12 y2019m01-y2019m11;
	ARRAY income{12} income01-income12;
	DO i=1 TO 12;
		IF ym{i}=. then ym{i}=0;
		IF (ym{i}/goal) >= 1.5 THEN income{i}=salary+(salary*2);
			ELSE IF (ym{i}/goal) >= 1 THEN income{i}=salary+salary;
			ELSE income{i}=salary;
	END;
	total_income=SUM(of income{*});
	FORMAT birth date  DATE9. income01-income12 total_income YEN13.1 ; 
RUN;
