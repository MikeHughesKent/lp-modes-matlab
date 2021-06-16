% ------------------------------------------------------------------------
% propagate_through_fibre
% ------------------------------------------------------------------------
% Michael Hughes   m.r.hughes@kent.ac.uk
% Applied Optics Group, University of Kent
%
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% ------------------------------------------------------------------------
% Takes a set of fibre modes with the input fields coupled into each mode
% and randomises the phase of each mode and (if rotations = 1) randomly
% changes the rotation of each mode (adjusting the weights of the sin
% and cos terms). This simulates propagation along a fibre of sufficient
% length to essentially randomise phases.
%
% Parameters:
%         modeSin = 3D array plotting amplitude of each mode (sin rotation)
%                   [x,y,mode]
%         modeCos = 3D array plotting amplitude of each mode (cos rotation)
%                   [x,y,mode]
%           modeB = vector of propagation constants for each mode
%                   (1/microns)
% modeCouplingCos = the field amplitude/phase coupled into each mode (sin rotation) [1D
%                   array]
% modeCouplingSin = the field amplitude/phase coupled into each mode (cos rotation) [1D
%                   array]
%       rotations = if 1, each mode is randomly rotated by redistributing power
%                   between sin and cos.
%        distance = length of fibre (microns)
%
% Returns:
%           endField = complex field coming out of fibre
%       endIntensity = intensity field coming out of fibre
% endModeCouplingSin = amplitude and phase of each mode (sin rotation)
%                      coming out of fibre.
% endModeCouplingCos = amplitude and phase of each mode (cos rotation)
%                      coming out of fibre.

function [endField, endIntensity, endModeCouplingSin, endModeCouplingCos] = propagate_through_fibre(modeSin, modeCos, modeCouplingSin, modeCouplingCos, modeB, rotations, distance)

   nModes = length(modeCouplingSin);
   endField = zeros(size(modeSin,1), size(modeSin,2));
   
   endModeCouplingSin = zeros(nModes,1);
   endModeCouplingCos = endModeCouplingSin;
   for iMode = 1:nModes
       
        % If we are allowing free rotations, randomly shift the coupling
        % between the sin and cos versions
        if rotations && modeCouplingCos(iMode) > 0 % Also check there is a non-zero cos term for this mode
            weight = rand;
            totalPower = modeCouplingSin(iMode)^2 + modeCouplingCos(iMode)^2;
            powerCos = weight * totalPower;
            powerSin = (1-weight) * totalPower;
            endModeCouplingSin(iMode) = sqrt(powerSin) * sign(modeCouplingSin(iMode));
            endModeCouplingCos(iMode) = sqrt(powerCos) * sign(modeCouplingCos(iMode));
        else
            endModeCouplingSin(iMode) = modeCouplingSin(iMode);
            endModeCouplingCos(iMode) = modeCouplingCos(iMode);
        end

        % Add a random phase to each mode
        endModeCouplingSin(iMode) = endModeCouplingSin(iMode) * exp(1i * modeB(iMode) * distance * 2 * pi);
        endModeCouplingCos(iMode) = endModeCouplingCos(iMode) * exp(1i * modeB(iMode) * distance * 2 * pi);
        %a = rand * 2 * pi;
        %endModeCouplingSin(iMode) = endModeCouplingSin(iMode) * exp(1i * a);
        %endModeCouplingSin(iMode) = endModeCouplingSin(iMode) * exp(1i * a);
        
        % Calculate the coherent sum of modes to give field at end of fibre
        endField = endField + endModeCouplingSin(iMode) * squeeze(modeSin(:,:,iMode)) + endModeCouplingCos(iMode) * squeeze(modeCos(:,:,iMode));
   end
   
   % Intensity is square of field
   endIntensity = abs(endField).^2;
   
end       