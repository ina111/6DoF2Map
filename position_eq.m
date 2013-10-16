function [v_I, r_I] = position_eq(v_I_0,r_I_0,dt,a,dcm)
	% 加速度とDCMから速度と位置を計算
	% dt:時間間隔[s], a:加速度[m/s2], dcm:方向余弦行列
	if v_I_0 == NaN
		v_I_0 = 0;
	end
	g = 9.8; % 重力加速度
	v_I = v_I_0' + dcm * a' * dt + [-g;0;0] * dt;
	r_I = r_I_0' + v_I * dt;
end
