function [mMergedMst, vRearrangedVert, rootVertNew] = mergeVat(mDis, mExist, mMst1, mMst2, vLabels1, vLabels2, rootVert1, rootVert2)
%
% Merges two VAT images.
%
% INPUTS:
% mDis      - (N by N) dissimilarity matrix.
% mExist    - (N by N) matrix, indicating which values exist by 1 and 0
%               means missing or unknown values.
% mMst1     - (n1 by n1) Minimum spanning tree adjacency matrix.
% mMst2     - (n2 by n2) Minimum spanning tree adjacency matrix.
% vLabels1  - (n1 by 1) Vector of vertex lables (unique).
% vLabels2  - (n2 by 1) Vector of vertex lables (unique).
% rootVert1 - Root vertex of mMst1.
% rootVert2 - Root vertex of mMst2.
%
% OUTPUTS:
% mMergedMst    - The merged mst.
% rootVertNew   - Root vertex of the new mst.
%

    assert(length(vLabels1) == size(mMst1,1));
    assert(length(vLabels2) == size(mMst2,1));
    
    
    % find the smaller mMst, we will add vertices to the other mst, one by one
    bOneSmaller = false;
    if length(vLabels1) < length(vLabels2)
        bOneSmaller = true;
    end
    
    % find the overlap in labels
    vCommonLabels = intersect(vLabels1, vLabels2);
    vDiffLabels1 = setdiff(vLabels1, vCommonLabels);
    vDiffLabels2 = setdiff(vLabels2, vCommonLabels);
    mMergedMst = zeros(size(mDis,1), size(mDis,2));
    
    if bOneSmaller
        % add mMst1 to mMst2
        mMergedMst(vLabels2, vLabels2) = mMst2;
        currTreeLen = length(vLabels2);
        
        for v = 1 : length(vDiffLabels1)
            [mMergedMst] = addVertMst(mDis, mExist, mMergedMst, vDiffLabels1(v), rootVert2, currTreeLen);
            currTreeLen = currTreeLen + 1;
        end        
    else
        % add mMst2 to mMst1 
        mMergedMst(vLabels1, vLabels1) = mMst1;
        currTreeLen = length(vLabels1);
        
        for v = 1 : length(vDiffLabels2)
            [mMergedMst] = addVertMst(mDis, mExist, mMergedMst, vDiffLabels2(v), rootVert1, currTreeLen);
            currTreeLen = currTreeLen + 1;
        end
    end
    
    
    % new root
    [vV, vI] = max(mDis);
    [~, j] = max(vV);
    rootVertNew = vI(j);    
    
    
    %
    % construct the rearraned vertices by traversing the updated MST
    %
    
    vRearrangedVert = zeros(1, size(mMergedMst,1));
    
    % traverse the tree
    javaComparator = PriorityComparator;
    qPriority = java.util.PriorityQueue(size(mMergedMst,1), javaComparator);
    qPriority.add({0, rootVertNew});
    vTraversed = false(1, size(mMergedMst,1));
    currIndex = 1;
    
    while qPriority.size() > 0
        vHead = qPriority.poll();
        currVert = vHead(2);
        vTraversed(currVert) = true;
        vRearrangedVert(currIndex) = currVert;
        % find children + parents 
        vNeighs = find(mMergedMst(currVert,:));
        
        for v = 1 : length(vNeighs)
            neighVert = vNeighs(v);
            if ~vTraversed(neighVert)
                qPriority.add({mDis(currVert, neighVert), neighVert});
            end
        end
        
        currIndex = currIndex + 1;
    end        
    
    

    
%     % delete the overlapping vertices, concatenate the non-overlapping parts, 
%     vCommonInd1 = find(ismember(vLabels1, vCommonLabels));
%     mMstDel1 = deleteVertices(mMst1, vCommonInd1);
%     
%     vCommonInd2 = find(ismember(vLabels2, vCommonLabels));
%     mMstDel2 = deleteVertices(mMst2, vCommonInd2);
%     
%     
%     vDiffLabels1 = setdiff(vLabels1, vCommonLabels);
%     vDiffLabels2 = setdiff(vLabels2, vCommonLabels);
%     vDiffComb = cat(2, vDiffLabels1, vDiffLabels2);
%     
%     mMergedMst = zeros(size(mDis,1), size(mDis,2));
%     sum(mMergedMst)
%     % some potential overlap in copying
%     mMergedMst(vLabels1, vLabels1) = mMstDel1;
%     display('after adding mMstDel1');
%     sum(mMergedMst)
%     graphconncomp(sparse(mMergedMst))
%     mMergedMst(vLabels2, vLabels2) = mMstDel2;
%     display('after adding mMstDel2');
%     sum(mMergedMst)
%     graphconncomp(sparse(mMergedMst))
%     
%    
%     
%     % first, insert the edges between the the individual subtrees
%     for i = 1 : length(vDiffLabels1)
%         for j = 1 : length(vDiffLabels2)
%             mMergedMst = insertEdgeVat(mDis, mExist, mMergedMst, [vDiffLabels1(i), vDiffLabels2(j), mDis(vDiffLabels1(i),vDiffLabels1(j))], false);
%         end
%     end
%     % new root vert is the maximum of the distances in the current mMergedMst
% 
%     [vV, vI] = max(mDis(vDiffComb, vDiffComb));
%     [~, j] = max(vV);
%     rootVertNew = vI(j);
%     
%     display('after edge insertion')
%     sum(mMergedMst)
%     graphconncomp(sparse(mMergedMst))
%     
%     
%     % add the common edges back into mMergedMst
%     [~, mMergedMst, vRearrangedVert] = mergeAddVat(mDis, mExist, mMergedMst, vCommonLabels, rootVertNew, false);  
  
end % end of function


function [mMst] = deleteVertices(mMst, vDelVerts)
%
% Delete the vertices in vDelVerts from mMst.
%
    mMst(vDelVerts,:) = 0;
    mMst(:,vDelVerts) = 0;
end % end of function