video= VideoReader('vidi.mp4');
 num_frames = video.NumberOfFrames;
    for f=230:240   %reading 10 frames 
       anchorframe = imresize(im2double(rgb2gray(read(video,f))),[128, 128]);  %anchor frame 128x128
       targetframe = imresize(im2double(rgb2gray(read(video,f+1))),[128, 128]);  %target frame 128x128
       [row,col] = size(anchorframe);
       
       figure;
       subplot(121), imshow(anchorframe), title('Anchor Frame');
       subplot(122), imshow(targetframe), title('Target Frame')
       
       R1 = edge(anchorframe(25:75,50:100),'Sobel'); %Region of anchor Frame
       R2 = edge(targetframe(25:75,50:100),'Sobel'); %Region of target Frame

       % Computing region based Displaced Frame 
       DFD_region = (imabsdiff(R1,R2).^2); % p=2 for MSE
       figure;
       subplot(131); imshow(R1); title('Frame 1');
       subplot(132); imshow(R2); title('Frame 2');
       subplot(1,3,3); imshow(DFD_region); title('Predicted error');

       figure;
       mv_x=zeros(1,50);  %computing the motion vectors
       mv_y=zeros(1,50);
        for i=1:50
           for j=1:50
             if DFD_region(i,j)==1
                mv_x(j)=j;
                mv_y(i)=i;
             end
           end
        end
       quiver(mv_y,mv_x),axis ij;  %plotting motion vectors
     end


