function result = LineNormalAngle(lineParam)
angle = 90;
if lineParam(2) ~= 0
    tan = lineParam(2)/lineParam(1);
    angle = atan(tan) *180 / pi;
end

if angle < 0
    angle = angle + 180;
end

result = angle;