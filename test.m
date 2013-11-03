dcm
e1 = dcm2euler(dcm);
dcm1 = euler2dcm(e1)
disp('dcm====euler')

e1
q1 = euler2quat(e1);
e2 = quat2euler(q1)
disp('euler====quat')

q1
dcm2 = quat2dcm(q1);
q2 = dcm2quat(dcm2)
disp('dcm====quat')

dcm
e1 = dcm2euler(dcm)
q1 = dcm2quat(dcm)
e2 = quat2euler(q1)

disp('====dcm to euler====')

e1
dcm1 = euler2dcm(e1)
q1 = euler2quat(e1);
dcm2 = quat2dcm(q1)

disp('====euler to dcm====')
% q = euler2quat(e);
% q = quat_normalize(q)
% dcm1 = quat2dcm(q)
% q1 = dcm2quat(dcm1);
% q1 = quat_normalize(q1)
% dcm2 = quat2dcm(q1)

% q1 = dcm2quat(dcm)
% q1 = quat_normalize(q1)
% dcm2 = quat2dcm(q1)