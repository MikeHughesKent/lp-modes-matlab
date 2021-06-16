% ------------------------------------------------------------------------
% tilted_field
% ------------------------------------------------------------------------
% Michael Hughes    m.r.hughes@kent.ac.uk
% Applied Optics Group, University of Kent
%
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% ------------------------------------------------------------------------
% Produces an E-field with wavefront tilt.
%
% Usage
%
% field = tilted_field(fieldSize, gridSize, wavelength, tilt)
% 
% Parameters:
%
%   fieldSize : physical size of field in UNITS
%    gridSize : number of pixels to represent field (x and y)
%  wavelength : wavelength of light in UNITS
%        tilt : angle in radians

function field = tilted_field(fieldSize, gridSize, wavelength, tilt)

    pixelSize = fieldSize/gridSize;
    
    phaseIncrement = 2 * pi * pixelSize * tan(tilt) / wavelength;
  
    [xM, ~] = meshgrid(1:gridSize,1:gridSize);

    phaseMap = xM * phaseIncrement;

    field = exp(1i * phaseMap);

end








