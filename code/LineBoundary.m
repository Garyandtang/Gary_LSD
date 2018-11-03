function [result, lineParam] = LineBoundary(lines)
fitLineParam = FitLine(lines);
pt = [fitLineParam(3), fitLineParam(4)];
dir = [fitLineParam(1), fitLineParam(2)];
pts = zeros(0, 2);

for i = 1 : size(lines, 1)
    pts = [pts; [lines(i, 1), lines(i, 2)]; [lines(i, 3), lines(i, 4)]];
end

mRankPts = zeros(0, 3);
for i = 1 : size(pts, 1)
    t = dot(dir, (pts(i,:)-pt));
    projPt = pt + t * dir;
    mRankPts = [mRankPts; [t, projPt]];
end

[a, index] = sort(mRankPts(:,1), 'ascend');
mRankPts = mRankPts(index, [1, 2 ,3]);

s = mRankPts(1, 2:3);
e = mRankPts(size(mRankPts, 1), 2:3);

lineParam = DirPoint2LineParam(fitLineParam);

result = [s(1), s(2), e(1), e(2)];