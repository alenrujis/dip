%% MyMainScript

tic;
%% Linear Contrast Enhancing
figure('Name', 'Linear Contrast Enhancing barbara')
myLinearContrastStretching('../data/barbara.png',1)
figure('Name', 'Linear Contrast Enhancing TEM')
myLinearContrastStretching('../data/TEM.png',1)
figure('Name', 'Linear Contrast Enhancing canyon')
myLinearContrastStretching('../data/canyon.png',0)
figure('Name', 'Linear Contrast Enhancing church')
myLinearContrastStretching('../data/church.png',0)
%% Histogram Equalization
figure('Name', 'Histogram Equalization barbara')
myHE('../data/barbara.png',1)
figure('Name', 'Histogram Equalization TEM')
myHE('../data/TEM.png',1)
figure('Name', 'Histogram Equalization canyon')
myHE('../data/canyon.png',0)
figure('Name', 'Histogram Equalization church')
myHE('../data/church.png',0)   

%% Histogram Matching
figure('Name', 'Histogram Matching Retina')
myHM()

%% Adaptive histogram Equalization
figure('Name', 'AHE barbara best')
myAHE('../data/barbara.png',1,200)
figure('Name', 'AHE barbara small window size')
myAHE('../data/barbara.png',1,5)
figure('Name', 'AHE barbara large window size')
myAHE('../data/barbara.png',1,500)

figure('Name', 'AHE TEM best')
myAHE('../data/TEM.png',1,150)
figure('Name', 'AHE TEM small window size')
myAHE('../data/TEM.png',1,5)
figure('Name', 'AHE TEM large window size')
myAHE('../data/TEM.png',1,500)

figure('Name', 'AHE canyon best')
myAHE('../data/canyon.png',0,200)
figure('Name', 'AHE canyon small window size')
myAHE('../data/canyon.png',0,3)
figure('Name', 'AHE canyon large window size')
myAHE('../data/canyon.png',0,300)

%% CLAHE

figure('Name', 'CLAHE barbara')
myCLAHE('../data/barbara.png',1, 200,0.01)
figure('Name', 'CLAHE barbara half threshold')
myCLAHE('../data/barbara.png',1, 200,0.005)

figure('Name', 'CLAHE TEM')
myCLAHE('../data/TEM.png',1, 100,0.01)
figure('Name', 'CLAHE TEM half threshold')
myCLAHE('../data/TEM.png',1, 100,0.005)

figure('Name', 'CLAHE canyon')
myCLAHE('../data/canyon.png',0,250 , 0.003)
figure('Name', 'CLAHE canyon half threshold')
myCLAHE('../data/canyon.png',0,250 , 0.0015)   

%%
toc;
