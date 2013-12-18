function [MatA CenterA] = GaussianMixtureState1(ElliNum)

    %Data Sample generation with the use of Mixture of Gaussian 
    %-----------------------------
    RandEllipse = rand(1);
    if RandEllipse < 0.7  
        [MatA CenterA] = GenEllipse(1,2,[18 26]); % 10 2Dim. ellipse around point [18 26]
    else if RandEllipse > 0.9 
            [MatA CenterA]= GenEllipse(1,2,[38 40]);
        else
            [MatA CenterA]= GenEllipse(1,2,[35 20]);          
        end
    end

    Ellipse_Plot(squeeze(MatA(1,:,:)),CenterA(1,:),ElliNum);
    hold on;


    % [row col] = find(X(:,4)==1);
    % plot(X(row,1),X(row,2),'*r')
    % hold on;

end