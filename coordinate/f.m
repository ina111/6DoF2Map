function y = f(x)
	acc_init = [-9.6; 0.025; 0.04];
	acc_init = acc_init .* 9.8;
	tmp = norm(acc_init);
	acc_init = acc_init ./ tmp;
	g = 9.8;
	quat_elevation = rot2quat(x(1) - 90, [0 0 1]);
	quat_azimth  = rot2quat(x(2) - 90, [1 0 0]);
	quat_body2launch = quat_product(quat_elevation, quat_azimth);
	dcm = quat2dcm(quat_body2launch);
	y = dcm * acc_init - [g; 0; 0];
end

% [x , info] = fsolve('f', [0; 0])

