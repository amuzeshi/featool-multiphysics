function [ varargout ] = gridextrude( varargin )
%GRIDEXTRUDE Extrude 2D grid to 3D.
%
%   [ GRID ] = GRIDEXTRUDE( GRID, NZ, LZ, AX ) Extrudes a 2D GRID to 3D.
%   NZ is the number of cells in the direction of extrusion, and LZ the
%   corresponding extrusion length. AX [-3..3] optionally rotates and
%   aligns the extruded grid with the selected axis (default 3 which is
%   the z-axis).
%
%   Gridextrude supports both extruding 2D quadrilateral grids to 3D
%   hexahedra, and unstructured simplex triangular grids to tetrahedra
%   (via first extruding to prisms and then splitting each prism into
%   three tetrahedra).
%
%   Examples:
%
%      1) Extrude a ring to form a tube:
%
%      grid = ringgrid( 2, 16 );
%      grid = gridextrude( grid, 10, 5, 3 );
%
%      2) Extrude a composite grid by a length of 3
%         (in the positive x-direction, AX=1).
%
%      grid = holegrid( 6, 5 );
%      grid = delcells( grid, '((x>0).*(y>0))==0' );
%      grid = gridextrude( grid, 12, 3, 1 )
%
%      3) Generate unstructured circuit board grid.
%
%      ro = 0.003;   % Outer circle diameter.
%      ri = ro/2;    % Inner circle diameter.
%
%      % Circle 1.
%      co1 = gobj_circle( [0.01,0.01], ro, 'CO1' );
%      ci1 = gobj_circle( [0.01,0.01], ri, 'CI1' );
%
%      % Circle 2.
%      co2 = gobj_circle( [0.05,0.02], ro, 'CO2' );
%      ci2 = gobj_circle( [0.05,0.02], ri, 'CI2' );
%
%      % Remove inner holes from circles.
%      geom.objects = { co1 ci1 co2 ci2 };
%      geom = geom_apply_formula( geom, 'CO1-CI1' );
%      geom = geom_apply_formula( geom, 'CO2-CI2' );
%
%      % Base rectangle.
%      r1 = gobj_rectangle( 0, 0.06, 0, 0.03, 'R1' );
%
%      % Remove (outer) circles from base rectangle.
%      geom.objects = [ geom.objects { r1 co1 co2 } ];
%      geom = geom_apply_formula( geom, 'R1-CO1-CO2' );
%
%      % Polygon for connecting conductive track.
%      w = 0.002/2;
%      p = [ 0.01   0.02-w/2 0.03-w/2 0.05   0.05   0.03+w/2 0.02+w/2 0.01   ;
%            0.01+w 0.01+w   0.02+w   0.02+w 0.02-w 0.02-w   0.01-w   0.01-w ];
%      p1 = gobj_polygon( p', 'P1' );
%
%      % Remove outer circles from conductive track.
%      geom.objects = [ geom.objects { p1 co1 co2 } ];
%      geom = geom_apply_formula( geom, 'P1-CO1-CO2' );
%
%      % 2D grid generation.
%      hmax = (ro-ri)/2;
%      grid = gridgen( geom, 'hmax', hmax );
%
%      % Extrude grid.
%      grid = gridextrude( grid, 2, 0.002 );
%
%   See also GRIDMERGE, GRIDREVOLVE, GRIDROTATE, GRIDSCALE

% Copyright 2013-2019 Precise Simulation, Ltd.

if( ~nargin && ~nargout ), help gridextrude, return, end
varargout = cell( 1, nargout );
[varargout{:}] = featool( 'feval', 'gridextrude', varargin{:} );
if( ~nargout ), clear varargout; end
