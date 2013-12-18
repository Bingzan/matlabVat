function [mNewDis,vRearrangedVert,mNewMst,rootVert] = deincVat(mDis,mMst,vPointsToDel,bVisualise)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    i = length(vPointsToDel);
    while i > 0
        [mDis,mMst] = deleteVertVat(mMst,mDis,1);
        i = i-1;
    end
    mNewDis = mDis;
    mNewMst = mMst;
    
    
    
    %
    % construct the rearraned vertices by traversing the updated MST
    %
    rootVert = 1;
    vRearrangedVert = zeros(1, size(mNewMst,1));
    
    % traverse the tree
%     qPriority = pq_create(length(vNewMst));
    javaComparator = PriorityComparator;
    qPriority = java.util.PriorityQueue(size(mNewMst,1), javaComparator);
%     pq_push(qPriority, rootVert, 0); 
    qPriority.add({0, rootVert});
    vTraversed = false(1, size(mNewMst,1));
    currIndex = 1;
    
%     while size(qPriority) > 0
    while qPriority.size() > 0
%         [currVert, ~] = pq_pop(qPriority);
        vHead = qPriority.poll();
        currVert = vHead(2);
        vTraversed(currVert) = true;
        vRearrangedVert(currIndex) = currVert;
        % find children + parents 
        vNeighs = find(mNewMst(currVert,:));
%         vNeighs = find(vNewMst == currVert);
%         parentVert = vNewMst(currVert);
%         if parentVert ~= 0
%             vNeighs = [vNeighs parentVert]; 
%         end
        
        for v = 1 : length(vNeighs)
            neighVert = vNeighs(v);
            if ~vTraversed(neighVert)
%                 pq_push(qPriority, neighVert, mNewDis(currVert, neighVert)); 
                qPriority.add({mNewDis(currVert, neighVert), neighVert});
            end
        end
        
        currIndex = currIndex + 1;
    end
    
    rootVert = vRearrangedVert(1);
  
    if bVisualise
       figure;
       colormap(gray);
       imagesc(mNewDis(vRearrangedVert, vRearrangedVert));
    end
end

