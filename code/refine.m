%{
* An estimation of the angle tolerance is performed by the standard deviation of the angle at points
 * near the region's starting point. Then, a new region is grown starting from the same point, but using the
 * estimated angle tolerance. If this fails to produce a rectangle with the right density of region points,
 * 'reduce_region_radius' is called to try to satisfy this condition.
%}
%reg [y, x, used, angle, modgrad]
% rec [y1, x1, y2, x2, width, y, x, theta, dy, dx, prec, p]
function [y, updated_used, rec_] = refine(reg, reg_angle, prec, p, rec, density_th, used, angles, modgrad)
 
density = size(reg, 1)/(distance([rec(2),rec(1)], [rec(4), rec(3)]) * rec(5));

if density >= density_th
    y = true;
    updated_used = used;
    rec_ = rec;
    return;
end

xc = reg(1, 2);
yc = rec(1, 1);
ang_c = reg(1, 4);
sum =0; s_sum = 0;
n = 0;

for i = 1: size(reg, 1)
    used(reg(1,1), reg(1,2)) = 0;
    if distance([xc, yc], [reg(i,2), reg(i,1)]) < rec(5)
        angle = reg(i, 4);
        ang_d = angle_diff_signed(angle, ang_c);
        sum = sum + ang_d;
        s_sum = s_sum + ang_d^2;
        n = n + 1;  
    end
end

mean_angle = sum / n;
%2 * standard deviation
tau = 2 * sqrt((s_sum - 2 * mean_angle * sum) / n + mean_angle^2);

%Try new region
[reg, reg_angle, updated_used_] = region_grow([reg(1, 1), reg(1, 2), 0], used, angles, modgrad, tau);
updated_used = updated_used_;
 
if (size(reg, 1) < 2)
    y = false;
    rec_ = rec;
    return;
end

rec_ = region2rect(reg, reg_angle, prec, p);
density = size(reg, 1)/(distance([rec(2),rec(1)], [rec(4), rec(3)]) * rec(5));

if density < density_th
    [y, updated_used, rec_] = reduce_region_radius(reg, reg_angle, prec, p, rec, density, density_th, used);
else
    y = true;
    return;
end
