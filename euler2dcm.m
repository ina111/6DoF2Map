function dcm = euler2dcm(euler)
% �I�C���[�p��������]���s����Z�o
% dcm:�����]���s��Aeuler:�I�C���[�p[rad]
% z-y-x�`��
	s = sin(euler);
	c = cos(euler);
	dcm = [ c(2)*c(3),                 c(2)*s(3),                -s(2);...
		    s(1)*s(2)*c(3)+c(1)*s(3), -s(1)*s(2)*s(3)+c(1)*c(3),  s(1)*c(2);...
		   -c(1)*s(2)*c(3)+s(1)*s(3),  c(1)*s(3)*s(1)-s(1)*c(3),  c(1)*c(2)];
