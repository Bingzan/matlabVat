function streamDataVat(sDataOption, windowSize)
%
% INPUT:
% sDataOption       - Option for the data stream input.
%
% OUTPUT:
%

   cmData = getData(sDataOption);

    % construct distance matrix
    mDis = squareform(pdist(cmData{1}(:,1:2), 'euclidean'));
    % construct original MST
    [mDis, vRearrangedVert, ~, ~, mMst] = Vat(mDis, false);
    rootVert = vRearrangeVert(1);
    
    
    
    % feed in data, one slice at a time
    for t  = 2 : length(cmData)
        if t <= windowSize
            mCurrDis = squareform(pdist(cmData{t}(:,1:2),'enclidean'));
            origVert = [];
            for i = 1:(t-1)
                origVert = cat(1,origVert,cmData{i});
            end
            mNewDis = pdist2(origVert(:,1:2),cmData{t}(:,1:2),'enclidean');
            mNewPtsDis = cat(1,mNewDis,mCurrDis);
            [mDis, mMst, vRearrangedVert] = incVat(mDis, mExist, mMst, mNewPtsDis, rootVert, false);
            
        % remove points that fall outside the window
        else
            % delete points that were in cmData{t-windowSize}
            %vPointsToDel = 1 : length(cmData{t-windowSize});
            vPointsToDel = 1 : size(cmData{t-windowSize},1);
            
            % remove from MST
            [mDis,vRearrangedVert,mMst,rootVert] = deincVat(mDis,mMst,vPointsToDel,false);
            %[mDis, vRearrangedVert, mMst, rootVert] = deincVat(vRearrangedVert, mDis, mMst, rootVert, vPointsToDel, false);
        
            % compute new distances
            mCurrDis = squareform(pdist(cmData{t}(:,1:2), 'euclidean'));
            origVert = [];
            for i = (t-windowSize+1):(t-1)
                origVert = cat(1,origVert,cmData{i});
            end
            mNewDis = pdist2(origVert(:,1:2),cmData{t}(:,1:2),'enclidean');
            mNewPtsDis = cat(1,mNewDis,mCurrDis);
            [mDis, mMst, vRearrangedVert] = incVat(mDis, mExist, mMst, mNewPtsDis, rootVert, false);
            
        
            %oldestT = max(1, t-windowSize+1);
            %mNewPtsDis = squareform(pdist2(cmData{oldestT}, cmData{t}, 'euclidean'));
            %for i = oldestT + 1 : t
                %mNewPtsDis = cat(1, mNewPtsDis, squareform(pdist2(cmData{i}, cmData{t}, 'euclidean')));
            %end
            
            % add self distance to end of mNewPtsDis
            %mNewPtsDis = cat(1, mNewPtsDis, mCurrDis);
        
            % add new points in cmData{t}
            %[mDis, mMst, vRearrangedVert] = incVat(mDis, mExist, mMst, mNewPtsDis, rootVert, false);
        end
    end
    
end % end of function