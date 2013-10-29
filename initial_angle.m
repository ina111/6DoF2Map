% 静止状態の加速度から重力の単位ベクトル、（機体y軸）
% 初期加速から進行方向の単位ベクトル、（機体x軸）
% 重力の単位ベクトルと進行方向単位ベクトルから法線によって機体ｚ軸を求める

gravi_x = 35316;
gravi_y = 34876;
gravi_z = 35621;
gravi_mean = mean([gravi_x; gravi_y; gravi_z]);
% gravi_mean = 0;
gravi_x = gravi_x - gravi_mean;
gravi_y = gravi_y - gravi_mean;
gravi_z = gravi_z - gravi_mean;

g_norm = sqrt(gravi_x^2 + gravi_y^2 + gravi_z^2);
g_vec = [gravi_x / g_norm; gravi_y / g_norm; gravi_z / g_norm]

% g_theta = atan2(gravi_x,gravi_y)
% g_fai = acos(gravi_z / g_norm)

init_x = 0;
init_y = 0;
init_z = 0;

init_acc_x = init_x - gravi_x;
init_acc_y = init_y - gravi_y;
init_acc_z = init_z - gravi_z;




% 08043289188