function [n, e, d] = ecef2ned(x, y, z, xr, yr, zr)
	% ECEF���W����NED���W�֕ϊ�������
	% ECEF���W�Fx,y,z[m]
	% NED���W�Fn,e,d[m]
	% ECEF���W��̎Q�ƈʒu�i�˓_�j:xr,yr,zr[m]
	[phi, ramda, height] = ecef2blh(xr,yr,zr);
	n = -sin(phi)*cos(ramda)*(x-xr) - sin(phi)sin(ramda)*(y-yr) + cos(phi)*(z-zr);
	e = -sin(ramda)*(x-xr) + cos(ramda)*(y-yr);
	d = -cos(phi)*cos(ramda)*(x-xr) - cos(phi)*sin(ramda)*(y-yr) - sin(phi)*(z-zr);
