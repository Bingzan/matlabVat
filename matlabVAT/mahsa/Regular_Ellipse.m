function [ Corr_Mat ] = Regular_Ellipse( InputArray )
%Function return a Matrix representaion of ellipse with given radii
%   Function return a digonal Matrix and put the inverse of the squared
%   elements the main diagonal
if(InputArray==0)
   error('Input array should not have any zeros');
else
    InputArray = InputArray.^2;
    InputArray = 1./InputArray;
    Corr_Mat=diag(InputArray);
end
end

