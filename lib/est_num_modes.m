% Estimates number of modes supported by a fibre using V number
% nModes = est_num_modes(wavelength, coreRadius, nCore, nCladding)
% Michel Hughes
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% Usage: nModes = est_num_modes(wavelength, coreRadius, nCore, nCladding)

function nModes = est_num_modes(wavelength, coreRadius, nCore, nCladding)

    % Numerical Aperture
    NA = sqrt(nCore.^2 - nCladding.^2);
    
    % Fibre V Number
    V = 2 * pi / wavelength * coreRadius * NA;
    
    % Number of modes
    nModes = V^2/2;

end