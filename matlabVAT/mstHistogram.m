function [avg, med] = mstHistogram(mR, mMst, binNum)
%
% Compute the histogram of MST (mMst).
%
% INPUTS:
% mR        - Distance matrix.
% mMst      - Minimum spanning tree.
% binNum    - Number of bins to use for histogram.
%

    
    figure;
    vValues = [];
    for i = 1 : length(vMstChain)-1
        vValues = [vValues mR(vMstChain(i), vMstChain(i+1))];
    end
    
    hist(vValues, binNum);  
    
    avg = mean(vValues);
    med = median(vValues);

    figure;
    plot(vValues);
end