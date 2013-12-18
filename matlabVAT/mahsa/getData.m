function [ cmData ] = getData( sDataOption )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
switch sDataOption
        case 'mahsaSyn'
            stDb = load('X6.mat');
            tempData = stDb.X;
        case 'sensor'
            
        otherwise
        
end
    cmData = cell(max(tempData(:,3)),1);
    for i = 1:length(cmData)
        temp = tempData(:,3) == i;
        for j = 1:length(temp)
            if temp(j) == 1
                cmData{i} = cat(1,cmData{i},tempData(j,:));
            end
        end
    end


end

