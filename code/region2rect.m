%{
Finds the bounding rotated rectangle of a region.
 *
 * @param reg       The region of points, from which the rectangle to be constructed from.
 * @param reg_angle The mean angle of the region.
 * @param prec      The precision by which points were found.
 * @param p         Probability of a point with angle within 'prec'.
 * @param rec       Return: The generated rectangle.
%}
%reg [y, x, used, angle, modgrad]
%{
  rec [y1, x1, y2, x2, width, y, x, theta, dy, dx, prec, p]
  x1, y1, x2, y2;    // first and second point of the line segment
  width;             // rectangle width
  x, y;              // center of the rectangle
  theta;             // angle
  dx,dy;             // (dx,dy) is vector oriented as the line segment
  prec;              // tolerance angle
  p;                 // probability of a point with angle within 'prec'
%}
function rec = region2rect(reg, reg_angle, prec, p)
rec = zeros(1,12);

[reg_height, reg_width] = size(reg);
x = 0; y = 0; sum = 0;
for i = 1 : reg_height
    weight = reg(i,5);
    y = y + reg(i, 1) * weight;
    x = x + reg(i, 2) * weight;
    sum = sum + weight;
end

x = x / sum;
y = y / sum;

theta = get_theta(reg, x, y, reg_angle, prec);

%find length and width
dx = cos(theta);
dy = sin(theta);
l_min = 0; l_max = 0; w_min = 0; w_max = 0;

for i = 1 : reg_height
    regdx = reg(i, 2) - x;
    regdy = reg(i, 1) - y;
    l = regdx * dx + regdy * dy;
    w = -regdx * dy + regdy * dx;
    
    if l > l_max
        l_max = l;
    elseif l < l_min
        l_min = l;
    end
    
    if w > w_max
        w_max = w;
    elseif w < w_min
        w_min = w;
    end
end
%rec [y1, x1, y2, x2, width, y, x, theta, dy, dx, prec, p]
rec(1) = y + l_min * dy;
rec(2) = x + l_min * dx;
rec(3) = y + l_max * dy;
rec(4) = x + l_max * dx;
rec(5) = w_max - w_min;
rec(6) = y;
rec(7) = x;
rec(8) = theta;
rec(9) = dy;
rec(10) = dx;
rec(11) = prec;
rec(12) = p;
  
    
    
    
    
    
    
    
    
    
    
    

    