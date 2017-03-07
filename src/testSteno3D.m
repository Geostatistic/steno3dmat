function success = testSteno3D(raiseError)
%`testSteno3D` Test suite for steno3d
%   `success = testSteno3D()` returns true if all tests pass and false if
%   they fail.
%
%   `success = testSteno3D(true)` raises an error instead of returning
%   false if tests fail.
%
%   %%%seealso INSTALLSTENO3D, UPGRADESTENO3D
%


    if nargin < 1
        raiseError = false;
    end
    success = true;
    try
        steno3d.examples.testall
    catch ME
        success = false;
        if raiseError
            rethrow(ME);
        end
    end
end

