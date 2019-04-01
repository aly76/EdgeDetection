function B = GaussBlur(A)
    % Performs Gaussian Blur on an image A, using a predefined convolution
    % mask, and outputs the smooth image B. 
    
    sizeA = size(A);
    assert(sizeA(1) >= 5 || sizeA(2) >= 5, 'Input image must be greater than 5x5 pixels');
    A = double(A);
    
    B = zeros(sizeA(1)-4, sizeA(2)-4); % Initialise container for smoothed image
     
    filter = 1/159 * [2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2];  
    
    rowNum = 1;
    % Perform filtering on the input image
    while rowNum <= sizeA(1) - 4  
        for colNum = 1:sizeA(2)- 4 
            B(rowNum,colNum)  = sum(sum(filter.*A(rowNum:rowNum+4, colNum:colNum+4)));         
        end 
        rowNum = rowNum + 1; 
    end
    
    B = uint8(B);
    
end 

