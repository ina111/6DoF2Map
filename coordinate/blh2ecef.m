function [x, y, z] = blh2ecef(phi, ramda, height)
% BLH2ECEF �ܓx�o�x���x����ECEF���W�ɕϊ�
    % �ܓx�o�x���x�̃h�C�c��ǂ݂̓�����BLH
    % �n�����S�n���Œ���WECEF(Earth Centered Earth Fixed)
    % @param phi:�ܓx[deg]
    % @param ramda:�o�x[deg]
    % @param height:WGS84�̕��ϊC�ʍ��x[m]
    % @output x,y,z:ECEF���W�ł̈ʒu[m]
    
    % ////WGS84�̒萔
	pi_GPS = 3.1415926535898; % GPS�֘A�Ŏg����΂̒萔
	a = 6378137.0;	% WGS84�̒���[m]
	one_f = 298.257223563;	% �G����f��1/f�i�����x�j
	b = a * (1.0 - 1.0 / one_f);	% WGS84�̒Z��[m] b = 6356752.314245
	e2 = (1.0 / one_f) * (2.0 - (1.0 / one_f));	% ��ꗣ�S��e��2��
	ed2 = (e2 * a * a / (b * b));	% ��񗣐S��e'��2��
	% n = inline(a / sqrt(1.0 - e2 * sin(deg2rad(phi))^2), 'phi');
	n = a / sqrt(1.0 - e2 * sin(deg2rad(phi))^2);	% ���̈ܓx�ł�WGS84�ȉ~�̍�
	% ///�萔��`�I��

    x = (n + height) * cos(deg2rad(phi)) * cos(deg2rad(ramda));
	y = (n + height) * cos(deg2rad(phi)) * sin(deg2rad(ramda));
	z = (n * (1 - e2) + height) * sin(deg2rad(phi));