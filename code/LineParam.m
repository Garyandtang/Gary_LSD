function result = LineParam(line)
pt1 = [line(1), line(2), 1];
pt2 = [line(3), line(4), 1];
pt3 = cross(pt1, pt2);
pt3 = pt3 / norm([pt3(1), pt3(2)]);
if pt3(2) < 0
    pt3 = - pt3;
end
result = pt3;