
%read image
I  = imread('C:\Users\thithilab\Desktop\San Chain\my research\dataset\csv files-20220527T010001Z-001\csv files\matlab\K Mean\G6\Threshod 4\Crop_all\remove_noise\remove_onlyblack\_003196.mat__53.png');
%figure,imshow(I)
II = I;

%Rotate the image.
rotI = imrotate(I,0,'crop');
%figure,imshow(rotI)


%Create a binary image.
BW = edge(rotI,'canny');

%Create the Hough transform using the binary image
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;


%Find peaks in the Hough transform of the image.
P  = houghpeaks(H,5,'threshold',ceil(0.2*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');


%find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(rotI), hold on
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end

   

end

