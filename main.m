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

addpath(genpath('./ToolBox'));

%% ------------------ paradigm settings ------------------
cfg = [];
cfg.TIME_ISI = 0.08;             % between pure tone [s]
cfg.TIME_FIXATION = 2;           % fixation period[s]

cfg.playTime = 20;              % sound presentation [s]
cfg.FRAME_RATE = 60;        

cfg.VISUAL_DISTANCE = 60;        % visual distance from a monitor to the eyes [cm]
cfg.NUM_TRIAL = 1;
cfg.LUMINANCE_BACKGROUND = 140;  % [RGB]
cfg.DOT_PITCH = 0.271;           % Flexscan S2133 (21.3 inch, 1600 x 1200 pixels size)

cfg.STIM_SIZE = 3;               % visual stimulus size [deg]
cfg.STIM_LOCS = 7;               % visual stimulus location from the center [deg]


%% ------------------ initilize  ------------------
parmSetting();

%% ------------------ screen setting  ------------------
% set empty screen
empty = Screen('OpenOffscreenWindow',screenNumber,cfg.LUMINANCE_BACKGROUND, [],[],32);

% fixation
fixlength = pixel_size(cfg.DOT_PITCH, 0.1, cfg.VISUAL_DISTANCE);
FixationXY = [centerX-1*fixlength, centerX+fixlength, centerX, centerX; centerY, centerY, centerY-1*fixlength, centerY+fixlength];
FixColor = [0 0 0];
fix = Screen('OpenOffscreenWindow',screenNumber, cfg.LUMINANCE_BACKGROUND,[],[],32);
Screen('DrawLines', fix, FixationXY,2, FixColor);

Screen('BlendFunction', win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


%% ------------------ auditory stim setting  ------------------

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


%% ------------------ load auditory and visual stimulus files ------------------
folderList = dir('./stim/*.wav');
for i = 1:size(folderList,1)
    [stim_sound{i,1},cfg.AUDIO_SAMPLING_RATE] = audioread([folderList(i).folder '/' folderList(i).name]);
    stim_sound{i,1} = repmat(stim_sound{i,1},1,2)';
end
stim_sound{3,1} = zeros(2,length(stim_sound{1,1}));

cfg.condition_frame = [1 2 1 3];
cfg.condition_frame = repmat(cfg.condition_frame,1,500);

[I,map,transparency] = imread('stim/symb.png');

% imshow(I);
% imshow(transparency);

I(:,:,4) = transparency;

[iy, ix, id] = size(I);
ratio = iy/ix;

imagetex = Screen('MakeTexture', win, I);

%% ------------------ Open audio device for low-latency output ------------------
% PsychPortAudio('GetDevices')
pahandle = PsychPortAudio('Open', [], [], reqlatencyclass, freq, 2, buffersize, suggestedLatencySecs);

%% ------------------ Start experiment ------------------
fprintf('********* Start **********\n')
ShowMessage();

%% ------------------ fixation ------------------
Fixation();

%% ------------------ presentation ------------------
Presentation();

%%
fprintf('********* Finish **********\n')

sca;
ListenChar(0);
