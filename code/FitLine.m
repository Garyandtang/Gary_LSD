function result = FitLine(lines)

weights = zeros(0,1);
squareWeights = zeros(0, 1);

if size(lines, 1) < 2
    pt1 = [lines(1, 1), lines(1, 2)];
    pt2 = [lines(1, 3), lines(1, 4)];
    pt = (pt1 + pt2) / 2;
    dir = (pt1 - pt2)/ norm(pt1 - pt2);
    result = [dir(1), dir(2), pt(1), pt(2)];
    return;
end

weightSum = 0;
for i = 1 : size(lines, 1)
    len = 1;
    squareWeights = [squareWeights; len];
    weights = [weights, sqrt(len)];
    weightSum = weightSum + len;
end

meanPt = [0, 0];
pts = zeros(0, 2);
for i = 1 : size(lines,1)
    pt = ([lines(i, 1), lines(i, 2)] + [lines(i, 3), lines(i, 4)])/2;
    meanPt = meanPt + (squareWeights(i) / weightSum) * pt;
end

n = size(lines, 1) * 2;
A = zeros(n, 2);
for i = 1 : size(lines, 1)
    pt1 = [lines(1, 1), lines(1, 2)];
    pt2 = [lines(1, 3), lines(1, 4)];
    
    pt1 = (pt1 - meanPt) * weights(i);
    pt2 = (pt2 - meanPt) * weights(i); 
    
    
    A(2*i, 1) = pt1(1);
    A(2*i, 2) = pt1(2);
    A(2*i+1, 1) = pt2(1);
    A(2*i+1, 2) = pt2(2);
end
[u, w, v] = svd(A);
% no idea whether v is vt or not
v = v';
dir = v(2, :);
result = [-dir(2), dir(1), meanPt(1), meanPt(2)];

    
    
    
    
    
    