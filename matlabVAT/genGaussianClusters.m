function [mData, csClass] = genGaussianClusters(cvMeans, cmCovar, pointsPerClus, meanSigma)
%
% Generates two dimensional gaussian distributed data.
%
% INPUT:
% cvMeans       - cell of 2d means of each gaussian generated.
% cmCovar       - cell of 2x2 covariance matrices of the gaussians.
% pointsPerClus - Number of points per generated cluster.
%

    assert(length(cvMeans) == length(cmCovar));
    cSymbols = {'+', '*', 'o',  's', 'd', '^', 'v', 'p', 'h'};
    mColours = colormap(hsv(length(cvMeans)));
    
    figure;
    hold on;
    
    
    mData = zeros(length(cvMeans) * pointsPerClus, 2);
    csClass = cell(length(cvMeans), 1);
    
    
    for c = 1 : length(cvMeans)
        % means will be normally distributed
        vMean = normrnd(cvMeans{c}, meanSigma);
        % random scretches, each row should be normalised
        mCurrData = mvnrnd(vMean, cmCovar{c}, pointsPerClus);
        mData((c-1) * pointsPerClus + 1 : c * pointsPerClus, :) = mCurrData;
        for i = (c-1) * pointsPerClus + 1 : c * pointsPerClus
            csClass{i} = sprintf('%d', c);
        end
%         csClass{(c-1) * pointsPerClus + 1 : c * pointsPerClus} = 
        plot(mCurrData(:,1), mCurrData(:,2), 'LineStyle', 'none', 'Marker', cSymbols{c}, 'MarkerFaceColor', mColours(c,:));
    end
    
    hold off;

end % end of function