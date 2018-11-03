%Compute region's angle as the principal inertia axis of the region.
%@return          Regions angle.
%reg [y, x, used, angle, modgrad]

function theta = get_theta(reg, x, y, reg_angle, prec)
Ixx = 0; Iyy = 0; Ixy = 0;
[reg_height, reg_width] = size(reg);

%computer inertia matrix
for i = 1 : reg_height
    regx = reg(i, 2);
    regy = reg(i, 1);
    weight = reg(i, 5);
    dx = regx - x;
    dy = regy - y;
    Ixx = Ixx + dy * dy * weight;
    Iyy = Iyy + dx * dx * weight;
    Ixy = Ixy - dx * dy * weight;
end

lambda = 0.5 * (Ixx + Iyy - sqrt((Ixx - Iyy) * (Ixx - Iyy) + 4.0 * Ixy * Ixy));  

if abs(Ixx) > abs(Iyy)
    theta = atan2((lambda - Ixx), Ixy);
else
    theta = atan2(Ixy, (lambda - Iyy));
end

if(abs(angle_diff_signed(theta, reg_angle)) > prec)
    theta = theta + pi;
end

