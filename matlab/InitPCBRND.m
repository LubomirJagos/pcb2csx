function PCBRND = InitPCBRND(layers, layer_types, void, base_priority, offset, kludge)
%
% Initializes the basics to add a pcb layout into openems
%
% layer types defines the names of the matterials used for the layers. 
% this must follow the same order as the layer definitions in layers described above.
%
% Copyright (C) 2017 Evan Foss
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>
%


layers(1).ztop = offset.z;

% how to seperate the matterials
prio.substrate = base_priority;
prio.copperplane = prio.substrate + 1;
prio.clearance = prio.copperplane + 1;
prio.coppertrace = prio.clearance + 1;
prio.void = prio.coppertrace + 1;
%if (mask = 1 or silk = 1)
%   prio.mask = prio.void;
%   prio.void = mask_prio + 1;
%   prio.silk = mask_prio;
%end

PCBRND.void.priority = prio.void;

for counter=1:size(layers,2)
   if (counter > 1)
      layers(counter).ztop = layers(counter - 1).zbottom;
   end
   % the only 2d material is a conductive sheet
   if (2 == layer_types(layers(counter).number).subtype)
      layers(counter).zbottom = layers(counter).ztop;
      layers(counter).priority = prio.copperplane;
   elseif (3 == layer_types(layers(counter).number).subtype)
      % insulators and conductors can be 3D but only insulators have epsilon
      if ( isfield(layer_types(counter), 'epsilon') )
         layers(counter).zbottom = layers(counter).ztop - layer_types(layers(counter).number).thickness;
	 layers(counter).priority = prio.substrate;
      else
         layers(counter).zbottom = layers(counter).ztop - layer_types(layers(counter).number).thickness;
         layers(counter).priority = prio.copperplane;
      end
   else
      disp('not yet implimented!');
      layers(counter).zbottom = layers(counter).ztop - layer_types(layers(counter).number).thickness;
   end
end

board_thickness = layers(size(layers,2)).ztop - layers(1).zbottom;
for counter=1:size(layers,2)
   layers(counter).ztop = layers(counter).ztop - board_thickness;
   layers(counter).zbottom = layers(counter).zbottom - board_thickness;
end

PCBRND.kludge.segments = kludge.segments;

PCBRND.layers = layers;
PCBRND.layer_types = layer_types;
PCBRND.void = void;
PCBRND.offset = offset;
PCBRND.prio = prio;

endfunction
