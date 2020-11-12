classdef BinaryImage
    % Returns a black & while image depending on the set threshold
    
    methods(Static)
        function binaryImage = imageToBinary(image)
            grayImage = rgb2gray(image);
            binaryImage = imbinarize(grayImage, 'adaptive','Sensitivity', 0.85);
        end
    end
end

