% -------------------------------------------------------------------------
% example_propagate_beam
% Fibre Optic LP Mode Solver and Simulator
% For Release 2 June 2020
% ------------------------------------------------------------------------
% Michael Hughes   m.r.hughes@kent.ac.uk
% Applied Optics Group, University of Kent
%
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% -------------------------------------------------------------------------
% Demonstrates coupling a field into a fibre and propagating field along
% fibre.
% -------------------------------------------------------------------------

clear
addpath('lib');

% Define the fibre characteristics and wavelength
nCore = 1.435;
nCladding = 1.42;
wavelength = 0.5;    % microns
coreRadius = 15;     % microns

% Define the plot area
maxPlotRadius = coreRadius * 1.2;  % Make this big for accurate coupling measurements
gridSize = 200;                    % pixels

% Find all the LP modes
[modes, nModes] = find_LP_modes(coreRadius, nCore, nCladding, wavelength);

% Report how many modes are found
fprintf('Estimating %d LP modes from V number. \n', round(est_num_modes(wavelength, coreRadius, nCore, nCladding) /2));
fprintf('Found %d LP modes (%d including rotations). \n', length(modes), nModes);

% Calculate the 2D field amplitudes of the LP modes
[modeSin, modeCos] = plot_all_LP_modes(modes, coreRadius, maxPlotRadius, gridSize);

% Load image to ue as field
im = imread('files\aog.png');
inField = 1 - double(im(:,:,1))/255;
inField = imresize(inField, [gridSize, gridSize]);

% Couple field into fibre
[modeCouplingSin, modeCouplingCos, modeCouplingIntensity] = couple_beam(inField, modeSin, modeCos);

% Display field propagated to various distances
distances = [0,1,2,3,4,5,10,20,50,100,200,500,1000,2000,5000,10000];
for ii =  1 : length(distances)
   
    [endField, endIntensity, endModeCouplingSin, endModeCouplingCos] = propagate_through_fibre(modeSin, modeCos, modeCouplingSin, modeCouplingCos, [modes.beta], 1, distances(ii));

    % Intensity Plot
    figure(1); subplot(4,4,ii); imagesc(endIntensity); colormap('gray'); title([num2str(round(distances(ii))),' microns']); axis off;
    
    % Amplitude Plot
    zLim = max(abs(endField(:)));
    figure(2); subplot(4,4,ii); imagesc(abs(endField),[-zLim, zLim]); colormap(amplitude_colour_map); title([num2str(round(distances(ii))),' microns']); axis off;

end


