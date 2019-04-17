function [ c_paths ] = addpaths( i_add )
%ADDPATHS Add/remove app directories to/from working paths.
%
% [ C_PATHS ] = ADDPATHS( I_ADD ) Adds/removes app directories to/from
% working paths. The I_ADD (default true) indicates adding paths, and
% 0/false for removing paths. Optionally, returns a cell array with the
% added/removed paths in C_PATHS where the first column consists of
% all paths relative to the root app/mfile directory, and the second
% with corresponding absolute paths.

% Copyright 2013-2019 Precise Simulation, Ltd.

fcn = @addpath;
if( nargin && ~i_add )
  fcn = @rmpath;
end

s_mfiledir = fileparts( which([mfilename('fullpath'),'.m']) );
s_paths = genpath( s_mfiledir );

fcn( s_paths );

if( nargout )
  c_paths = regexp( strtrim(s_paths), ';+', 'split' );
  c_paths(cellfun(@isempty,c_paths)) = [];
  c_paths = [ regexprep(strrep(c_paths(:),s_mfiledir,''),['^',filesep()],''), c_paths(:) ];
end
