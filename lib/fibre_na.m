% Calculates fibre NA and max acceptance angle
% from core and cladding refractive index
% Michael Hughes
% License: BSD [https://opensource.org/licenses/BSD-3-Clause]
% Usage: [nam maxAngle] = fibre_na(nCore,nCladding)

function [na, maxAngle] = fibre_na(nCore,nCladding)

    na = sqrt(nCore^2 - nCladding^2);
    maxAngle = asin(na) * 180 / pi;
 
end