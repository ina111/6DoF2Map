function dq = quat_diff(quat, omega, dt)
	% クォータニオンの微分方程式
	% dq:クォータニオン微小変化量
	% quat:その時のクォータニオン
	% omega:計測した角速度[rad/s]
	% dt:サンプリング間隔[s]
	% dq = 0.5 * [-q(2) -q(3) -q(4);...
	% 			 q(1)  q(4) -q(3);...
	% 			-q(4)  q(1)  q(2);...
	% 			 q(3) -q(2)  q(1)] * omega' .* dt;
	dq = 0.5 * ...
		[0        -omega(1)  -omega(2) -omega(3);...
		 omega(1)  0         -omega(3)  omega(2);...
		 omega(2)  omega(3)   0        -omega(1);...
		 omega(3) -omega(2)  omega(1)  0] * quat' .* dt;
