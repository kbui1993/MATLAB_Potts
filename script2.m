%load image
butterfly = double(imread("tagpfauenauge.jpg"))/255;

%specify number of clusters
K=16;

%mean values
pixels = reshape(butterfly, 435*580,3);
[idx,C] = kmeans(double(pixels),K, 'MaxIter', 500);

%compute field
f = compute_squared_dist(double(butterfly), C);

%lambda parameter
lambda = 5;

%potts model
u_tight = potts_tight_pd(lambda*f, 300);

%make into rgb image
u_rgb = make_rgb(u_tight, C);

%show image
figure; imagesc(u_rgb);

