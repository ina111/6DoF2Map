% 静止状態の加速度から重力の単位ベクトル、（機体y軸）
% 初期加速から進行方向の単位ベクトル、（機体x軸）
% 重力の単位ベクトルと進行方向単位ベクトルから法線によって機体ｚ軸を求める

g_x = mean(acc_x(gravity_line));
g_y = mean(acc_y(gravity_line));
g_z = mean(acc_z(gravity_line));

i_x = acc_x(initial_line) - g_x;
i_y = acc_y(initial_line) - g_y;
i_z = acc_z(initial_line) - g_z;

% 重力ベクトル
g_norm = sqrt(g_x^2 + g_y^2 + g_z^2);
g_vec = [g_x / g_norm; g_y / g_norm; g_z / g_norm]

% 初期加速ベクトル
i_norm = sqrt((i_x^2 + i_y^2 + i_z^2));
i_vec = [i_x / i_norm; i_y / i_norm; i_z / i_norm]

x_vec = i_vec;
z_vec = cross(g_vec, i_vec);
z_vec = z_vec / norm(z_vec);
y_vec = cross(z_vec, i_vec);
y_vec = y_vec / norm(y_vec);

dot(z_vec, y_vec);
dot(z_vec, x_vec);
dot(x_vec, y_vec);

% dcm = inv([x_vec y_vec z_vec])
% 座標変換行列は基底ベクトルによる
dcm_sensor2body = [x_vec y_vec z_vec]'
quat_sensor2body = dcm2quat(dcm_sensor2body)
% euler = rad2deg(dcm2euler(dcm_sensor2body))

% センサーの付いている座標系から射点の座標系への変換
quat_prev = quat_product(quat_sensor2body, quat_prev);
quat_prev = quat_prev';