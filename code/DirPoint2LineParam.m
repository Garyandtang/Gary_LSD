function result = DirPoint2LineParam(fitLineParam)
lineParam = zeros(1, 3);
lineParam(1, 1) = -fitLineParam(2);
lineParam(1, 2) = fitLineParam(1);
lineParam(1 ,3) = -(lineParam(1, 1) * fitLineParam(3) + lineParam(1, 2) * fitLineParam(4));
if lineParam(1, 2) < 0
    lineParam = - lineParam;
end

result = lineParam;