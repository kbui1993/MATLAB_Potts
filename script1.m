%load image
col3 = imread("col3.png");

%specify number of clusters
K=3;

%mean values
means_rgb = [255 0 0; 0 255 0; 0 0 255];

%compute field
f = compute_squared_dist(double(col3), means_rgb);

%potts model
u_tight = potts_tight_pd(f, 5000);

%make into rgb image
u_rgb = make_rgb(u_tight, means_rgb);

%show image
figure; imagesc(u_rgb/255);


