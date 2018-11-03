%{
 * Computes the NFA values based on the total number of points, points that agree.
 * n, k, p are the binomial parameters.
 * @return      The new NFA value.
%}
function result = nfa(n, k, p, angles)
LOG_NT = 5 * (log10(size(angles,2)) + log10(size(angles,1))) / 2 + log10(11.0);
if n == 0 || k == 0
    result = LOG_NT;
    return;
end

if n == k
    result = - LOG_NT - n * log10(p);
    return;
end

p_term = p / (1 - p);
log1term = (n + 1) - log_gamma(k + 1) - log_gamma(n-k + 1)  + k * log(p) + (n-k) * log(1.0 - p);
term = exp(log1term);

if double_equal(term, 0)
    if ( k > n *p)
        result = -log1term / 2.30258509299404568402 - LOG_NT;
        return;
    else
        result = - LOG_NT;
        return;
    end
end

bin_tail = term;
tolerance = 0.1;

for i = k +1 : n + 1
    bin_term = (n - i +1) / i;
    mult_term = bin_term * p_term;
    term = term * mult_term;
    bin_tail = bin_tail + term;
    if bin_tem < 1
        err = term * ((1 - mult_term^(n-i+1))/(1-mult_term) - 1);
        if err < tolerance * abs(-log10(bin_tail) - LOG_NT) * bin_tail
            break;
        end
    end
end
result = -log10(bin_tail) - LOG_NT;