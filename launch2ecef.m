function [x, y, z] = launch2ecef(u, e, n, xr, yr, zr)
	% �˓_���W�n����ECEF���W�n�֍��W�ϊ�
	% L:u,e,n[m]
	% ECEF:x,y,z[m]
	% ECEF���W��̎Q�ƈʒu�i�˓_�j:xr,yr,zr[m]
	% �˓_�̈ܓx�o�x
	[phi, ramda, height] = ecef2blh(xr,yr,zr);
	phi = deg2rad(phi);
	ramda = deg2rad(ramda);
	% ECEF����launch���W�ւ̉�]�N�H�[�^�j�I������
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