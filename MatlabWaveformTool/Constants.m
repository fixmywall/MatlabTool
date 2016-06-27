classdef Constants
    properties (Constant = true)
        MIN_AMPLITUDE_STEP = 10;
        INT_REQUIRED_ERROR = 'Please enter an integer value.';
        INVALID_NUMBER_ERROR = 'Please enter a valid number.';
        MIN_TIME_STEP_MS = 0.01;       %minimum step size for time (ms)
        MIN_TIME_STEP_US= 1;
        
        %Names of modes
        MODE_SANDBOX = 'Sandbox';
        MODE_FALCON = 'Falcon';
        MODE_NINJA_1 = 'Ninja-1';
        MODE_NINJA_2 = 'Ninja-2';
        MODE_WILSON_1 = 'Wilson-1';
        MODE_WILSON_2 = 'Wilson-2';
    end
end
