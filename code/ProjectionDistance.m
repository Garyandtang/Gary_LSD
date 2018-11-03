%fitsion 2 lines to 1 line and calculate the projetion distance
function result = ProjectionDistance(line1, line2)
pts = zeros(0, 2);
pt1 = [line1(1), line1(2)];
pt2 = [line1(3), line1(4)];
pt3 = [line2(1), line2(2)];
pt4 = [line2(3), line2(4)];
pts = [pts; pt1; pt2; pt3; pt4];

lineParam = zeros(0, 4);
p = polyfit(pts(:, 1), pts(:,2),1);
dir = [1/norm([1, p(1)]), p(1)/norm([1, p(1)])];
pt = [0, p(2)];

t1 = dot(dir, (pt1 - pt));
t2 = dot(dir, (pt2 - pt));
t3 = dot(dir, (pt3 - pt));
t4 = dot(dir, (pt4 - pt));

if t1 > t2
    [t2, t1] = deal(t1, t2);
end
if t2 > t4
    [t4, t3] = deal(t4, t3);
end

if (t3 >= t1 && t3 <= t2)
    result = 0;
    return;
end
if (t4 >= t1 && t4 <= t2)
    result = 0;
    return;
end
if (t3 <= t1 && t2 <= t4)
    result = 0;
    return;
end
if (t1 <= t3 && t4 <= t2)
    result = 0;
    return;
end
if (t1 >= t4)
    result = t1 - t4;
    return;
end
if (t3 >= t2)
    result = t3 -t2;
    return;
end
