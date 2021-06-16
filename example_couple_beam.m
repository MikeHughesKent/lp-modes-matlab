% -------------------------------------------------------------------------
% example_couple_beam
% Fibre Optic LP Mode Solver and Simulator
% For Release 2 June 2020
% ------------------------------------------------------------------------
% Michael Hughes 
% Applied Optics Group, University of Kent
%
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% -------------------------------------------------------------------------
% Demonstrates simulation of coupling of a Gaussian beam into a 
% multimode fibre.
% -------------------------------------------------------------------------

clear
addpath('lib');

% Define the fibre characteristics and wavelength
nCore = 1.43;
nCladding = 1.425;
wavelength = 0.5;    % microns
coreRadius = 15;     % microns

% Define the plot area
maxPlotRadius = coreRadius * 2;  % Make this big for accurate coupling measurements
gridSize = 300;                  % pixels

% Find all the LP modes
[modes, nModes] = find_LP_modes(coreRadius, nCore, nCladding, wavelength);

% Report how many modes are found
fprintf('Estimating %d LP modes from V number. \n', round(est_num_modes(wavelength, coreRadius, nCore, nCladding) /2));
fprintf('Found %d LP modes (%d including rotations). \n', length(modes), nModes);

% Calculate the 2D field amplitudes of the LP modes
[modeSin, modeCos] = plot_all_LP_modes(modes, coreRadius, maxPlotRadius, gridSize);

% Generate a Gaussian beam 
beamRadius = 15;
pixelSize = (maxPlotRadius * 2) / gridSize;
inIntensity = fspecial('Gaussian', gridSize, beamRadius /2 / pixelSize) ;
inField = sqrt(inIntensity);

% Couple beam into fibre
[modeCouplingSin, modeCouplingCos, modeCouplingIntensity] = couple_beam(inField, modeSin, modeCos);

% To get the coupled power, just sum the power in each mode
coupledPower = sum(modeCouplingIntensity);
fprintf('Coupling efficiency (ignoring reflections) is %3.2f%% \n', coupledPower * 100);

% Display mode coupling
figure(1); plot(modeCouplingIntensity); title('Distribution of coupled power across modes'); xlabel('Mode No.'); ylabel('Fraction of power in mode');
figure(2); imagesc(inIntensity);

