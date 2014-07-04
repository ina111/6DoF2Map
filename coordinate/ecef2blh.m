function [phi, ramda, height] = ecef2blh(x, y, z)
	% ECEF���W����ܓx�o�x���x�ɕϊ�
	% �ܓx�o�x���x�̃h�C�c��ǂ݂̓�����BLH
	% �n�����S�n���Œ���WECEF(Earth Centered Earth Fixed)
	% phi:�ܓx[deg]
	% ramda:�o�x[deg]
	% height:WGS84�̕��ϊC�ʍ��x[m]
	% x,y,z:ECEF���W�ł̈ʒu[m]
	% ////WGS84�̒萔
	pi_GPS = 3.1415926535898; % GPS�֘A�Ŏg����΂̒萔
	a = 6378137.0;	% WGS84�̒���[m]
	one_f = 298.257223563;	% �G����f��1/f�i�����x�j
	b = a * (1.0 - 1.0 / one_f);	% WGS84�̒Z��[m] b = 6356752.314245
	e2 = (1.0 / one_f) * (2.0 - (1.0 / one_f));	% ��ꗣ�S��e��2��
	ed2 = (e2 * a * a / (b * b));	% ��񗣐S��e'��2��
	n = @(phi_n) a / sqrt(1.0 - e2 * sin(deg2rad(phi_n))^2); % �����֐�
	% n = a / sqrt(1.0 - e2 * sin(deg2rad(phi))^2);	% ���̈ܓx�ł�WGS84�ȉ~�̍�
	p = sqrt(x^2 + y^2);	% ���݈ʒu�ł̒n�S����̋���[m]
	theta = atan2(z*a, p*b);	% [rad]
	% ///�萔��`�I��
	phi = rad2deg(atan2((z + ed2 * b * sin(theta)^3), p - e2 * a * cos(theta)^3));
	ramda = rad2deg(atan2(y,x));
	height = p / cos(deg2rad(phi)) - n(phi);

	% [x,y,z] = blh2ecef(42,131,2)
	% [phi,ramda,h] =ecef2blh(x,y,z)