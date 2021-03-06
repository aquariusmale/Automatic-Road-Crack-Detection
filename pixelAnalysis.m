function [ final_res ] = pixelAnalysis( final_im, sigma, t_im1, t_imeq, t_im2, verbose)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% Input:
% final_im -> image to be processed
% sigma -> Standard deviation of the Gaussian distribution
% t_im1 -> threshold to be applyied in the unprocessed image
% t_imeq -> threshold to be applyied in the equalized image
% t_im2 -> threshold to be applyied in the filtered image
% verbose -> set the verbose mode: verbose=1
 
equalizada=histeq(final_im);

% Version r2013
cutoff = ceil(3*sigma);
h = fspecial('gaussian', 2*cutoff+1, sigma);
smooth_im = imfilter(final_im,h,'replicate');

% % Imgaussfit only works in Matlab >r2013
% smooth_im = imgaussfilt(final_im, 1.5);

%0.5
bin_image1 = im2bw(final_im , t_im1);
%0.99
bin_image2 = im2bw(equalizada , t_imeq);
%0.2
bin_image3 = im2bw(smooth_im , t_im2);

if verbose
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

    subplot(3,3,7);
    imshow(bin_image1);
    title('Original binarizada');

    subplot(3,3,8);
    imshow(bin_image2);
    title('Equalizada binarizada');

    subplot(3,3,9);
    imshow(bin_image3);
    title('Original filtrada binarizada');
end

final_res = bin_image1;
end

