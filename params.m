% 読み込むファイル名（main.mファイルと同じディレクトリにあること）
% csvfile = 'camui2012_sample_copy.csv';
csvfile = 'CanSatApage2.csv';
% csvfile = 'CanSat2014.csv'

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
SHOW_PLOT = 1;
OUTPUT_GPS = 1;
output_GPS_filename = 'CanSatsample';
% =======設定項目は以上、以下定数======
% earth_rate = [0 0 7.2921151467e-5];
