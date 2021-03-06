function [mRearrangedDis, vPermVerts, vMstChain, vMinWeights, mMst] = VatNoIncre(mDis,vNewPtsDis, bVisualise)
    % Example function call: [DV,I] = VAT(D);
    %
    % *** Input Parameters ***
    % @param mDis (n*n double): Dissimilarity data input
    % bVisualise        - whether to visualise the output.
    % 
    % *** Output Values ***
    % @value RV (n*n double): VAT-reordered dissimilarity data
    % @value C (n int): Connection indexes of MST
    % @value I (n int): Reordered indexes of mDis, the input data
    % vMinWeights       - MST weights.
    % mMst              - MST.
    %
    % It appears to be an implementation of Prim's algorithm.
    %
    % Modified by Jeffrey Chan, 5/2013
    %

    mDis = [mDis vNewPtsDis];
    mDis = [mDis;[vNewPtsDis' 0]];
    
    [N,~]=size(mDis);

    K=1:N;
    vToLink=K;
    
%     vPermVerts = zeros(1,N);
    vMstChain = zeros(1,N);   
    vMinWeights = zeros(1,N-1);
    mMst = zeros(N,N);

    % step 2 of VAT algorithm, where the edge with largest dissimilar is chosen
    % as root of MST
    [y,i]=max(mDis);
    [~,j]=max(y);

    rootVert = i(j);
    vPermVerts = rootVert;
    vMstChain(rootVert) = 0;
    vToLink(rootVert)=[];
    
    % Step 3
    % I think this is outside of main loop to slightly speed up, because in
    % first iteration, I is a singleton set and hence j is a single integer
    % already.
    [minVal,j]=min(mDis(vPermVerts,vToLink));
    vPermVerts = [vPermVerts vToLink(j)];
    vMstChain(2) = vPermVerts(1);
    mMst(rootVert, vToLink(j)) = 1;
    mMst(vToLink(j), rootVert) = 1;
    vToLink(vToLink==vToLink(j))=[];
    vMinWeights(1) = minVal;

    for r = 3 : N-1,
        [y,i]=min(mDis(vPermVerts,vToLink));%
        temp = zeros(1,length(i));
        for m = 1:length(i)
            temp(m) = vPermVerts(i(m));
        end
            
        [minVal,j]=min(y);
        vPermVerts = [vPermVerts vToLink(j)];
        vMstChain(r) = j;
        mMst(temp(j), vToLink(j)) = 1;%
        mMst(vToLink(j), temp(j)) = 1;%
        vToLink(vToLink==vToLink(j))=[];
        vMinWeights(r-1) = minVal;
    end;
    
    % last element in vToLink
    [y,i]=min(mDis(vPermVerts,vToLink));
    temp = zeros(1,length(i));
        for m = 1:length(i)
            temp(m) = vPermVerts(i(m));
        end
    
    [minVal,j] = min(y);
    vPermVerts = [vPermVerts vToLink];
    vMstChain(N) = j;
    mMst(temp(j), vToLink) = 1;
    mMst(vToLink, temp(j)) = 1;
    vMinWeights(N-1) = minVal;


    % step 4
    %mRearrangedDis=mDis(vPermVerts, vPermVerts);
    mRearrangedDis = mDis;
    
    if bVisualise
       figure;
       %mRange = ones(64,3);
       %mRange(:,2) = 0:1/63:1;
       %myColormap = hsv2rgb(mRange);
       %colormap(myColormap);
       colormap(gray);
       imagesc(mRearrangedDis);
    end

end % end of function