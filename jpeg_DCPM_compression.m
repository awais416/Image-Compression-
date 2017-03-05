% clear all;
close all;

clc;

img=imread('img.tif');                 % Read Image

img=imresize(img,[64,64]);

imshow(img);                            % Show Image
title('Original Image');

% Initialize Variables

dcode=[];
myimg=zeros(8,8);
dimg=zeros(8,8);
q=zeros(8,8);
I=eye(8);
[r,c]=size(img);
img1=zeros(r,c);

% Quality Matrix
for i=1:8
q(1:i,i)=2^(i-1);
q(i,1:i)=2^(i-1);
end

dimg=dct(I);                           % Discrete Cosine Transform of Identity Matri
idimg=dimg';                           % Transpose of DCT
% DCT + Quantization + Zigzag
for i=1:8:r
  for j=1:8:c
     cimg=double(img((i:i+7),(j:j+7)));  % Windowing
     cimg1=cimg*dimg;
     cimg2=cimg1*idimg;
     cimg3=cimg2./q;                        % Quantization
     img1((i:i+7),(j:j+7))=cimg3;

  end
end

zimg=(zigzag(img1)).';				% Zigzag Transformation

DPCM_code=DPCM(zimg);                           % DPCM = Diffrential Pulse Code Modulation

RLE_Code=num2str(RLEncoding(DPCM_code));        % Run Length Encoding

[H_Code,DIC]=Huffman_Coding (RLE_Code);         % Huffman Encoding

%------------ Decoding --------------%

% Huffman Decoding
H_Decode=huffmandeco(H_Code,DIC);           
H_Decode=cellfun(@num2str,H_Decode);

% RLE Decoding
RLE_Decode=RLDecoding(H_Decode);

% DPCM Decoding
DPCM_Decoded=DPCM_Decoding(RLE_Decode);

% Inverse Zigzag Transform
IZ_Code=izigzag(double(DPCM_Decoded),64,64);
IZ_Code=IZ_Code';
% Dequantization
DeQ_Code=zeros(r,c);

for i=1:8:r
  for j=1:8:c
      Q_win=IZ_Code((i:i+7),(j:j+7));       % Windowing + Dequantization
      Q_win1=Q_win.*q;  
      Q_win2=Q_win1*idimg;
      Q_win2=Q_win2*dimg;
      DeQ_Code((i:i+7),(j:j+7))=Q_win2;
  end
end

figure;
imshow(DeQ_Code,[]);
title('Decoded Image');

