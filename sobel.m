function [X Y] = sobel(A)

    sizeA = size(A);
    assert(sizeA(1) >= 3 || sizeA(2) >= 3, 'Input image must be greater than 5x5 pixels');
    A = double(A);
    
    X = zeros(sizeA(1)-2, sizeA(2)-2); % Initialise container for gradients in x direction
    Y = zeros(sizeA(1)-2, sizeA(2)-2); % Initialise container for gradients in y direction
    
    sobelFilterX = [-1 0 1; -2 0 2; -1 0 1]; 
    sobelFilterY = [-1 -2 -1; 0 0 0; 1 2 1];
        
    rowNum = 1;
    % Perform filtering on the input image
    while rowNum <= sizeA(1) - 2  
        for colNum = 1:sizeA(2)- 2 
            X(rowNum, colNum) = sum(sum(sobelFilterX.*A(rowNum:rowNum+2, colNum:colNum+2))); 
            Y(rowNum,colNum)  = sum(sum(sobelFilterY.*A(rowNum:rowNum+2, colNum:colNum+2))); 
        end 
        rowNum = rowNum + 1; 
    end

end 