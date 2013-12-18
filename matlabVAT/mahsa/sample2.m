 
clear;
clc;

CurrentState = 1;
CurrentColor = '.r';
counter = 1;
ElliNum = 0;
Label = [];

for samplenum = 7 : 7
    X = [];
    StateVector = [];
   
    for counter = 1 : 11

        % Call the related function based on CurrentState
        % onset the state changes it refresh the distributions
        
        x = 18 + (counter-1)*1.7;
        y = 26 - (counter-1)*0.6;
  
            [MatA1 CenterA1]= GenEllipse(1,2,[x y]); % 10 2Dim. ellipse around point [18 26]
            [MatA2 CenterA2]= GenEllipse(1,2,[38 40]);
            [MatA3 CenterA3]= GenEllipse(1,2,[35 20]);
            MatA = cat(1,MatA1,MatA2,MatA3);
            CenterA = [CenterA1;CenterA2;CenterA3];
            ElliNum = 3;
            Label = [1 2 3];
        
        count =round(99/length(Label));
        for i=1:1:length(Label)
        % Generate data from the ellipses by using Mixture of Gaussian Distribution
            MU1 = CenterA(i,:);
            SIGMA1 = inv(squeeze(MatA(i,:,:)));
%             count = round(100+50*rand(1,1));
            X = [X;mvnrnd(MU1,SIGMA1,count) repmat(counter,count,1) repmat(Label(i),count,1)];
            StateVector = [StateVector repmat(CurrentState, 1, count)] ;
            
            Ellipse_Plot(squeeze(MatA(i,:,:)),CenterA(i,:),i);
            hold on;
            
        
        end
    end
    
    plot(X(:,1),X(:,2),CurrentColor);
    hold on;

    save(sprintf('Database/X%d',samplenum),'X');
    save(sprintf('Database/StateVector%d',samplenum),'StateVector');
end
% hold off;
% %
% 
% plot ( StateVector, 'LineWidth',4);
% xlabel('Generated Date');
% ylabel('State');
% title('Transition of States');
% axis([1 length(StateVector) 1 2]);