
%im = imread('test.tif');
im = Tiff('test.tif')
[RGB,A] = readRGBAImage(im);
size(RGB)
figure(1)
imshow(RGB)
%Get image height (pixels)
height = size(RGB, 1)

%Get image width (pixels)
width = size(RGB, 2)

% Get GSD (cm\pixel)
GSD = input('What is the GSD of this photo (cm/pix)?\n')

% Get spacing of gridlines
spacing = input('How many meters apart should the gridlines be?\n')

%Getting the number of pixels per meter for the image
pix_per_m = (100 / GSD)

%Get the number of pixels between each gridline
pix_per_line = pix_per_m * spacing


for index = 1:pix_per_line:height
  for addon = 0:20
    RGB(index + addon, :, 1) = 255;
    RGB(index + addon, :, 2) = 0;
    RGB(index + addon, :, 3) = 0;
  end
end

for index = 1:pix_per_line:width
  for addon = 0:20
    RGB(:, index + addon, 1) = 255;
    RGB(:, index + addon, 2) = 0;
    RGB(:, index + addon, 3) = 0;
  end
end

size(RGB)
figure(2)
imshow(RGB)
grid_image = Tiff('output_grid.tif', 'w');

tagstruct.ImageLength = size(RGB,1); 
tagstruct.ImageWidth = size(RGB,2);
tagstruct.Photometric = Tiff.Photometric.RGB;
tagstruct.BitsPerSample = 8;
tagstruct.SamplesPerPixel = 3;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky; 
tagstruct.Software = 'MATLAB';
setTag(grid_image,tagstruct)

write(grid_image, RGB);
close(grid_image)

