% ------------------------------------------------------------------------
% amplitude_colour_map 
% ------------------------------------------------------------------------
% Returns a color map for amplitude images.
% ------------------------------------------------------------------------
% Mike Hughes   m.r.hughes@kent.ac.uk
% Applied Optics Group, University of Kent
% research.kent.ac.uk/applied-optics
% ------------------------------------------------------------------------
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% ------------------------------------------------------------------------

function map = amplitude_colour_map 
    map = interp1([0; .5; 1],[0, 0, 1; 1, 1, 1; 1, 0, 0],linspace(0,1,255));
end