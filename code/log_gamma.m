function result = log_gamma(x)
if x > 15
    % a = 0.918938533204673 + (x-0.5)*log(x) - x + 0.5*x*log(x*sinh(1/x) + 1/(810.0*x^6));
    q = [ 75122.6331530, 80916.6278952, 36308.2951477, 8687.24529705, 1168.92649479, 83.8676043424, 2.50662827511 ];
    a = (x + 0.5) * log(x + 5.5) - (x + 5.5);
    b = 0;
    for n = 1 : 7
        a = a - log(x + n);
        b = b + q(n) * x^n;
    end
    result = a + log(b);
else 
    result = gammaln(x);
end
    