% assignment #7
% classify normal-distributed data
close all;

%% dataset
w1 = [
    3,4;
    3,8;
    2,6;
    4,6;
   ];
w2 = [
    3,0;
    3,-4;
    1,-2;
    5,-2;
   ];

%% scatter plot
figure;
plotRange = [-6 12 -7 11];
scatter(w1(:,1),w1(:,2),100,'b^','filled');
hold on;
scatter(w2(:,1),w2(:,2),100,'r','filled');
hold off;
axis(plotRange);
axis equal;
legend('\omega_1','\omega_2');
xlabel('x');
ylabel('y');

%% normal distribution parameters
m1 = mean(w1);
m2 = mean(w2);
c1 = cov(w1);
c2 = cov(w2);

%% contour plot
N = 100;
x = linspace(-6,12,N)';
y = linspace(-7,11,N)';
[X,Y] = meshgrid(x,y);

figure;
F1 = mvnpdf([X(:),Y(:)],m1,c1);
F1 = reshape(F1,N,N);
contour(X,Y,F1);
text(m1(1),m1(2),'\omega_1');
hold on;
F2 = mvnpdf([X(:),Y(:)],m2,c2);
F2 = reshape(F2,N,N);
contour(X,Y,F2);
text(m2(1),m2(2),'\omega_2');
hold off;

colorbar;
axis equal;
xlabel('x');
ylabel('y');

%% surf plot
figure;
nc = 32;
colormap([winter(nc);autumn(nc)]);

h1 = surf(x,y,F1);
shading interp;
cdata = h1.CData;
cmin = min(cdata(:));
cmax = max(cdata(:));
h1.CData = min(nc,round((nc-1)*(cdata-cmin)/(cmax-cmin))+1); 
text(m1(1),m1(2),max(F1(:)),'\omega_1','FontSize',17);

hold on;
h2 = surf(x,y,F2);
shading interp;
cdata = h2.CData;
cmin = min(cdata(:));
cmax = max(cdata(:));
h2.CData = min(nc,round((nc-1)*(cdata-cmin)/(cmax-cmin))+1) + nc;
text(m2(1),m2(2),max(F2(:)),'\omega_2','FontSize',17);
hold off;

axis([plotRange,0,0.15]);
xlabel('x');
ylabel('y');
zlabel('pdf');

%% recognizing function
% d(X) = X'*W*X + w'*X + w0
d1 = recogfun([X(:)';Y(:)'],m1,c1,0.5);
d1 = reshape(d1,N,N);
d2 = recogfun([X(:)';Y(:)'],m2,c2,0.5);
d2 = reshape(d2,N,N);

figure;
levels = -100:5:0;
contour(x,y,d1,levels);
text(m1(1),m1(2),'\omega_1');
hold on;
contour(x,y,d2,levels);
text(m2(1),m2(2),'\omega_2');
hold off;

colorbar;
axis equal;
xlabel('x');
ylabel('y');

%% recognizing boundary
% err = 0.1;
% [J,I] = find(abs(d1-d2) < err);

% equation: y = 3/16 * (x-3)^2 + 1.77
b = 3/16*(x-3).^2 + 1.77;

% add boundary to former figures
figure(1);
hold on;
plot(x,b);
hold off;
axis(plotRange);

figure(2);
hold on;
plot(x,b);
hold off;
axis(plotRange);

figure(4);
hold on;
plot(x,b);
hold off;
axis(plotRange);