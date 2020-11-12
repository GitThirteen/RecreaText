classdef BinaryImage
    % Returns a black & while image depending on the set threshold
    
    methods(Static)
        function binaryImage = imageToBinary(image)
            grayImage = rgb2gray(image);
            binarized = imbinarize(grayImage, 'adaptive','Sensitivity', 0.85);
            
            morphObj = strel('square', 10);
            binaryImage = imclose(binarized, morphObj);
        end
    end
end
