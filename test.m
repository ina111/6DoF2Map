e = dcm2euler(dcm)
q = euler2quat(e)
q = quat_normalize(q)
dcm1 = quat2dcm(q)

q1 = dcm2quat(dcm)
q1 = quat_normalize(q1)
dcm2 = quat2dcm(q1)