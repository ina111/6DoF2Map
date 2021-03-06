function dcm = euler2dcm(euler)
% オイラー角から方向余弦行列を算出
% dcm:方向余弦行列、euler:オイラー角[rad]
% z-y-x形式
	s = sin(euler);
	c = cos(euler);
	dcm = [ c(2)*c(3),                 c(2)*s(3),                -s(2);...
		    s(1)*s(2)*c(3)+c(1)*s(3), -s(1)*s(2)*s(3)+c(1)*c(3),  s(1)*c(2);...
		   -c(1)*s(2)*c(3)+s(1)*s(3),  c(1)*s(3)*s(1)-s(1)*c(3),  c(1)*c(2)];
