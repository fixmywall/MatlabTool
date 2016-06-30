classdef Constants
    properties (Constant = true)
        MIN_AMPLITUDE_STEP = 10;
        ERROR_TOO_MANY_PHASES = 'Number of phases exceeds limit';
        INT_REQUIRED_ERROR = 'Please enter an integer value.';
        INVALID_NUMBER_ERROR = 'Please enter a valid number.';
        MIN_TIME_STEP_US= 1;
        
        %Electrode polarity
        MAX_ELECTRODE_PERCENT = 100;
        MIN_ELECTRODE_PERCENT = -100;
        ELECTRODE_STEP = 1;             %step when 
        
        %Names of modes
        MODE_SANDBOX = 'Sandbox';
        MODE_FALCON = 'Falcon';
        MODE_NINJA_1 = 'Ninja-1';
        MODE_NINJA_2 = 'Ninja-2';
        MODE_WILSON_1 = 'Wilson-1';
        MODE_WILSON_2 = 'Wilson-2';
        
        %falcon defaults
        FALCON_DEFAULT_AMP = [12,22];
        FALCON_DEFAULT_WIDTH = [900,700];
    end
end
