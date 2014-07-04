function euler = quat2euler(q)
	% �N�H�[�^�j�I������I�C���[�p���v�Z
	% euler:�I�C���[�p(roll,pitch yaw)[rad]�A q:�N�H�[�^�j�I��
	q = quat_normalize(q);
	q2 = q.^2;
	euler = [atan2(2*(q(1)*q(2)+q(3)*q(4)), 1-2*(q2(2)+q2(3)));...
			 asin(2*(q(1)*q(3) - q(4)*q(2)));...
			 atan2(2*(q(1)*q(4)+q(2)*q(3)), 1-2*(q2(3)+q2(4)))];
