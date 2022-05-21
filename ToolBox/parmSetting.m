
warning('off')
rng('shuffle');

% OpenGL
AssertOpenGL; 

% hide a cursor point
HideCursor;
ListenChar(2);
myKeyCheck;

%% participant's info
prompt = 'with apparent motion?[y/n] --->';
input = 'y';
% vision = input(prompt,'s')
if input == 'y' || strcmp(input,'yes')
    visionMode = true;
else
    visionMode = false;
end

today_date = datestr(now, 30);

%% set KeyInfo
cfg.key.KEY_ESCAPE = KbName('q');
cfg.key.KEY_SPACE  = KbName('space');
cfg.key.KEY_RETURN = KbName('a'); % for mac
cfg.key.KEY_LEFT   = KbName('LeftArrow');
cfg.key.KEY_RIGHT  = KbName('RightArrow');
cfg.key.KEY_DOWN   = KbName('DownArrow');

%% set screen
% set screen number
screens=Screen('Screens');
screenNumber=max(screens);
% screenNumber=1;

PsychDebugWindowConfiguration();
 
[win, rect] = Screen('OpenWindow',screenNumber, cfg.LUMINANCE_BACKGROUND);

[centerX, centerY] = RectCenter(rect);
