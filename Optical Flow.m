clear;
clc;
video = VideoReader('vidi.mp4');
% obtaining the velocity/motion vector using using Lucas-Kanade derivative of Gaussian method
opticFlow =  opticalFlowLKDoG;
     for f=230:240         %reading 10 frames 
       anchorframe = imresize(im2double(rgb2gray(read(video,f))),[128, 128]);  %anchor frame 128x128
       targetframe = imresize(im2double(rgb2gray(read(video,f+1))),[128, 128]);  %target frame 128x128
       %calculation motion vetor from the target frame
       flow = estimateFlow(opticFlow,targetframe);
       
       figure;
       subplot (121), imshow(anchorframe), title('Anchor Frame'); 
       subplot (122), imshow(targetframe), title('Target Frame');
       figure;
       subplot (121), imshow(targetframe), title('Motion vector Frame');
       hold on
       plot(flow,'DecimationFactor',[5 5],'ScaleFactor',10);
       hold off
       subplot (122), plot(flow,'DecimationFactor',[5 5],'ScaleFactor',10), title('Plot of Motion Vector');
     end