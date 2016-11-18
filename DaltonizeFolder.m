function [  ] = DaltonizeFolder( ColorBlindType )
%{
    A function which gets a color blind type.
	The function run over all the bmp images in the "Data/Input Images/".
	For each image it will save in "Data/Output/" folder 3 images: 	
		The simulated image, The daltonized Image and the simulated daltonized image.
    Input:
        ColorBlindType: 
            1 for protanopes, 2 for deuteranopes, 3 for tritanopic
%}
    
    % add all necessary path to matlab
    %addpath(genpath('Misc'));
    %AddMandatoryFolders();
    
    % remove all warnings
    %warning ('off','all');
    
    % create output folder
    if ColorBlindType == 1      
        OutputFolder = 'C:\\Final year\\Projects\\DIP';
    elseif ColorBlindType == 2   
        OutputFolder = 'C:\Final year\Projects\DIP';
    elseif ColorBlindType == 3   
        OutputFolder = 'C:\Final year\Projects\DIP';
    end
    mkdir(OutputFolder);
    
    % read all .bmp names from ../Data/Input Images/ folder
    TestImagesList = dir('C:\Final year\Projects\DIP\*.bmp');    
    
    % Calc Number of files
    ImagesCount = length(TestImagesList);                  

    % for each image
    for ii=1:ImagesCount
        CurrentImageName = TestImagesList(ii).name;
        
        %# read original image
        OriginalImage = imread(CurrentImageName);                                                   
        
        %# find Simulated image
        SimulateImage = SimulateColorBlindImage(ColorBlindType,OriginalImage);           
        
        %# daltonized image
        DaltonizedImage = ColorBlindFix(ColorBlindType,OriginalImage);                   
        
        %# find simulated daltonize
        SimulatedDaltonize = SimulateColorBlindImage(ColorBlindType,DaltonizedImage);    
        
        % Save Results       
        FileName = strcat('/(Simulated)' ,CurrentImageName);
        imwrite(SimulateImage,strcat(OutputFolder,FileName),'bmp');            
        FileName = strcat('/(Daltonized)' ,CurrentImageName);
        imwrite(DaltonizedImage,strcat(OutputFolder,FileName),'bmp');         
        FileName = strcat('/(Simulated Daltonized)' ,CurrentImageName);
        imwrite(SimulatedDaltonize,strcat(OutputFolder,FileName),'bmp');      
     
    end
    disp('DaltonizeFolder(): Done!');
end