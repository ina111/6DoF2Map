function q3 = quat_product(q1,q2)
	% クォータニオンの掛け算
	% q1とq2の掛け算 q1*q2
	q3 = [ q1(1) -q1(2) -q1(3) -q1(4);...
		   q1(2)  q1(1) -q1(4)  q1(3);...
		   q1(3)  q1(4)  q1(1) -q1(2);...
		   q1(4) -q1(3)  q1(2)  q1(1)] * q2';