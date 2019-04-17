function [ varargout ] = impexp_stl( varargin )
%IMPEXP_STL Import/export geometry or grid in STL format.
%
%   [ GEOM ] = IMPEXP_STL( FILE_NAME, MODE, DATA, OPT )
%   Import and export of STL format CAD geometries (and export of
%   grids). Both 3D and planar 2D geometries are supported (planar STL
%   data will be converted to 2D geometry objects).
%
%   FILE_NAME can either be a string to specify the file name to
%   import or export to, or a cell array of strings specifying several
%   STL files where in 3D by default each file will be parsed into its
%   separate geometry object during import. STL import supports
%   multiple solid sections where in 2D each section will be assigned
%   a different subdomain, and in 3D each section will be parsed to a
%   separate boundary.
%
%   MODE is a string indicating either IMPORT or EXPORT. With the
%   IMPORT mode option the function returns a geometry struct
%   GEOM. FEATool fea finite element data struct, geometry struct, or
%   a grid struct.
%
%   OPT is a vector optional import flags and tolerance settings. The
%   first entry controls the tolerance for deduplication of points
%   (default 1e-3 relative tolerance). The following OPT entries only
%   apply to 3D import.
%
%   The second OPT entry controls tolerance for grouping of facets
%   into boundaries by comparing the difference between the normals
%   (default 1e-2 relative tolerance). Setting this to a large value
%   effectively disables 3D facet grouping and allows each STL section
%   to be imported and assigned as its own separate boundary.
%
%   The third OPT entry is an integer specifying the maximum number of
%   facets in groups for which to merge together to new boundaries
%   (default 1 only merging ungrouped facets).
%
%   The last OPT entry is a boolean specifying if STL solids imported
%   from different files should be merged to a single geometry object
%   (default false). Therefore OPT(2:3) = [0,0,true] will result in
%   all facets as a separate boundary, and [inf,inf,false] in each
%   STL solid section merged into its own boundary.

% Copyright 2013-2019 Precise Simulation, Ltd.

if( ~nargin && ~nargout ), help impexp_stl, return, end
varargout = cell( 1, nargout );
[varargout{:}] = featool( 'feval', 'impexp_stl', varargin{:} );
if( ~nargout ), clear varargout; end
