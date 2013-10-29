% 加速度ジャイロの6軸の慣性計測の値から座標変換を駆使して速度と位置を求める
% ストラップダウン式の慣性計測ユニット（IMU)の値は機体座標系での計測値なので
% 慣性座標系での値に変換する。
% また、便利のために緯度経度高度に変換し、Google Earthで表示できるようにする。
% - - - -
% 使用する座標系
% 機体座標系(Body Frame)：機体に固定された座標系。機体ノーズ方向をx軸としている
% 射点座標系（UEN):射点中心の地表に平行な座標系。X-Y-ZをUp-East-Northに合わせている。
% 地球中心地球固定座標系(ECEF)：地球中心を原点にx軸を緯度経度0度、ｚ軸を自転軸に定めた運動座標系
% 地球中心慣性座標（ECI)：地球中心の慣性座標ｚ軸は自転軸。
% 測地座標系(BLH)：緯度、経度、楕円体高度の座標系。直交座標系ではない。WGS-84準拠
% - - - -
% この計算の注意点
% 射点座標系は本来地球の自転や公転など運動座標系であり、
% コリオリ力や遠心力などのみかけの力が働くがここでは、座標系は動かないｔ慣性座標系として考えている。
% したがって誤差が生じる。誤差が気になる場合にはsimple版ではなくfull版を使用してください。
% - - - -
% 読み込むファイルの形式
% <time,><acc>,<acc>,<acc>,<gyro>,<gyro>,<gyro><CR><LF>
% - - - -
% 2013年9月30日　稲川貴大
clear all
% 読み込むファイル名（main.mファイルと同じディレクトリにあること）
% csvfile = 'camui2012_sample_copy.csv';
csvfile = 'CanSatApage2.csv';
% ログ開始時においての
% UTCの西暦月日[year, month, day]JSTではなくUTC時刻での日付なので早朝など注意
day_ref = [2013, 10, 1];
% time_ref: 日本時間（JST)[HHMMSS.SS] ex.12時34分56.78秒->123456.78
time_ref = 120000.00;
% 緯度経度、楕円体高度[deg,deg,m] 度表示なので注意
% blh_init = [42.505992,143.456970,30];
blh_init = [43.5807, 142.002083, 50];
% 射点座標（UEN)での初期位置　通常[0 0 0]
pos_init = [0 0 0];
% 方位角、仰角[deg]
azimth_deg_init = -10;
elevation_deg_init = -90.1;
roll_deg_init = 0;	%機体のyz平面の重力方向とｚ軸の角度差が初期ロール角
% ↑初期ロール角が0のときy軸の重力による加速度はゼロ
% グラフの開始時間[s]と終了時間[s]の設定
plot_time_start = 528160;
plot_time_end = 528225;

% ----
% CAMUI提供のサンプルデータでは
% 加速度：ピッチ、ロール、ヨーの順
% ジャイロ：ロール、ヨー、ピッチの順
% time_line = 1;
% acc_roll_line  = 3; acc_pitch_line  = 2; acc_yaw_line  = 4;
% gyro_roll_line = 5; gyro_pitch_line = 7; gyro_yaw_line = 6;
time_line = 2;
acc_roll_line  = 3; acc_pitch_line  = 4; acc_yaw_line  = 5;
gyro_roll_line = 6; gyro_pitch_line = 7; gyro_yaw_line = 8;

% 中央値とスケールファクタ[LSB/(deg/s),LSB/g]
% acc_mean = 0;
% acc_scale = 1;
% gyro_mean = 0;
% gyro_scale = 1;


acc_x_mean = 32768; acc_y_mean = 32768; acc_z_mean = 32768;
acc_scale = 2048;
gyro_x_mean = 32755; gyro_y_mean = 32783; gyro_z_mean = 32769;
gyro_scale = 16.4;
% ----
% プロット、GPSアウトプットのON/OFF　ON:1,OFF:0
SHOW_PLOT = 0;
OUTPUT_GPS = 1;
output_GPS_filename = 'CanSatsample';
% =======設定項目は以上、以下定数======
% earth_rate = [0 0 7.2921151467e-5];

% =====

% ファイルから加速度による移動量とジャイロによる回転角を読み込む。
csv = csvread(csvfile);
csv_length = length(csv);

% ECEF座標系においけるログ開始時の位置[m]
[xr,yr,zr] = blh2ecef(blh_init(1),blh_init(2),blh_init(3));
% 初期方位角と仰角とロール角をクォータニオン表示
quat_elevation = rot2quat(elevation_deg_init - 90, [0 0 1]);
quat_azimth  = rot2quat(azimth_deg_init - 90, [1 0 0]);
quat_roll = rot2quat(roll_deg_init, [1 0 0]);
quat_body2launch = quat_product(quat_elevation, quat_azimth);
quat_body2launch = quat_product(quat_body2launch, quat_roll);
% 射点座標系での速度、位置、クォータニオン、方向余弦行列(DCM)の初期化
vel_launch_prev = [0 0 0];
pos_launch_prev = pos_init;
quat_prev = quat_body2launch';	%クォータニオンの初期化
% dcm_prev = zeros(3);

% メインループ
line = 2;
% acc_x,gyro_xはノーズ方向（ロール変化させる方向）
% acc_y,gyro_yはピッチ変化させる方向
% acc_z,gyro_zはヨー変化させる方向
% 平均とスケールファクターを考慮し、[g][deg/s]に変換
time = csv(:,time_line);
acc_x = (csv(:,acc_roll_line) - acc_x_mean) ./ acc_scale;
acc_y = (csv(:,acc_pitch_line) - acc_y_mean) ./ acc_scale;
acc_z = (csv(:,acc_yaw_line) - acc_z_mean) ./ acc_scale;
gyro_x = (csv(:,gyro_roll_line) - gyro_x_mean) ./ gyro_scale;
gyro_y = (csv(:,gyro_pitch_line)- gyro_y_mean) ./ gyro_scale;
gyro_z = (csv(:,gyro_yaw_line) - gyro_z_mean) ./ gyro_scale;
% 配列の初期化
quat_delta = zeros(csv_length,4);
quat_body2launch = zeros(csv_length,4);
euler_rad = zeros(csv_length,3);
euler_deg = zeros(csv_length,3);
vel_launch = zeros(csv_length,3);
pos_launch = zeros(csv_length,3);
pos_ECEF = zeros(csv_length,3);
pos_blh = zeros(csv_length,3);
pos_blh(1,:) = blh_init;	% 緯度経度高度の初期化

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
	% ６DOFのセンサデータからGPSデータ（NMEA GPGGA）のデータ列に変換し、outputディレクトリにstr.nmeaで保存
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

% 3Dプロットに表示する数
num_3d_plot = 5000;
pos_launch = pos_launch(1:num_3d_plot,:);

figure;
plot3(pos_launch(:,3), pos_launch(:,2), pos_launch(:,1));
xlabel('North');ylabel('East');zlabel('UP')
xlim([-5000,5000]);ylim([-5000,5000]);zlim([0,10000]);
grid on
axis square

end