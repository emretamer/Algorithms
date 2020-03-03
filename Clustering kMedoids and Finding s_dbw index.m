clc
clear all
% To read the data from an excel file
data = xlsread("DataforCluster","B2:E249289");
% To find Variance of Data Set = var(s)
var_s=(var(data)*(var(data))')^0.5;

[m,n]=size(data);
%% Cluster
for k = 10:50
    count = zeros(k,1);
    var_cluster=zeros(k,1);
    dens_bw=zeros(k,k);
    dens_all=zeros(k,k);
    clear cluster
    % !!! MY DATA HAS 200k ROWS, SO YOU MAY WANT TO CHANGE "NAME-VALUES"
    % BELOW
    [idx,C,sumd,D,midx] = kmedoids(data,k,'algorithm','clara','Replicates',20,'NumSamples',1000);
    %% Index
    %To find cluster members
    for i = 1:m
        count(idx(i))=count(idx(i))+1;
        cluster{idx(i)}(count(idx(i)))=i;
    end
    % To find Scat
    for i = 1:k
        var_cluster(i) =(var(data(cluster{i},:))*(var(data(cluster{i},:)))')^0.5;
    end
    varall(k)=sum(var_cluster);
    scat(k) = varall(k)/(k*var_s);
    
    stdev = sqrt(varall(k))/k;
    % To find densities
    
    for i = 1:k
        for j = 1:k
            dens_bw(i,j)=density2(data,(C(i,:)+C(j,:))/2,cluster{i},cluster{j},stdev);
        end
    end
    
    for i = 1:k
        dens_bw(i,i)=dens_bw(i,i)/2;
    end
    
    
    for i = 1:k
        for j = 1:k
            if i~=j
                dens_all(i,j)=dens_bw(i,j)/max(dens_bw(i,i),dens_bw(j,j));
            end
        end
    end
    density_idx(k) = sum(dens_all,'all')/(k*(k-1));
    density_index(k) = density_idx(k)+scat(k);
end
