%{
* Calculates the number of correctly aligned points within the rectangle.
 * @return      The new NFA value.
%} 
%rec [y1, x1, y2, x2, width, y, x, theta, dy, dx, prec, p]
%ordered_x [y, x, taken]
function result = rect_nfa(rec, angles)
total_pts = 0;
alg_pts = 0;
half_width = rec(5)/2;
dyhw = rec(9) * half_width;
dxhw = rec(10) * half_width;

ordered_x = zeros(4, 3);
ordered_x(1,1) = int8(rec(1) - dyhw); ordered_x(1,2) = int8(rec(2) + dxhw); ordered_x(1,3) = false;
ordered_x(2,1) = int8(rec(3) - dyhw); ordered_x(2,2) = int8(rec(4) + dxhw); ordered_x(2,3) = false;
ordered_x(3,1) = int8(rec(1) + dyhw); ordered_x(3,2) = int8(rec(2) - dxhw); ordered_x(3,3) = false;
ordered_x(4,1) = int8(rec(3) + dyhw); ordered_x(4,2) = int8(rec(4) - dxhw); ordered_x(4,3) = false;

%need to do
[a, index] = sort(ordered_x(:,2));
ordered_x = ordered_x(index, [1,2 ,3]);

min_y = ordered_x(1, :);
max_y = ordered_x(1, :);

for i = 2: 4
    if min_y(1) > ordered_x(i, 1)
        min_y = ordered_x(i, :);
    end
    if min_y(1) < ordered_x(i, 1)
        max_y = ordered_x(i, :);
    end
end
min_y(3) = true;
for i = 1: 4
    if ordered_x(i,1) ==min_y(1) && ordered_x(i,2) == min_y(2)
        ordered_x(i,3) = true;
    end
end


%find leftmostuntaken point
leftmost = zeros(1,3);
for i = 1 : 4
    if ~ordered_x(i, 3) 
        if leftmost(1) == 0 && leftmost(2) == 0 && leftmost(3) ==0
            leftmost = ordered_x(i, :);
        elseif(leftmost(2) > ordered_x(i, 2))
            leftmost = ordered_x(i, :);
        end
    end
end
leftmost(1,3) = true;
for i = 1: 4
    if ordered_x(i,1) ==leftmost(1) && ordered_x(i,2) == leftmost(2)
        ordered_x(i,3) = true;
    end
end

%find rightmostuntaken point
rightmost = zeros(1,3);
for i = 1 : 4
    if ~ordered_x(i, 3) 
        if rightmost(1) == 0 && rightmost(2) == 0 && rightmost(3) ==0
            rightmost = ordered_x(i, :);
        elseif(rightmost(2) > ordered_x(i, 2))
            rightmost = ordered_x(i, :);
        end
    end
end
rightmost(1,3) = true;
for i = 1: 4
    if ordered_x(i,1) ==rightmost(1) && ordered_x(i,2) == rightmost(2)
        ordered_x(i,3) = true;
    end
end

%find last untaken point
tailp = zeros(1, 3);
for i = 1 : 4
    if ~ordered_x(i, 3) 
        if tailp(1) == 0 && tailp(2) == 0 && tailp(3) == 0
            tailp = ordered_x(i, :);
        elseif(tailp(2) > ordered_x(i, 2))
            tailp = ordered_x(i, :);
        end
    end
end
tailp(1,3) = true;
for i = 1: 4
    if ordered_x(i,1) ==tailp(1) && ordered_x(i,2) == tailp(2)
        ordered_x(i,3) = true;
    end
end

if min_y(1) ~= leftmost(1)
    flstep = (min_y(2) - leftmost(2)) / (min_y(1) - leftmost(1));
else
    flstep = 0;
end

if leftmost(1) ~= tailp(2)
    slstep = (leftmost(2) - tailp(2)) / (leftmost(1) - tailp(1));
else
    slstep = 0;
end

if min_y(1) ~= rightmost(1)
    frstep = (min_y(2) - rightmost(2)) / (min_y(1) - rightmost(1));
else
    frstep = 0;
end

if rightmost(1) ~= tailp(2)
    srstep = (rightmost(2) - tailp(2)) / (rightmost(1) - tailp(1));
else
    srstep = 0;
end

lstep = flstep; rstep = frstep;

left_x = min_y(2); right_x = min_y(2);

%loop around all points in the region and count those that are aligned
min_iter = min_y(1); max_iter = max_y(1);
for y = min_iter : max_iter
    if (y < 0 || y >= size(angles, 1))
        continue
    end
    
    for x = int8(left_x) : int8(right_x) 
        if (x < 0 || size(angles,2))
            continue
        end
        total_pts = total_pts +1;
        if(isAligned(x, y, rec(8), rec(11),angles))
            alg_pts = alg_pts +1;
        end
    end
    
    if(y >= leftmost(1))
        lstep = slstep;
    end
    if (y >= rightmost(1))
        rstep = srstep;
    end
end

result = nfa(total_pts, alg_pts, rec(12),angles);

    