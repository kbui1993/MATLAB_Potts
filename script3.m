%load image
butterfly = double(imread("tagpfauenauge.jpg"))/255;

%specify number of clusters
K=16;

%solve potts model with 16 clusters with fidelity paramter 5 for 300
%iterations
pwc_f = main_pott(butterfly, K, 5, 300);

%display image
figure; imagesc(pwc_f);