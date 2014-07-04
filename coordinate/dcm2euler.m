function euler = dcm2euler(dcm)
	% �����]���s�񂩂�I�C���[�p���Z�o
	% euler:�I�C���[�p[rad], dcm:�����]���s��
	% degree�ɂ���ɂ�rad2deg��	matlab�֐����g��
	euler = [atan2(dcm(2,3), dcm(3,3));...
			 atan2(-dcm(1,3), sqrt(dcm(2,3)^2 + dcm(3,3)^2));...
			 atan2(dcm(1,2), dcm(1,1))];
