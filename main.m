% �����x�W���C����6���̊����v���̒l������W�ϊ���p���āA�p���A���x�A�ʒu�����߂�
% �X�g���b�v�_�E�����̊����v�����j�b�g�iIMU)�̒l�͋@�̍��W�n�ł̌v���l�Ȃ̂�
% �������W�n�ł̒l�ɕϊ�����B
% �܂��A�֗��̂��߂Ɉܓx�o�x���x�ɕϊ����AGoogle Earth�ŕ\���ł���悤�ɂ���B
% - - - -
% �g�p������W�n
% �@�̍��W�n(Body Frame)�F�@�̂ɌŒ肳�ꂽ���W�n�B�@�̃m�[�Y������x���Ƃ��Ă���
% �˓_���W�n�iUEN):�˓_���S�̒n�\�ɕ��s�ȍ��W�n�BX-Y-Z��Up-East-North�ɍ��킹�Ă���B
% �n�����S�n���Œ���W�n(ECEF)�F�n�����S�����_��x�����ܓx�o�x0�x�A���������]���ɒ�߂��^�����W�n
% �n�����S�������W�iECI)�F�n�����S�̊������W�����͎��]���B
% ���n���W�n(BLH)�F�ܓx�A�o�x�A�ȉ~�̍��x�̍��W�n�B�������W�n�ł͂Ȃ��BWGS-84����
% - - - -
% ���̌v�Z�̒��ӓ_
% �˓_���W�n�͖{���n���̎��]����]�Ȃǉ^�����W�n�ł���A
% �R���I���͂≓�S�͂Ȃǂ݂̂����̗͂������������ł́A���W�n�͓����Ȃ����������W�n�Ƃ��čl���Ă���B
% ���������Č덷��������B
% - - - -
% �ǂݍ��ރt�@�C���̌`��
% <time,><acc>,<acc>,<acc>,<gyro>,<gyro>,<gyro><CR><LF>
% - - - -
% 2013�N9��30���@���M��
% 2014�N7��5���@���M��@�傫���ύX
clear all

addpath ./coordinate

% �ǂݍ��ރt�@�C�����imain.m�t�@�C���Ɠ����f�B���N�g���ɂ��邱�Ɓj
% csvfile = 'camui2012_sample_copy.csv';
csvfile = 'CanSatApage2.csv';
% ���O�J�n���ɂ����Ă�
% UTC�̐����[year, month, day]JST�ł͂Ȃ�UTC�����ł̓��t�Ȃ̂ő����Ȃǒ���
day_ref = [2013, 10, 1];
% time_ref: ���{���ԁiJST)[HHMMSS.SS] ex.12��34��56.78�b->123456.78
time_ref = 120000.00;
% �ܓx�o�x�A�ȉ~�̍��x[deg,deg,m] �x�\���Ȃ̂Œ���
% blh_init = [42.505992,143.456970,30];
blh_init = [43.5807, 142.002083, 50];
% �˓_���W�iUEN)�ł̏����ʒu�@�ʏ�[0 0 0]
pos_init = [0 0 0];
% ���ʊp�A�p[deg]
azimth_deg_init = -10;
elevation_deg_init = -90.1;
roll_deg_init = 0;	%�@�̂�yz���ʂ̏d�͕����Ƃ����̊p�x�����������[���p
% ���������[���p��0�̂Ƃ�y���̏d�͂ɂ������x�̓[��
% �O���t�̊J�n����[s]�ƏI������[s]�̐ݒ�
plot_time_start = 528160;
plot_time_end = 528225;

% ----
% CAMUI�񋟂̃T���v���f�[�^�ł�
% �����x�F�s�b�`�A���[���A���[�̏�
% �W���C���F���[���A���[�A�s�b�`�̏�
% time_line = 1;
% acc_roll_line  = 3; acc_pitch_line  = 2; acc_yaw_line  = 4;
% gyro_roll_line = 5; gyro_pitch_line = 7; gyro_yaw_line = 6;
time_line = 2;
acc_roll_line  = 3; acc_pitch_line  = 4; acc_yaw_line  = 5;
gyro_roll_line = 6; gyro_pitch_line = 7; gyro_yaw_line = 8;

% �����l�ƃX�P�[���t�@�N�^[LSB/(deg/s),LSB/g]
% acc_mean = 0;
% acc_scale = 1;
% gyro_mean = 0;
% gyro_scale = 1;


acc_x_mean = 32768; acc_y_mean = 32768; acc_z_mean = 32768;
acc_scale = 2048;
gyro_x_mean = 32755; gyro_y_mean = 32783; gyro_z_mean = 32769;
gyro_scale = 16.4;
% ----
% �v���b�g�AGPS�A�E�g�v�b�g��ON/OFF�@ON:1,OFF:0
SHOW_PLOT = 0;
OUTPUT_GPS = 1;
output_GPS_filename = 'CanSatsample';
% =======�ݒ荀�ڂ͈ȏ�A�ȉ��萔======
% earth_rate = [0 0 7.2921151467e-5];

% =====

% �t�@�C����������x�ɂ��ړ��ʂƃW���C���ɂ���]�p��ǂݍ��ށB
csv = csvread(csvfile);
csv_length = length(csv);

% ECEF���W�n�ɂ������郍�O�J�n���̈ʒu[m]
[xr,yr,zr] = blh2ecef(blh_init(1),blh_init(2),blh_init(3));
% �������ʊp�Ƌp�ƃ��[���p���N�H�[�^�j�I���\��
quat_elevation = rot2quat(elevation_deg_init - 90, [0 0 1]);
quat_azimth  = rot2quat(azimth_deg_init - 90, [1 0 0]);
quat_roll = rot2quat(roll_deg_init, [1 0 0]);
quat_body2launch = quat_product(quat_elevation, quat_azimth);
quat_body2launch = quat_product(quat_body2launch, quat_roll);
% �˓_���W�n�ł̑��x�A�ʒu�A�N�H�[�^�j�I���A�����]���s��(DCM)�̏�����
vel_launch_prev = [0 0 0];
pos_launch_prev = pos_init;
quat_prev = quat_body2launch';	%�N�H�[�^�j�I���̏�����
% dcm_prev = zeros(3);

% ���C�����[�v
line = 2;
% acc_x,gyro_x�̓m�[�Y�����i���[���ω�����������j
% acc_y,gyro_y�̓s�b�`�ω����������
% acc_z,gyro_z�̓��[�ω����������
% ���ςƃX�P�[���t�@�N�^�[���l�����A[g][deg/s]�ɕϊ�
time = csv(:,time_line);
acc_x = (csv(:,acc_roll_line) - acc_x_mean) ./ acc_scale;
acc_y = (csv(:,acc_pitch_line) - acc_y_mean) ./ acc_scale;
acc_z = (csv(:,acc_yaw_line) - acc_z_mean) ./ acc_scale;
gyro_x = (csv(:,gyro_roll_line) - gyro_x_mean) ./ gyro_scale;
gyro_y = (csv(:,gyro_pitch_line)- gyro_y_mean) ./ gyro_scale;
gyro_z = (csv(:,gyro_yaw_line) - gyro_z_mean) ./ gyro_scale;
% �z��̏�����
quat_delta = zeros(csv_length,4);
quat_body2launch = zeros(csv_length,4);
euler_rad = zeros(csv_length,3);
euler_deg = zeros(csv_length,3);
vel_launch = zeros(csv_length,3);
pos_launch = zeros(csv_length,3);
pos_ECEF = zeros(csv_length,3);
pos_blh = zeros(csv_length,3);
pos_blh(1,:) = blh_init;	% �ܓx�o�x���x�̏�����

for i =  2:csv_length
	acc = [acc_x(i), acc_y(i), acc_z(i)] .* 9.8;
	gyro_deg = [gyro_x(i), gyro_y(i), gyro_z(i)];
	gyro = deg2rad(gyro_deg);
	if i == 1
		dt = time(i);
	else
		dt = time(i) - time(i-1);
	end
	quat_delta(i,:) = quat_diff(quat_prev, gyro, dt);
	quat_body2launch(i,:) = quat_prev + quat_delta(i,:);
	quat_body2launch(i,:) = quat_normalize(quat_body2launch(i,:));
	dcm_body2launch= quat2dcm(quat_body2launch(i,:));
	euler(i,:) = quat2euler(quat_body2launch(i,:));
	euler_deg(i,:) = rad2deg(euler(i,:));
	[vel_launch(i,:),pos_launch(i,:)] = position_eq(vel_launch_prev, pos_launch_prev, dt, acc, dcm_body2launch);
	[pos_ECEF(i,1),pos_ECEF(i,2),pos_ECEF(i,3)] = launch2ecef(pos_launch(i,1),pos_launch(i,2),pos_launch(i,3),xr,yr,zr);
	[pos_blh(i,1),pos_blh(i,2),pos_blh(i,3)] = ecef2blh(pos_ECEF(i,1),pos_ECEF(i,2),pos_ECEF(i,3));

	quat_prev = quat_body2launch(i,:);
	vel_launch_prev = vel_launch(i,:);
	pos_launch_prev = pos_launch(i,:);
end

% /////
	% �UDOF�̃Z���T�f�[�^����GPS�f�[�^�iNMEA GPGGA�j�̃f�[�^��ɕϊ����Aoutput�f�B���N�g����str.nmea�ŕۑ�
% /////
if OUTPUT_GPS
	% str = 'sample';
	disp('Making NMEA file...')
	blh2GPSdata(output_GPS_filename,time,pos_blh,time_ref, day_ref);
end

% ////////////
if SHOW_PLOT
figure;
plot(time,acc_x,time,acc_y,time,acc_z);
title('accelation [m/s2]');
xlabel('time [s]');
ylabel('accelaration [G]');
% ylim([-0.07,0.1]);
xlim([plot_time_start,plot_time_end]);
legend('x','y','z');
grid on

figure;
plot(time,gyro_x,time,gyro_y,time,gyro_z);
xlim([plot_time_start,plot_time_end]);
title('gyro [deg/s]')
legend('x','y','z');
grid on

figure;
plot(time,quat_delta(:,1),'+',time,quat_delta(:,2),'+',time,quat_delta(:,3),'+',time,quat_delta(:,4),'+');
xlim([plot_time_start,plot_time_end]);
title('quartenion_delta')
legend('q0', 'q1', 'q2', 'q3')
grid on

figure;
plot(time,quat_body2launch(:,1),time,quat_body2launch(:,2),time,quat_body2launch(:,3),time,quat_body2launch(:,4));
xlim([plot_time_start,plot_time_end]);
title('quartenion');
legend('q0', 'q1', 'q2', 'q3')
grid on

figure;
plot(time,euler_deg(:,1),time,euler_deg(:,2),time,euler_deg(:,3));
xlim([plot_time_start,plot_time_end]);
title('euler[deg]')
legend('roll','pitch','yaw');
grid on

figure;
plot(time,vel_launch(:,1),time,vel_launch(:,2),time,vel_launch(:,3));
xlim([plot_time_start,plot_time_end]);
title('velocity_launch[m/s]')
legend('U','E','N');
grid on

figure;
plot(time,pos_launch(:,1),time,pos_launch(:,2),time,pos_launch(:,3));
xlim([plot_time_start,plot_time_end]);
ylim([-100,1000]);
title('position_launch[m/s]')
legend('U','E','N');
grid on

% 3D�v���b�g�ɕ\�����鐔
num_3d_plot = 5000;
pos_launch = pos_launch(1:num_3d_plot,:);

figure;
plot3(pos_launch(:,3), pos_launch(:,2), pos_launch(:,1));
xlabel('North');ylabel('East');zlabel('UP')
xlim([-5000,5000]);ylim([-5000,5000]);zlim([0,10000]);
grid on
axis square

end