function [x, y, z] = launch2ecef(u, e, n, xr, yr, zr)
	% 射点座標系からECEF座標系へ座標変換
	% L:u,e,n[m]
	% ECEF:x,y,z[m]
	% ECEF座標上の参照位置（射点）:xr,yr,zr[m]
	% 射点の緯度経度
	[phi, ramda, height] = ecef2blh(xr,yr,zr);
	phi = deg2rad(phi);
	ramda = deg2rad(ramda);
	% ECEFからlaunch座標への回転クォータニオン生成
	% quat_ecef2launch = quat_product(rot2quat(ramda, [0 0 1]), rot2quat(phi, [0 1 0]));
	% quat_launch2ecef = quat_conj(quat_ecef2launch);
	% xyz = quat_product(quat_ecef2launch, [0 u e n]);
	% xyz = quat_product(xyz, quat_launch2ecef);
	% x = xyz(2) + xr;
	% y = xyz(3) + yr;
	% z = xyz(4) + zr;
	x = -sin(phi)*cos(ramda)*n - sin(ramda)*e - cos(phi)*cos(ramda)*(-u) + xr;
	y = -sin(phi)*sin(ramda)*n + cos(ramda)*e - cos(phi)*sin(ramda)*(-u) + yr;
	z = cos(phi)*n - sin(phi)*(-u) + zr;