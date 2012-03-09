% testpath.m
% Set up environment for testing the Cantera Matlab interface
% from within the Cantera source tree. Run this file from the
% root of the Cantera source tree, e.g.:
%
%    cd ~/src/cantera
%    run interfaces/matlab/testpath.m

% get the list of directories on the Matlab path
dirs = regexp(path, ['([^' pathsep ']*)'], 'match');

% if 'cantera' is already in the path, remove it
for i = 1:length(dirs)
    if strfind(dirs{i}, 'Cantera')
        rmpath(dirs{i});
        continue;
    end
    if strfind(dirs{i}, 'cantera')
        rmpath(dirs{i});
    end
end

% Add the Cantera toolbox to the Matlab path
path(path, fullfile(pwd, 'toolbox'));
path(path, fullfile(pwd, 'toolbox', '1D'));

cantera_root = fullfile(pwd, '..', '..');

% Copy the Cantera shared library from the build directory if necessary
if strcmp(getenv('OS'), 'Windows_NT')
    copyfile(fullfile(cantera_root, 'build', 'lib', 'cantera_shared.dll'), ...
             fullfile(pwd, 'toolbox'))
end

% Set path to Python module
setenv('PYTHONPATH', fullfile(cantera_root, 'interfaces', 'python'))
setenv('CANTERA_DATA', fullfile(cantera_root, 'data', 'inputs'))

% A simple test to make sure that the ctmethods.mex file is present and working
f = Func('polynomial', 3, [1,2,3,4])