function [n, e, d] = ecef2ned(x, y, z, xr, yr, zr)
	% ECEF座標からNED座標へ変換をする
	% ECEF座標：x,y,z[m]
	% NED座標：n,e,d[m]
	% ECEF座標上の参照位置（射点）:xr,yr,zr[m]
	[phi, ramda, height] = ecef2blh(xr,yr,zr);
	n = -sin(phi)*cos(ramda)*(x-xr) - sin(phi)sin(ramda)*(y-yr) + cos(phi)*(z-zr);
	e = -sin(ramda)*(x-xr) + cos(ramda)*(y-yr);
	d = -cos(phi)*cos(ramda)*(x-xr) - cos(phi)*sin(ramda)*(y-yr) - sin(phi)*(z-zr);
