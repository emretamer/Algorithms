function density = density2(data,u,clusteri,clusterj,stdev)

sum = 0;
for a =1:length(clusteri)
    bin = bin_function(data(clusteri(a),:),u,stdev);
    sum = sum + bin;
end

if clusterj(1) >0
    for b = 1:length(clusterj)
        bin = bin_function(data(clusterj(b),:),u,stdev);
        sum = sum + bin;
    end
end

density = sum;
    