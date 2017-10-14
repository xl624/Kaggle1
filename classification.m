data = csvread('Extracted_features.csv');
graph = csvread('Graph.csv');
imagesc(data(1,:))
%% spectral clustering
A = zeros(6000,6000);
for i = 1:size(graph,1)
    A(graph(i,1),graph(i,2)) = 1;
end
D = zeros(6000,6000);
for i = 1:size(D,1)
    D(i,i) = sum(A(i,:));
end
L = D-A;
I = eye(6000);
Ltilder = I - D^(-0.5)*A*D^(0.5);
[V,~] = eigs(Ltilder,10);
%% CCA
X1 = data(1:6000,:);
X  = [X1,V];
sigma = cov(X);
sigma11 = sigma(1:1084,1:1084);
sigma22 = sigma(1085:1094,1085:1094);
sigma12 = sigma(1:1084,1085:1094);
sigma21 = sigma(1085:1094,1:1084);
[W1,~] = eigs(inv(sigma11)*sigma12*inv(sigma22)*sigma21,15);
for i = 1:6000
   X1(i,:) = X1(i,:)-mean(X(i,:)); 
end
Y1 = X1*W1;
c_kmeans = kmeans(Y1,10);
c_kmeans1 = kmeans(V,10);
idx(find(c_kmeans(idx)==6))

%% clustering using gaussian mixture model
gmfit = fitgmdist(X,k,'CovarianceType',Sigma{i},...
    'SharedCovariance',SharedCovariance{j},'Options',options);
clusterX = cluster(gmfit,X);