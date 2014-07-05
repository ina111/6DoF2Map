function quat = attitude(azimth_deg, elevation_deg)
% ATTITUDE �����̕��ʊp�Ƌp[deg]����N�H�[�^�j�I������
% 	@param azimth_deg: ���ʊp[deg] (1x1)
% 	@param elevation_deg: �p[deg] (1x1)
% 	@return quat: �N�H�[�^�j�I��[-] (4x1)
	azimth_rad = azimth_deg/180.0*pi;
	quat_az = [cos(-0.5*azimth_rad) sin(-0.5*azimth_rad)*[-1 0 0]];
	elevation_rad = elevation_deg/180.0*pi;
	roty = elevation_rad-0.5*pi;
	quat_el = [cos(-0.5*roty) sin(-0.5*roty)*[0 1 0]];
	quat = quatmultiply(quat_el, quat_az)';
end
