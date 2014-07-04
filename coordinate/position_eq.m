function [v_I, r_I] = position_eq(v_I_0,r_I_0,dt,a,dcm)
	% �����x��DCM���瑬�x�ƈʒu���v�Z
	% dt:���ԊԊu[s], a:�����x[m/s2], dcm:�����]���s��
	if v_I_0 == NaN
		v_I_0 = 0;
	end
	g = 9.8; % �d�͉����x
	v_I = v_I_0' + dcm * a' * dt + [-g;0;0] * dt;
	r_I = r_I_0' + v_I * dt;
end
