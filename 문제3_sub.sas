/* [����3_sub.sas] */

*** �۾� (1) �Ϻ� ****************;

input customer_id $ / @10 grade $ / loan yen12. #4;
if grade="MVP" then rate=0.04;
	else if grade="VIP" then rate=0.045;

balance=loan;
array mon_int{12};
array mon_pay{12};
do year=1 to 2;
	do month=1 to 12;
		mon_int{month} = balance * (rate/12);                * �ſ� ���� ����(�յ��ȯ ����);
		mon_pay{month} = (loan/24) + mon_int{month};  * �ſ� ���� ����+����;
		balance = balance - (loan/24);                           * �յ��ȯ ����;
		year_int = sum(of mon_int{*});                           * �� �⵵�� ���� �� ����;
	end;
	cum_total_int + year_int;                                        * �� �⵵���� ���� ���� ����;
	output; 
end;
format rate percent6.1 loan  mon_int1--mon_pay12  year_int cum_total_int yen12.;
drop month balance;
