function euler = dcm2euler(dcm)
	% 方向余弦行列からオイラー角を算出
	% euler:オイラー角[rad], dcm:方向余弦行列
	% degreeにするにはrad2degの	matlab関数を使う
	euler = [atan2(dcm(2,3), dcm(3,3));...
			 atan2(-dcm(1,3), sqrt(dcm(2,3)^2 + dcm(3,3)^2));...
			 atan2(dcm(1,2), dcm(1,1))];
