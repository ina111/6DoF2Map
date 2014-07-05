figure;
plot(time,acc_x,time,acc_y,time,acc_z);
title('accelation [m/s2]');
xlabel('time [s]');
ylabel('accelaration [G]');
% ylim([-0.07,0.1]);
xlim([plot_time_start,plot_time_end]);
legend('x','y','z');
grid on

figure;
plot(time,gyro_x,time,gyro_y,time,gyro_z);
xlim([plot_time_start,plot_time_end]);
title('gyro [deg/s]')
legend('x','y','z');
grid on

figure;
plot(time,quat_delta(:,1),'+',time,quat_delta(:,2),'+',time,quat_delta(:,3),'+',time,quat_delta(:,4),'+');
xlim([plot_time_start,plot_time_end]);
title('quartenion_delta')
legend('q0', 'q1', 'q2', 'q3')
grid on

figure;
plot(time,quat_body2launch(:,1),time,quat_body2launch(:,2),time,quat_body2launch(:,3),time,quat_body2launch(:,4));
xlim([plot_time_start,plot_time_end]);
title('quartenion');
legend('q0', 'q1', 'q2', 'q3')
grid on

figure;
plot(time,euler_deg(:,1),time,euler_deg(:,2),time,euler_deg(:,3));
xlim([plot_time_start,plot_time_end]);
title('euler[deg]')
legend('roll','pitch','yaw');
grid on

figure;
plot(time,vel_launch(:,1),time,vel_launch(:,2),time,vel_launch(:,3));
xlim([plot_time_start,plot_time_end]);
title('velocity_launch[m/s]')
legend('U','E','N');
grid on

figure;
plot(time,pos_launch(:,1),time,pos_launch(:,2),time,pos_launch(:,3));
xlim([plot_time_start,plot_time_end]);
ylim([-100,1000]);
title('position_launch[m/s]')
legend('U','E','N');
grid on

% 3Dプロットに表示する数
num_3d_plot = 5000;
pos_launch = pos_launch(1:num_3d_plot,:);

figure;
plot3(pos_launch(:,3), pos_launch(:,2), pos_launch(:,1));
xlabel('North');ylabel('East');zlabel('UP')
xlim([-5000,5000]);ylim([-5000,5000]);zlim([0,10000]);
grid on
axis square
