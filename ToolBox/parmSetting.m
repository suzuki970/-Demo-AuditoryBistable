% warning('off')
% rng('shuffle');

% OpenGL
% AssertOpenGL;

%%participant's info
prompt = 'Demo.?[y/n] --->';
% demo = input(prompt,'s');
demo = 'y';
if demo == 'y' || strcmp(demo,'yes')
    demoMode = true;
else
    demoMode = false;
end

% 
% prompt = 'Name?';
% cfg.participantsInfo.name = input(prompt,'s');
% while 1
%     if isempty(cfg.participantsInfo.name)
%         prompt = 'Name is null. try again --> ';
%         cfg.participantsInfo.name = input(prompt,'s');
%     else
%         break;
%     end
% end
% 
% prompt = 'No.?\n[t]:Training\n[0]:Behavior(continuous)\n[1A/2A]:Large BP\n[1B/2B]:Small BP\n[B]:Eye blinks\n----> ';
% cfg.participantsInfo.no = input(prompt,'s');
% sessionName = ["t","0","1A","2A","1B","2B","B"];
% 
% while 1
%     if max(strcmp(cfg.participantsInfo.no,sessionName)) == 1
%         break;
%     else
%         prompt = 'No. is null. try again -- > ';
%         cfg.participantsInfo.no = input(prompt,'s');
%     end
% end
% 
% prompt = 'Session? --> ';
% cfg.participantsInfo.session = input(prompt);
% while 1
%     if isempty(cfg.participantsInfo.session)
%         prompt = 'No. is null. try again -- > ';
%         cfg.participantsInfo.session = input(prompt);
%     else
%         break;
%     end
% end

today_date = datestr(now, 30);

% hide a cursor point
% HideCursor;
% ListenChar(2);
% myKeyCheck;

if demoMode
    useEyelink = false;     % eyelink
else
    useEyelink = true;     % eyelink
end

% set KeyInfo
escapeKey = KbName('q');
spaceKey = KbName('space');
% returnKey = KbName('return');
returnKey = KbName('a'); % for mac

% set screen number
screens=Screen('Screens');
screenNumber=max(screens);
screenNumber=1;

[win, rect] = Screen('OpenWindow',screenNumber, cfg.LUMINANCE_BACKGROUND);

[centerX, centerY] = RectCenter(rect);

%% eyelink on/off: 1 or 2
% if useEyelink
%     eyelinkSetup();
%     edfFile = [cfg.participantsInfo.name '.edf']; % open file to record data to
%     status = Eyelink('Openfile', edfFile);
%     if status ~= 0
%         Screen('CloseAll');
%         Screen('ClearAll');
%         ListenChar(0);
%         sca;
%         return
%     end
%     EyelinkCalibration();
%     Initialization();
% end