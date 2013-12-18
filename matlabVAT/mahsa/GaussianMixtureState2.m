function [MatA CenterA] = GaussianMixtureState2(ElliNum)

    %Data Sample generation with the use of Mixture of Gaussian 
    %-----------------------------
    RandEllipse = rand(1);
    if RandEllipse < 0.7  
        [MatA CenterA] = GenEllipse(1,2,[40 30]); % 10 2Dim. ellipse around point [40 30]
    else 
        [MatA CenterA]= GenEllipse(1,2,[30 50]);
    end

    Ellipse_Plot(squeeze(MatA(1,:,:)),CenterA(1,:),ElliNum);
    hold on;

    % [row col] = find(X(:,4)==1);
    % plot(X(row,1),X(row,2),'*r')
    % hold on;

end