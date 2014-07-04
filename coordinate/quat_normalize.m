function q = quat_normalize(q0)
	% �N�H�[�^�j�I���̐��K��
	% q:���K�������N�H�[�^�j�I��, q0:���K������O�̃N�H�[�^�j�I��
	% if q0(1) < 0.0
	% 	q0(1) = -q0(1);
	% 	q0(2) = -q0(2);
	% 	q0(3) = -q0(3);
	% 	q0(4) = -q0(4);
	% end
	tmp = sqrt(q0(1)^2 + q0(2)^2 + q0(3)^2 + q0(4)^2);
	q(1) = q0(1) / tmp;
	q(2) = q0(2) / tmp;
	q(3) = q0(3) / tmp;
	q(4) = q0(4) / tmp;
