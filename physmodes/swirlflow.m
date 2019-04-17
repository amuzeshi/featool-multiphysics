function [ varargout ] = swirlflow( varargin )
%NAVIERSTOKES Navier-Stokes equations physics mode.

% Copyright 2013-2019 Precise Simulation, Ltd.

if( ~nargin && ~nargout ), help swirlflow, return, end
varargout = cell( 1, nargout );
[varargout{:}] = featool( 'feval', 'swirlflow', varargin{:} );
if( ~nargout ), clear varargout; end
