addpath('./filter');
addpath('../assets');

% Placeholder Class / Main
    
 image = imread('../assets/Segbild1.jpg');
 image = BinaryImage.imageToBinary(image);
 image = EdgeDetector.cannyFilter(image);
 imshow(image)
