function theta_0_degs = mean_direction(psds, dirs)
dir_rads = pi*(dirs)/180;
dtheta = dir_rads(2)-dir_rads(1);
transpose_psds = psds';
a1 = cos(dir_rads) * transpose_psds * dtheta;
b1 = sin(dir_rads) * transpose_psds * dtheta;

theta_0 = atan2(b1,a1);
theta_0_degs = 180*theta_0/pi;
theta_0_degs = mod(theta_0_degs + 360,360);