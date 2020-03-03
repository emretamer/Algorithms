function bin = bin_function(x,u,stdev)

[m,n] = size(x);

dist = 0;
for i = 1:n
    dist = dist + (x(i)-u(i))^2;
end

dist = dist^0.5;

if dist >stdev
    bin = 0;
else
    bin = 1;
end
