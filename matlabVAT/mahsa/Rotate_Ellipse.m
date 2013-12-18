function [ Corr_Mat ] = Rotate_Ellipse( MatrixA, RotationDegree, AxisArray )
%Rotate MatrixA counterclockwise by an angle of RotationDegree
%   Rotate MatrixA counterclockwise by an angle of RotationDegree using
%   Givens Matrix, AxisArray should include number of two axis to use for
%   rotation in acsending order
if((size(AxisArray,2)~=2))
   error('Rotation Axis matrix has zeros or it does not have two columns');
else
    RotationMat = eye(size(MatrixA));
    RotationMat(AxisArray(1,1),AxisArray(1,1)) = cos(RotationDegree);
    RotationMat(AxisArray(1,2),AxisArray(1,2)) = cos(RotationDegree);
    RotationMat(AxisArray(1,1),AxisArray(1,1)+1) = -sin(RotationDegree);
    RotationMat(AxisArray(1,2),AxisArray(1,2)-1) = sin(RotationDegree);
    Corr_Mat = RotationMat'*MatrixA*RotationMat;
clear RotationMat
end
end

%(j-1) * size(mat,1) + i
%     RotationMat = zeros(size(MatrixA));
%     RotationMat(AxisArray) = 100;
%     RotationMat = RotationMat+eye(size(MatrixA));
%     RotationMat(find(RotationMat>100)) = cos(RotationDegree);
%     RotationMat(find(RotationMat>90)) = sin(RotationDegree);