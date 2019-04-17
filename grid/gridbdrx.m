function [ varargout ] = gridbdrx( varargin )
%GRIDBDRX Reconstruct interior boundaries.
%
%   [ GRID ] = GRIDBDR( GRID ) Reconstructs interior boundaries
%   and updates the GRID.B field.
%
%   See also GRIDBDR

% Copyright 2013-2019 Precise Simulation, Ltd.

if( ~nargin && ~nargout ), help gridbdrx, return, end
varargout = cell( 1, nargout );
[varargout{:}] = featool( 'feval', 'gridbdrx', varargin{:} );
if( ~nargout ), clear varargout; end
