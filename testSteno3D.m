function success = testSteno3D(raiseError)
%TESTSTENO3D Test suite for steno3d

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

