% �ǂݍ��ރt�@�C�����imain.m�t�@�C���Ɠ����f�B���N�g���ɂ��邱�Ɓj
% csvfile = 'camui2012_sample_copy.csv';
csvfile = 'CanSatApage2.csv';
% csvfile = 'CanSat2014.csv'

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
SHOW_PLOT = 1;
OUTPUT_GPS = 1;
output_GPS_filename = 'CanSatsample';
% =======�ݒ荀�ڂ͈ȏ�A�ȉ��萔======
% earth_rate = [0 0 7.2921151467e-5];
