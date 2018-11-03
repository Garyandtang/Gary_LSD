%To merge the subline
%rec [y1, x1, y2, x2, width, y, x, theta, dy, dx, prec, p]
function result = mergeLine(lines_list, minAngleDis, minDis, minLen, minGap)
mLenthLine = zeros(0,5);
for i = 1 : size(lines_list, 1)
    mLenthLine_ = zeros(1, 5);
    len = distance([lines_list(i,1), lines_list(i,2)], [lines_list(i,3), lines_list(i,4)]);
    if len < minLen
        continue;
    end
    mLenthLine_(1) = len;
    mLenthLine_(2:5) = lines_list(i, :);
    mLenthLine = [mLenthLine; mLenthLine_];
end
% sort
[a, index] = sort(mLenthLine(:,1),'descend');
vSortedLine = mLenthLine(index, [2,3,4,5]);

vFusionLines = zeros(0, 4);
while size(vSortedLine,1) ~= 0
    maxLenLine = vSortedLine(1, :);
    vSortedLine(1, :) = [];
    
    maxLenLineParam = LineParam(maxLenLine);
    pts = zeros(0, 2);
    pts = [pts; [maxLenLine(1), maxLenLine(2)]];
    pts = [pts; [maxLenLine(3), maxLenLine(4)]];
    
    lines = zeros(0,4);
    lines = [lines; maxLenLine];
    
    lineDis = zeros(0,1);
    lastCnt = 0;
    
    while lastCnt < size(pts, 1)
        lastCnt = size(pts, 1);
        restLines = zeros(0, 4);
        maxLineAngle = LineNormalAngle(maxLenLineParam);
        for j = 1 : size(vSortedLine, 1)
            line = vSortedLine(j, :);
            
            lineParam = LineParam(line);
            
            angle = LineNormalAngle(lineParam);
            angleDis = abs(maxLineAngle - angle);
            angleDis = min(angleDis, 180 - angleDis);
            
            if angleDis > minAngleDis
                restLines = [restLines; line];
                continue;
            end
            d1 = abs(maxLenLineParam(1) * line(1) + maxLenLineParam(2) * line(2) + maxLenLineParam(3));
            d2 = abs(maxLenLineParam(1) * line(3) + maxLenLineParam(2) * line(4) + maxLenLineParam(3));
            d = (d1 +d2) / 2;
            
            if d > minDis
                restLines = [restLines; line];
                continue;
            end
            proLineDis = ProjectionDistance(maxLenLine, line);
            lineDis = [lineDis; proLineDis];
            if proLineDis > minGap
                restLines = [restLines; line];
                continue;
            end
            
            pts = [pts; [line(1), line(2)]];
            pts = [pts; [line(3), line(4)]];
            lines = [lines; line];
        end
        if lastCnt == size(pts, 1)
            break;
        end
        [maxLenLine, maxLenLineParam] = LineBoundary(lines);
        vSortedLine = restLines;
            
    end
    [fusionLine, fusionLineParam] = LineBoundary(lines);
    vFusionLines = [vFusionLines; fusionLine];
end

result = vFusionLines;






