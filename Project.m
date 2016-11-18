%transorm matrices
lms2lmsp = [0 2.02344 -2.52581; 0 1 0; 0 0 1] ;
lms2lmsd = [1 0 0; 0.494207 0 1.24827; 0 0 1] ;
lms2lmst = [1 0 0; 0 1 0; -0.395913 0.801109 0] ;
rgb2lms = [17.8824 43.5161 4.11935; 3.45565 27.1554 3.86714; 0.0299566 0.184309 1.46709] ;
lms2rgb = inv(rgb2lms) ;
%read picture into RGB value
file_name = '5';
RGB = im2double(imread(file_name,'jpeg'));
sizeRGB = size(RGB) ;
for i = 1:sizeRGB(1)
    for j = 1:sizeRGB(2)
        rgb = RGB(i,j,:);
        rgb = rgb(:);
        
        LMS(i,j,:) = rgb2lms * rgb;
    end
end
%transform to colorblind LMS values
for i = 1:sizeRGB(1)
    for j = 1:sizeRGB(2)
        lms = LMS(i,j,:);
        lms = lms(:);
        
        LMSp(i,j,:) = lms2lmsp * lms;
        LMSd(i,j,:) = lms2lmsd * lms;
    end
end

for i = 1:sizeRGB(1)
    for j = 1:sizeRGB(2)
        lms = LMSd(i,j,:);
        lms = lms(:);
        
        
        LMS_D(i,j,:) = lms2rgb * lms;
    end
end



%lab1 = rgb2lab(RGB);
%lab2 = rgb2lab(LMS_D);

% Convert image from RGB colorspace to lab color space.
cform = makecform('srgb2lab');
lab_Image = applycform(im2double(RGB),cform);
	
% Extract out the color bands from the original image
% into 3 separate 2D arrays, one for each color component.
LChannel = lab_Image(:, :, 1); 
aChannel = lab_Image(:, :, 2); 
bChannel = lab_Image(:, :, 3);

lab_Image1 = applycform(im2double(LMS_D),cform);
	
% Extract out the color bands from the original image
% into 3 separate 2D arrays, one for each color component.
LChannel1 = lab_Image1(:, :, 1); 
aChannel1 = lab_Image1(:, :, 2); 
bChannel1 = lab_Image1(:, :, 3);


% Then compute deltas of all images to that
deltaLs = LChannel - LChannel1; % Is an array if LMean is an array.
deltaas = aChannel - aChannel1; % Is an array if aMean is an array.
deltabs = bChannel - bChannel1; % Is an array if bMean is an array.
% Now compute all delta Es
deltaEs = sqrt(deltaLs.^2 + deltaas.^2 + deltabs.^2);
% Find ones with large color differences
%badImages = find(deltaEs > 5); % Images greater than 5 delta E from the ref.

