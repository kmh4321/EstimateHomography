%
% W18 EECS 504 HW1p1 Homography Estimation
%

close all;

% Load image
inpath1 = 'football1.jpg';
inpath2 = 'football2.jpg';

im1 = imread(inpath1);
im2 = imread(inpath2);

% Display the yellow line in the first image
figure;
imshow(im1); title('football image 1');
hold on;
u=[1210,1701];v=[126,939];  % marker 33
%u=[942,1294];v=[138,939];
plot(u,v,'y','LineWidth',2);
hold off;

%------------------------------------------------
% Specify the number of pairs/correspondences
% of points you need.
n = 8;
%------------------------------------------------

% Get n correspondences
baseName = regexp(inpath1,'^\D+','match','once');
pointsPath = sprintf('%s_points%i.mat',baseName,n);
if exist(pointsPath,'file') 
   % Load saved points
   load(pointsPath);
else
   % Get correspondences
   [XY1, XY2] = getCorrespondences(im1,im2,n);
   save(pointsPath,'XY1','XY2');
end



XY2 = XY2';
y = XY2(:);
XY1 = XY1';
XY1 = XY1(:);
A = [
    XY1(1), XY1(2),1,0,0,0,-XY1(1)*y(1),-XY1(2)*y(1);
    0,0,0,XY1(1), XY1(2),1,-XY1(1)*y(2),-XY1(2)*y(2);
    XY1(3), XY1(4),1,0,0,0,-XY1(3)*y(3),-XY1(4)*y(3);
    0,0,0,XY1(3), XY1(4),1,-XY1(3)*y(4),-XY1(4)*y(4);
    XY1(5), XY1(6),1,0,0,0,-XY1(5)*y(5),-XY1(6)*y(5);
    0,0,0,XY1(5), XY1(6),1,-XY1(5)*y(6),-XY1(6)*y(6);
    XY1(7), XY1(8),1,0,0,0,-XY1(7)*y(7),-XY1(8)*y(7);
    0,0,0,XY1(7), XY1(8),1,-XY1(7)*y(8),-XY1(8)*y(8);
    XY1(9), XY1(10),1,0,0,0,-XY1(9)*y(9),-XY1(10)*y(9);
    0,0,0,XY1(9), XY1(10),1,-XY1(9)*y(10),-XY1(10)*y(10);
    XY1(11), XY1(12),1,0,0,0,-XY1(11)*y(11),-XY1(12)*y(11);
    0,0,0,XY1(11), XY1(12),1,-XY1(11)*y(12),-XY1(12)*y(12);
    XY1(13), XY1(14),1,0,0,0,-XY1(13)*y(13),-XY1(14)*y(13);
    0,0,0,XY1(13), XY1(14),1,-XY1(13)*y(14),-XY1(14)*y(14);
    XY1(15), XY1(16),1,0,0,0,-XY1(15)*y(15),-XY1(16)*y(15);
    0,0,0,XY1(15), XY1(16),1,-XY1(15)*y(16),-XY1(16)*y(16);
    ];
x = A\y;

H = [x(1),x(2),x(3);x(4),x(5),x(6);x(7),x(8),1];

point1 = [u(1);v(1);1];
point2 = [u(2);v(2);1];

point1_new = H*point1;
point2_new = H*point2;

u_new = [point1_new(1)/point1_new(3), point2_new(1)/point2_new(3)];
v_new = [point1_new(2)/point1_new(3), point2_new(2)/point2_new(3)];

figure;
imshow(im2); title('football image 2');
hold on;
%u=[942,1294];v=[138,939];
plot(u_new,v_new,'y','LineWidth',2);
hold off;