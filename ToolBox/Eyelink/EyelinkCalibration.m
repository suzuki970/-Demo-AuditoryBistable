
%eyelink Calibration
fprintf('-------------------- Calibration start------------------\n');
% Calibrate the eye tracker
EyelinkDoTrackerSetup(el);

% do a final check of calibration using driftcorrection
EyelinkDoDriftCorrection(el);

fprintf('-------------------- Calibration end -------------------\n');

% start recording eye position
Eyelink('StartRecording');
% record a few samples before we actually start displaying
WaitSecs(0.1);

% mark zero-plot time in data file
Eyelink('Message', 'SYNCTIME');