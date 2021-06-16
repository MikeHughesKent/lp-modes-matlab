% -------------------------------------------------------------------------
% example_coupling_angle
% Fibre Optic LP Mode Solver and Simulator
% For Release 2 June 2020
% ------------------------------------------------------------------------
% Michael Hughes   m.r.hughes@kent.ac.uk
% Applied Optics Group, University of Kent
%
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% -------------------------------------------------------------------------
% Demonstrates using fibre LP modes to shown how coupling depends
% on angle of incidence of a planar wave.
% ------------------------------------------------------------------------

clear
addpath('lib');

% Define the fibre characteristics and wavelength
nCore = 1.435;
nCladding = 1.415;
wavelength = 0.5;
coreRadius = 20;

% These are the input angles we will test
tilt = 0:1:30; %degrees

% Calculate the maximam acceptance angle predicted by geometrical optics
[na,maxAcceptAngle] = fibre_na(nCore, nCladding);

% Approximate the number of modes we should expect to find (not very
% accurate for few-mode fibres)
estModes = est_num_modes(wavelength, coreRadius, nCore, nCladding);

% Define the plot area
maxPlotRadius = coreRadius * 2.5;  % Needs to be big for proper normalisation
gridSize = 200;

% Find all the LP modes
[modes, nModesRots] = find_LP_modes(coreRadius, nCore, nCladding, wavelength);
nModes = length(modes);  % Doesn't include rotations

% Report how many modes are found
fprintf('Estimating %d LP modes from V number. \n', round(est_num_modes(wavelength, coreRadius, nCore, nCladding) /2));
fprintf('Found %d LP modes (%d including rotations). \n', length(modes), nModesRots);

% Calculate the 2D field amplitudes of the LP modes
[modeSin, modeCos] = plot_all_LP_modes(modes, coreRadius, maxPlotRadius, gridSize);

% Generate the pattern at the far end of a fibre for a set of plane waves 
% coming in at different angles
endIntensities = zeros(gridSize, gridSize, length(tilt));
coupledPower = zeros(length(tilt),1);
for ii = 1 : length(tilt)
       
    % Generate beam with required tilt
    tiltRad = tilt(ii) * pi / 180;
    inField = tilted_field(maxPlotRadius * 2, gridSize, wavelength, tiltRad);

    % Determine the coupling into each fibre mode
    [modeCouplingSin, modeCouplingCos, modeCouplingIntensity] = couple_beam(inField, modeSin, modeCos);
    coupledPower(ii) = sum(modeCouplingIntensity);

end

% Calculate and display the total power coupled as a function of angle
coupledPower = coupledPower ./ max(coupledPower);
figure(5);plot(tilt, coupledPower);  title ('Power coupled against angle'); xlabel('Angle, degrees'); ylabel('Relative coupled power');
hold on; plot([1 1]*maxAcceptAngle, ylim, '--k')  ; hold off

