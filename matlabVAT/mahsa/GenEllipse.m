function [ MatrixA Center ] = GenEllipse( N, D, C )
% Uses Rotate, Scale and Shift and Randomly generate N Ellipse with D dim
% around C

MatrixA = zeros(N,D,D);
Center = zeros(N,D);

% MatrixA(1,:,:) = Regular_Ellipse([(1 + 1.*rand(1,1)) (1 + 1.*rand(1,1))]); % r = a + (b-a).*rand(100,1); [a=5 b=10]
% MatrixA(1,:,:) = Rotate_Ellipse(squeeze(MatrixA(1,:,:)),pi/6,[1 2]);
MatrixA(1,:,:) = Regular_Ellipse([(1 + 1.* 0.5096) (1 + 1.*0.3442)]);

Center(1,:) = C;
temp=zeros(1,D);
for i=1:1:N
   %RoundPerm = randi([1,3],1,3);%randperm(3);
%    RoundPerm = floor((10*rand)/4)+1;
   RoundPerm = 3;
   MatrixA(i,:,:) = MatrixA(1,:,:);
   Center(i,:) = C;
   for j=1:1:1%3
       %switch RoundPerm(j)
       switch RoundPerm
           case 1 %1=Rotate
               temp=randperm(D);
               MatrixA(i,:,:) = Rotate_Ellipse(squeeze(MatrixA(i,:,:)),-pi/4+(pi/2)*rand,sort(temp(1,1:2)));
           case 2 %2=Scale
               MatrixA(i,:,:) = Scale_Ellipse(squeeze(MatrixA(i,:,:)));
           case 3 %3=Shift
               Center(i,:) = Center(i,:) + (rand(1,D)*2)-1; % randi([-1 1],1,D);
               %Center(i,:) = Center(i,:);
       end
   end
end

end

