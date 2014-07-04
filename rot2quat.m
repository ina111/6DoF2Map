function quat = rot2quat(deg, vec)
	% ��]�����x�N�g���Ɖ�]�p�����]�N�H�[�^�j�I�����쐬
	% quat:�쐬���ꂽ�N�H�[�^�j�I��[q0,q1,a2,q3]
	% deg:��]�p[deg]
	% vec:��]�����x�N�g��[x, y, z]�֐����ŒP�ʃx�N�g���ɕϊ�
	tmp = norm([vec(1), vec(2), vec(3)]);
	v = [vec(1)/tmp, vec(2)/tmp, vec(3)/tmp];
	deg2 = deg / 2;
	quat = [cosd(deg2), sind(deg2)*v(1), sind(deg2)*v(2), sind(deg2)*v(3)];