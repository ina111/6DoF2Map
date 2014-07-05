function [] = blh2GPSdata(filename,time,blh,time_ref,day_ref)
	% �ܓx�o�x���x�̏�񂩂�[���I��GPS�f�[�^�i$GPGGA)�����B
	% Google Earth�ɓǂݍ��܂��邽�߂ɂ킴�킴���B
	% filename:�t�@�C����
	% time[:]:time_ref����̌o�ߎ���[s]
	% blh[:,3]:�ܓx�o�x���x[�ܓx�A�o�x�A���x][deg deg m]
	% time_ref:JST time[HHMMSS.SS] ex.123456.78
	% day_ref:UTC year,month,day[1x3][year, month, day] ex.[2013, 10,1]
	fileaddress = strcat('output/',filename,'.nmea');
	[fid, msg] = fopen(fileaddress, 'w');
	len = length(blh(:,1));

	for i = 1:len
		% $GPGGA�Z���e���X����
		time_UTC = elapsedtime2GPS_UTC(time(i),time_ref);	% UTC���ݎ���
		latitude = blh_deg2blh_GPSformat(blh(i,1));		% �ܓx
		longitude = blh_deg2blh_GPSformat(blh(i,2));	% �o�x
		height = blh(i,3);	% ���x
		str1 = '$GPGGA,';
		str2 = sprintf('%09.2f,%10.6f,N,%011.6f,', time_UTC, latitude, longitude);
		str3 = sprintf('E,1,08,0.9,%.2f,M,28.4,M,,,*', height);	%��肱�݂��Â�
		str_file = strcat(str1, str2, str3);
		str_checksum = make_checksum_nmea(str_file);
		str_file = strcat(str_file, str_checksum, '\n');
		fprintf(fid, str_file);

		% $GPZDA�̓��t�Z���e���X����
		str4 = sprintf('$GPZDA,%09.02f,%02d,%02d,%04d,00,00*', time_UTC, day_ref(3), day_ref(2),day_ref(1));
		str_checksum = make_checksum_nmea(str4);
		str_file = strcat(str4, str_checksum, '\n');
		fprintf(fid, str_file);
	end
	fclose(fid);
end

function output = make_checksum_nmea(str)
	% NMEA�Z���e���X�̃`�F�b�N�T���쐬
	% '$GPGGA,~~~,M,,0000*'�܂ł̕������ǂݍ���Ń`�F�b�N�T��(8bit��16�i���\�L0x**)�o��
	% �g$�h�A�h!�h�A�h*�h���܂܂Ȃ��Z���e���X���̑S�Ă̕��� ��8�r�b�g�̔r���I�_���a�B","�͊܂ނ̂Œ���
	% ex. $GPGGA,125044.001,3536.1985,N,13941.0743,E,2,09,1.0,12.5,M,36.1,M,,0000*6A
	num_str = length(str);
	checksum = uint8(0);
	for i = 1:num_str
		if (str(i) ~= '$') && (str(i) ~= '!') && (str(i) ~= '*')
			checksum = bitxor(checksum, uint8(str(i))); % bit���̔r���I�_���aXOR
		end
	end
	output = sprintf('%02X',checksum);
end

function output = blh_deg2blh_GPSformat(pos)
	% �ܓx�o�x[deg]����NMEA�̃Z���e���X�`���ɕϊ�����֐�
	% ex.�ܓx48.1167***�x��NEMA�t�H�[�}�b�g��4807.03***�̕����݂ɕϊ�
	% [DD.DDDDDDDD]->[DDMM.MMMMMM](D:�x,M:��)
	% pos:�ܓx�o�x[deg]([DD.DDDDDDDD])
	% output_str:NMEA�t�H�[�}�b�g�̈ܓx�o�x�̕�����[DDMM.MMMMMM]
	degree = fix(pos);	% �����_�ȉ��؂�̂�
	minute = (pos - degree) * 60;
	output = degree * 100 + minute;
end

function output = elapsedtime2GPS_UTC(time,time_ref)
	% �����(time_ref)�ƃR���s���[�^�N������(time)�𑫂��ă^�C���X�^���v�����iUTC�j
	% time:time_ref����̌o�ߎ���[s] class(float)
	% time_ref:JST time[HHMMSS.SS] class(float)
	% output:UTC time[HHMMSS.SS] class(float)
	hour = 0;
	minute = 0;
	while time > 3600
		hour = hour + 1;
		time = time - 3600;
	end
	while time > 60
		minute = minute + 1;
		time = time - 60;
	end
	output = time_ref - 90000 + (hour * 10000 + minute * 100 + time);
end
