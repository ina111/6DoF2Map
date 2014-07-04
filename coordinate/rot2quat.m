function quat = rot2quat(deg, vec)
	% 回転方向ベクトルと回転角から回転クォータニオンを作成
	% quat:作成されたクォータニオン[q0,q1,a2,q3]
	% deg:回転角[deg]
	% vec:回転方向ベクトル[x, y, z]関数内で単位ベクトルに変換
	tmp = norm([vec(1), vec(2), vec(3)]);
	v = [vec(1)/tmp, vec(2)/tmp, vec(3)/tmp];
	deg2 = deg / 2;
	quat = [cosd(deg2), sind(deg2)*v(1), sind(deg2)*v(2), sind(deg2)*v(3)];