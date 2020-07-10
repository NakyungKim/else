/* [문제3_sub.sas] */

*** 작업 (1) 일부 ****************;

input customer_id $ / @10 grade $ / loan yen12. #4;
if grade="MVP" then rate=0.04;
	else if grade="VIP" then rate=0.045;

balance=loan;
array mon_int{12};
array mon_pay{12};
do year=1 to 2;
	do month=1 to 12;
		mon_int{month} = balance * (rate/12);                * 매월 갚을 이자(균등상환 조건);
		mon_pay{month} = (loan/24) + mon_int{month};  * 매월 갚을 이자+원금;
		balance = balance - (loan/24);                           * 균등상환 조건;
		year_int = sum(of mon_int{*});                           * 각 년도에 갚은 총 이자;
	end;
	cum_total_int + year_int;                                        * 각 년도차에 갚은 누적 이자;
	output; 
end;
format rate percent6.1 loan  mon_int1--mon_pay12  year_int cum_total_int yen12.;
drop month balance;
