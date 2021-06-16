% ------------------------------------------------------------------------
% plot_LP_mode
% ------------------------------------------------------------------------
% Michael Hughes    m.r.hughes@kent.ac.uk
% Applied Optics Group, University of Kent
%
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% ------------------------------------------------------------------------
% Plots a normalised fibre LP mode (sin and cos version).
% 
% Usage:
%     [profile, intProfile, radVector] = plot_LP_mode_profile(order, u, w, ...
%                                     coreRadius, maxPlotRadius, gridSize)
%
% Parameters:
%   order          : mode order
%   u              : mode core u term (microns)
%   w              : mode core w term (microns)
%   coreRadius     : radius of the core (microns)
%   maxPlotRadius  : radius at edge of grid (i.e. grid is 2x this)
%   gridSize       : number of pixels in grid
%
% Returns:
%   profile        : 1D radial profile of field amplitude
%   intProfile     : 1D radial profile of field intensity
%   radVector      : 1D vector of radial positions (microns) corresponding 
%                    to profile vector(s)
% ------------------------------------------------------------------------
function [profile, intProfile, radVector] = plot_LP_mode_profile(order, u, w, coreRadius, maxPlotRadius, gridSize)
    
    % Calculate the core and cladding profiles
    radVector = linspace(0,maxPlotRadius, gridSize/2);
    coreProfile = besselj(order,u ./ coreRadius .* radVector)/besselj(order,u);
    claddingProfile = besselk(order, w ./ coreRadius .* radVector)/besselk(order,w);
    
    % Work out which grid points are in core and which in cladding
    inCore = (radVector <= coreRadius) & (radVector <= maxPlotRadius);
    inCladding = (radVector > coreRadius) & (radVector <= maxPlotRadius);
    profile(inCore) = coreProfile(inCore);
    profile(inCladding) = claddingProfile(inCladding);
    
    % Normalise
    profile = profile /max(abs(profile));
    
    %Intensity profile is square of amplitude
    intProfile = profile.^2;
    
end