% 静止状態の加速度から重力の単位ベクトル、（機体y軸）
% 初期加速から進行方向の単位ベクトル、（機体x軸）
% 重力の単位ベクトルと進行方向単位ベクトルから法線によって機体ｚ軸を求める

gravi_x = 35316;
gravi_y = 34876;
gravi_z = 35621;
gravi_mean = mean([gravi_x; gravi_y; gravi_z]);
% gravi_mean = 0;
g_x = gravi_x - gravi_mean;
g_y = gravi_y - gravi_mean;
g_z = gravi_z - gravi_mean;

g_norm = sqrt(g_x^2 + g_y^2 + g_z^2);
% 重力の単位ベクトル
g_vec = [g_x / g_norm; g_y / g_norm; g_z / g_norm]

% g_theta = atan2(gravi_x,gravi_y)
% g_fai = acos(gravi_z / g_norm)

init_x = 32918;
init_y = 26671;
init_z = 45421;

init_acc_x = init_x - gravi_x;
init_acc_y = init_y - gravi_y;
init_acc_z = init_z - gravi_z;

i_mean = mean([init_acc_x; init_acc_y; init_acc_z]);
i_x = init_acc_x - i_mean;
i_y = init_acc_y - i_mean;
i_z = init_acc_z - i_mean;

i_norm = sqrt((i_x^2 + i_y^2 + i_z^2));
i_vec = [i_x / i_norm; i_y / i_norm; i_z / i_norm]

z_vec = cross(i_vec, g_vec);
z_vec = z_vec / norm(z_vec);
y_vec = cross(i_vec, z_vec);
y_vec = y_vec / norm(y_vec);
x_vec = i_vec

dot(z_vec, y_vec)
dot(z_vec, x_vec)
dot(x_vec, y_vec)

% dcm = inv([x_vec y_vec z_vec])
% 座標変換行列は基底ベクトルによる
dcm = [x_vec y_vec z_vec]

% 08043289188