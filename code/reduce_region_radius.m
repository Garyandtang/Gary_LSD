%{
 * Reduce the region size, by elimination the points far from the starting point, until that leads to
 * rectangle with the right density of region points or to discard the region if too small.
%}

function [y, updated_used, rec_] = reduce_region_radius(reg, reg_angle, prec, p, rec, density, density_th, used)
%Compute region's radius
xc = reg(1, 2);
yc = rec(1, 1);
radSq1 = sqrt(distance([xc, yc], [rec(2), rec(1)]));
radSq2 = sqrt(distance([xc, yc], [rec(4), rec(3)]));
if radSq1 > radSq2
    radSq = radSq1;
else
    radSq = radSq2;
end

while density < density_th
    %reduce region's radius to 0.75 of its value
    radSq = radSq * 0.75 * 0.75;
    %Remove points from the region and update 'used' map
    i = 0; reg_height= size(reg,1);
    while i < reg_height
        i = i + 1;
        if sqrt(distance([xc, yc], [reg(i,2), reg(i,1)])) > radSq
            used(reg(i,1), reg(i,2)) = 0;
            updated_used = used;
            reg(i, :) = [];
            i = i -1;
        end
        reg_height = size(reg,1);
    end
    if size(reg, 1) < 2 
        y = false;
        rec_ = rec;
        return;
    end
    
    rec_ = region2rect(reg, reg_angle, prec, p);
    density = size(reg, 1)/(distance([rec(2),rec(1)], [rec(4), rec(3)]) * rec(5));
end
y = true;
