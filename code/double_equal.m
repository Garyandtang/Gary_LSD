function result = double_equal(a, b)
if a == b
    result = true;
    return;
end

abs_diff = abs(a - b);
aa = abs(a);
bb = abs(b);
if aa > bb
    abs_max = aa;
else
    abs_max = bb;
end

if abs < realmin
    abs_max = realmin;
end

if (abs_diff/ abs_max) <= (100 * 2.2204460492503131e-16)
    result = true;
else
    result = false;
end
