%%%%%%%%%% description %%%%%%%%%%%%%%
% Created on Mon Apr 4 2022
% Place : Japan,
% Author : Yuta Suzuki

% Eye-tracker     : 
% Display         : 
% Visual distance :

% Copyright (c) 2022 Yuta Suzuki
% This software is released under the MIT License, see LICENSE.

%% -----------------------------------

clear all;
close all;
Screen('Close')
Screen('Preference', 'SkipSyncTests', 1);
rng('shuffle');

addpath(genpath('./ToolBox'));

% OpenGL
AssertOpenGL;

% participant's info
% prompt = 'Demo? (yes:1 / no:2) --> ';
% demoMode =input(prompt);
%
% prompt = 'Name? ----> ';
% participantsInfo.name = input(prompt,'s');
% prompt = 'Age? ----> ';
% participantsInfo.age = input(prompt,'s');

today_date = datestr(now, 30);

% hide a cursor point
HideCursor;
ListenChar(2);
myKeyCheck;

%% --------------------paradigm settings------------------
cfg = [];
cfg.TIME_ISI = 0.08;                % ISI[s]
cfg.TIME_FIXATION = 2;           % fixation period[s]

cfg.playTime = 170;              % sound presentation [s]
cfg.FRAME_RATE = 60;        

cfg.VISUAL_DISTANCE = 60;        % visual distance from a monitor to the eyes [cm]
cfg.NUM_TRIAL = 1;
cfg.LUMINANCE_BACKGROUND = 140;  % [RGB]
cfg.DOT_PITCH = 0.271;           % Flexscan S2133 (21.3 inch, 1600 x 1200 pixels size)

%% -------------------------------------------------------------
% set KeyInfo
parmSetting();
cfg.key.KEY_LEFT  = KbName('LeftArrow');
cfg.key.KEY_RIGHT = KbName('RightArrow');
cfg.key.KEY_DOWN  = KbName('DownArrow');

% set empty screen
empty = Screen('OpenOffscreenWindow',screenNumber,cfg.LUMINANCE_BACKGROUND, [],[],32);

% fixation
fixlength = pixel_size(cfg.DOT_PITCH, 0.1, cfg.VISUAL_DISTANCE);
FixationXY = [centerX-1*fixlength, centerX+fixlength, centerX, centerX; centerY, centerY, centerY-1*fixlength, centerY+fixlength];
FixColor = [0 0 0];
fix = Screen('OpenOffscreenWindow',screenNumber, cfg.LUMINANCE_BACKGROUND,[],[],32);
Screen('DrawLines', fix, FixationXY,2, FixColor);

% refresh rate of screen
Screen('BlendFunction', win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

%% -------------------------------------

InitializePsychSound(1);

% Force GetSecs and WaitSecs into memory to avoid latency later on:
GetSecs;
WaitSecs(0.1);

reqlatencyclass = 2;
useDPixx = 0;

freq = 44100;       % Must set this. 96khz, 48khz, 44.1khz.
buffersize = 0;     % Pointless to set this. Auto-selected to be optimal.
suggestedLatencySecs = [];
% ifi = Screen('GetFlipInterval', win);
waitframes = 5.1875;
PsychPortAudio('Close');



%% show some messages before start
% ShowMessage();
folderList = dir('./stim/*.wav');
for i = 1:size(folderList,1)
    [stim_sound{i,1},cfg.AUDIO_SAMPLING_RATE] = audioread([folderList(i).folder '/' folderList(i).name]);
    stim_sound{i,1} = repmat(stim_sound{i,1},1,2)';
end
stim_sound{3,1} = zeros(2,length(stim_sound{1,1}));

cfg.condition_frame = [1 2 1 3];
cfg.condition_frame = repmat(cfg.condition_frame,1,200);

if useEyelink
    Eyelink('Message', 'Start_Experiment');
end

%% Open audio device for low-latency output:
% PsychPortAudio('GetDevices')
% pahandle = PsychPortAudio('Open', 40, [], reqlatencyclass, freq, 2, buffersize, suggestedLatencySecs);
pahandle = PsychPortAudio('Open', [], [], reqlatencyclass, freq, 2, buffersize, suggestedLatencySecs);

%% Start experiment
fprintf('********* Start **********\n')

for iTrial = 1:1
   
    ShowMessage();
    if useEyelink
        EyelinkDoDriftCorrection(el);
        Eyelink('StartRecording');
        WaitSecs(0.1);
    end
    
    %% fixation
    Fixation();
    
    %% presentation
    Presentation();
end

if useEyelink
    Eyelink('Message', 'End_Experiment');
end

fprintf('********* Finish **********\n')

sca;
ListenChar(0);

% save_name = ['/bistableSync_',cfg.participantsInfo.name,'_',today_date];
% saveFiles();