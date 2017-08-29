% Getting the train parameters
thresh_level = 40;
%Mac or Windows
% load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Train/100cm__Decoded.mat');
load('C:\Users\david\Desktop\Samples\Images\Cidade Universitária\Estrada1\Train\100cm__Decoded.mat');
[train_central_im, train_sum_im_v, train_sum_im_h, train_sum_im_t] = sumAllApertures( LF , thresh_level);
t_central_im  = getCentralAperture( LF );

%% Plot train image
figure;
subplot(1,2,1);
imshow(t_central_im);
title('Train image');

subplot(1,2,2);
imshow(train_sum_im_t);
title('Train image Saturated');

%%
trained_mean = mean2(train_sum_im_t);
trained_std = std2(train_sum_im_t);

%%
[trained_mean, trained_std] = train_params(train_sum_im_t, thresh_level);  

%% Processing the crack image
% load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Imagem1/100cm__Decoded.mat');
load('C:\Users\david\Desktop\Samples\Images\Cidade Universitária\Estrada1\Imagem2\100cm__Decoded.mat');
[sat_central_im, sum_im_v, sum_im_h, sum_im_t] = sumAllApertures( LF , thresh_level );
central_im  = getCentralAperture( LF );
final_im = sum_im_v + sum_im_h;
%% Plot central image
figure;
imshow(sat_central_im);
title('Central Image');

%% Plotting apertures
figure;
imshow(sum_im_v);
title('Sum Vertical');

figure;
imshow(sum_im_h);
title('SUM Horizontal');
%% Plot final image
figure;
imshow(final_im)
title('SUM total')

%% Histogram
final_im = sum_im_v + sum_im_h;

sigma = 2;
equalizada=histeq(final_im);

% Version r2013
cutoff = ceil(3*sigma);
h = fspecial('gaussian', 2*cutoff+1, sigma);
smooth_im = imfilter(final_im,h,'replicate');

% % Imgaussfit only works in Matlab >r2013
% smooth_im = imgaussfilt(final_im, 1.5);

figure;
subplot(3,3,1);
imshow(final_im);
title('Imagem Original');

subplot(3,3,2);
imshow(equalizada);
title('Imagem Equalizada');

subplot(3,3,3);
imshow(smooth_im);
title('Imagem Original Alisada');

subplot(3,3,4);
imhist(final_im);
title('Original');

subplot(3,3,5);
imhist(equalizada);
title('Equalizada');

subplot(3,3,6);
imhist(smooth_im);
title('Original Filtrada');

bin_image1 = im2bw(final_im , 0.5);
subplot(3,3,7);
imshow(bin_image1);
title('Imagem Original binarizada');

bin_image2 = im2bw(equalizada , 0.99);
subplot(3,3,8);
imshow(bin_image2);
title('Imagem Equalizada binarizada');

bin_image3 = im2bw(smooth_im , 0.2);
subplot(3,3,9);
imshow(bin_image3);
title('Imagem Original filtrada binarizada');
%% Closing Operation
ss = strel('disk',7);
close_bin_image = imclose(bin_image3,ss);

figure;
subplot(1,2,1);
imshow(bin_image3);
title('Closing operation');

subplot(1,2,2);
imshow(close_bin_image);
title('Closing operation');
%% Block Detect
num_of_blocks = 40;
trained_mean = mean2(train_sum_im_t);
trained_std = std2(train_sum_im_t);
% Imagem original
[ res1, mean_std_crack_block1, mean_mean_crack_block1, mean_std_no_crack_block1, mean_mean_no_crack_block1 ] = ...
    block_detect( final_im, num_of_blocks, 0.3, 1);

[ res2, mean_std_crack_block2, mean_mean_crack_block2, mean_std_no_crack_block2, mean_mean_no_crack_block2 ] = ...
    block_detectV2( final_im, num_of_blocks, trained_mean, 5);

t_smooth_im = imfilter(train_sum_im_t,h,'replicate');
s_trained_mean = mean2(t_smooth_im);
s_trained_std = std2(t_smooth_im);
% Imagem original blured
[ res3, mean_std_crack_block3, mean_mean_crack_block3, mean_std_no_crack_block3, mean_mean_no_crack_block3 ] = ...
    block_detect( smooth_im, num_of_blocks, 0.3, 1);

[ res4, mean_std_crack_block4, mean_mean_crack_block4, mean_std_no_crack_block4, mean_mean_no_crack_block4 ] = ...
    block_detectV2( smooth_im, num_of_blocks, s_trained_mean, 5);

figure;
subplot(2,3,1);
imshow(final_im);
title('Original Image');

subplot(2,3,2);
imshow(res1);
title('Block detect V1');

subplot(2,3,3);
imshow(res2);
title('Block detect V2');

subplot(2,3,4);
imshow(smooth_im);
title('Blured Original Image');

subplot(2,3,5);
imshow(res3);
title('Block detect V1');

subplot(2,3,6);
imshow(res1);
title('Block detect V2');







