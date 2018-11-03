function A = isAligned(x, y, theta, prec, angles)
[height, width, dim] = size(angles);

if  x < 1 || y < 1 || x > width || y > height
    A = false;
end

a = angles(y,x);
%not used 
if a == -1024
    A = false;
end

%It is assumed taht 'theta' and  'a' are in the range[-pi, pi]
n_theta = abs(theta - a);
if n_theta > (1.5 * pi)
    n_theta = abs(n_theta - 2 * pi);
end

if n_theta <= prec
    A = true;
else
    A = false;
end
