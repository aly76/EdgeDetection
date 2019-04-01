% Alan Ly
% Canny edge detection
close all 
clear all 
clc 

%% Gaussion smoothing
A = imread('test00.jpg');

figure(1)
imshow(A)
title('Original image'); 

B = GaussBlur(A);

figure(2) 
imshow(B)
title('Blurred image');

%% Sobel filter
 
[X,Y] = sobel(B);

%% Gradient magnitude

G = sqrt(X.^2 + Y.^2);
figure(3) 
imshow(G)
title('Gradient magnitude');
G_old = G; % Debugging

%% Gradient orientation

theta = atan(Y./X);
thetad = theta * 180/pi; 
thetad_round = round(thetad/45)*45; 
nanIndex = isnan(thetad_round);
thetad_round(nanIndex) = 10^6; 

figure(4) 
imshow(thetad_round);
title('Gradient Orientation Uncolourised');

% Creating colour map
sizeTheta = size(thetad_round);

imageRED = zeros(sizeTheta(1),sizeTheta(2)); 
imageGREEN = zeros(sizeTheta(1),sizeTheta(2)); 
imageBLUE = zeros(sizeTheta(1),sizeTheta(2));


          
pixels45 = thetad_round==45; % red
imageRED(pixels45) = 255;

pixelsn45 = thetad_round==-45; % green
imageGREEN(pixelsn45) = 255;

pixels90 = thetad_round==90; % blue
imageBLUE(pixels90) = 255;

pixelsn90 = thetad_round==-90; % pink
imageRED(pixelsn90) = 200;
imageGREEN(pixelsn90) = 0;
imageBLUE(pixelsn90) = 200;
          
pixels0 = thetad_round == 0; %purple
imageRED(pixels0) = 163;
imageGREEN(pixels0) = 73;
imageBLUE(pixels0) = 164;

thetaCOLOUR = cat(3,imageRED,imageGREEN,imageBLUE);
figure(5); 
imshow(thetaCOLOUR);
title('Gradient Orientation Colourised');



%% Non-maxima suppression


sizeG = size(G);
G_edge = zeros(sizeG(1), sizeG(2)); 

for i = 2:sizeG(1)-1
    for j = 2:sizeG(2)-1
        switch thetad_round(i,j)
            case 90 
                if (G(i,j)>= G(i+1,j) && G(i,j) >= G(i-1,j))
                        G_edge(i,j) = G(i,j);
                                       
                     
                end 
            case -45 
                if (G(i,j) > G(i-1,j+1) && G(i,j) > G(i+1, j-1))
                     
                        G_edge(i,j) = G(i,j);

                end 
            case 0
                if (G(i,j) >= G(i,j-1) && G(i,j) >= G(i,j+1))

         
                  
                        G_edge(i,j) = G(i,j);
                 
                    
                end 
            case 45 
                if (G(i,j) > G(i+1,j+1) && G(i,j) > G(i-1, j-1))

                        G_edge(i,j) = G(i,j);

                end 
            case -90 
                if (G(i,j)>= G(i+1,j) && G(i,j) >= G(i-1,j))

                   
               
                        G_edge(i,j) = G(i,j);
                 
                    
                end
            otherwise
                    G(i,j) = 0;
        end                                
    end 
end 

figure(6)
imshow(G_edge);
title('Non-maxima suppression');

%thresholding 
G_edgeThresh = G_edge; 
lower_threshIndex = G_edge < 40;
upper_threshIndex = G_edge > 100; 
middle_threshIndex = G_edge >= 40 & G_edge <= 100;   
G_edgeThresh(lower_threshIndex) = 0; 
G_edgeThresh(upper_threshIndex) = 256;
G_edgeThresh(middle_threshIndex) = 256/2;

figure(7)
imshow(G_edgeThresh);
title('Non-maxima suppression and double thresholding');

