
%Data Sample generation with the use of Mixture of Gaussian 
%-----------------------------
[Mat1 Center1] = GenEllipse(1,2,[18 26]); % 10 2Dim. ellipse around point [18 26]
[Mat2 Center2]= GenEllipse(1,2,[35 20]);
[Mat3 Center3]= GenEllipse(1,2,[38 40]);
MatA = cat(1,Mat1,Mat2,Mat3);
CenterA = [Center1;Center2;Center3];
for i=1:1:3
    Ellipse_Plot(squeeze(MatA(i,:,:)),CenterA(i,:),i);
    hold on;
end
X=[];
% Generate data from the ellipses by using Mixture of Gaussian Distribution
for i=1:1:14
    MU1 = CenterA(i,:);
    SIGMA1 = inv(squeeze(MatA(i,:,:)));

    count = round(100+50*rand(1,1));
    X = [X;mvnrnd(MU1,SIGMA1,count) repmat(i,count,1)];
    
end
plot(X(:,1),X(:,2),'.b')
hold on;
% [row col] = find(X(:,4)==1);
% plot(X(row,1),X(row,2),'*r')