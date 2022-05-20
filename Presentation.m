
PsychPortAudio('DeleteBuffer');
if useEyelink
    Eyelink('Message', 'Start_Pesentation');
    Eyelink('Message', ['Condition:' folderList(cfg.condition_frame(iTrial)).name]);
end

rate = 1;

flag_button = [];
flag_button.left = false;
flag_button.right = false;
flag_button.down = false;

% moviename = [folderList(cfg.condition_frame(iTrial)).folder '\' folderList(cfg.condition_frame(iTrial)).name];
% [movie movieduration fps imgw imgh] = Screen('OpenMovie', win, moviename);
% Screen('PlayMovie', movie, rate, 1, 1.0);

count = 1;

cfg.RT = [];
cfg.response = {};

tic
taskStart = tic;
FLAG_QUEUE = true;
while toc < cfg.playTime
    tex = Screen('GetMovieImage', win, movie);
    
    % Valid texture returned? A negative value means end of movie reached:
    if tex<=0 % We're done, break out of loop:
        break;
    end
    
    Screen('DrawTexture', win, tex); % Draw the new texture immediately to screen:
    Screen('Flip', win);  % Update display:
    Screen('Close', tex); % Release texture:
    
    clear keyCode;
    [keyIsDown,secs,keyCode]=KbCheck;
    % interrupt by ESC
    if (keyCode(escapeKey))
        Screen('CloseAll');
        Screen('ClearAll');
        ListenChar(0);
        sca;
        return
    end
    
    %%
    if (keyCode(KEY_LEFT)) && (~keyCode(KEY_RIGHT)) && (~keyCode(KEY_DOWN))
        if flag_button.right
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Splitted_end'];
            flag_button.right = false;
            if useEyelink
                Eyelink('Message', 'Splitted_end');
            end
            fprintf('********* Splitted_end **********\n\n')
        end
        if flag_button.down
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Async_end'];
            flag_button.down = false;
            if useEyelink
                Eyelink('Message', 'Async_end');
            end
            fprintf('********* Async_end **********\n\n')
        end
        if ~flag_button.left
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Grouped_start'];
            if useEyelink
                Eyelink('Message', 'Grouped');
            end
            fprintf('********* Grouped_start **********\n\n')
        end
        
        flag_button.left = true;
    end
    %%
    if (keyCode(KEY_RIGHT)) && (~keyCode(KEY_LEFT)) && (~keyCode(KEY_DOWN))
        if flag_button.left
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Grouped_end'];
            flag_button.left = false;
            if useEyelink
                Eyelink('Message', 'Grouped_end');
            end
            fprintf('********* Grouped_end **********\n\n')
        end
        if flag_button.down
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Async_end'];
            flag_button.down = false;
            if useEyelink
                Eyelink('Message', 'Async_end');
            end
            fprintf('********* Async_end **********\n\n')
        end
        if ~flag_button.right
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Splitted_start'];
            if useEyelink
                Eyelink('Message', 'Splitted_start');
            end
            fprintf('********* Splitted_start **********\n\n')
        end
        
        flag_button.right = true;
    end
    %%
    if (keyCode(KEY_DOWN)) && (~keyCode(KEY_LEFT)) && (~keyCode(KEY_RIGHT))
        if flag_button.left
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Grouped_end'];
            flag_button.left = false;
            if useEyelink
                Eyelink('Message', 'Grouped_end');
            end
            fprintf('********* Grouped_end **********\n\n')
        end
        if flag_button.right
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Splitted_end'];
            flag_button.right = false;
            if useEyelink
                Eyelink('Message', 'Splitted_end');
            end
            fprintf('********* Splitted_end **********\n\n')
        end
        if ~flag_button.down
            cfg.RT = [cfg.RT;toc];
            cfg.response = [cfg.response;'Async_start'];
            if useEyelink
                Eyelink('Message', 'Async_start');
            end
            fprintf('********* Async_start **********\n\n')
        end
        flag_button.down = true;
    end
    
    %%
    if useEyelink
        getDataEyelink();
    end
end

if flag_button.left
    cfg.RT = [cfg.RT;toc];
    cfg.response = [cfg.response;'Grouped_end'];
    flag_button.left = false;
    if useEyelink
        Eyelink('Message', 'Grouped_end');
    end
    fprintf('********* Grouped_end **********\n')
end

if flag_button.right
    cfg.RT = [cfg.RT;toc];
    cfg.response = [cfg.response;'Splitted_end'];
    flag_button.right = false;
    if useEyelink
        Eyelink('Message', 'Splitted_end');
    end
    fprintf('********* Splitted_end **********\n')
end

if flag_button.down
    cfg.RT = [cfg.RT;toc];
    cfg.response = [cfg.response;'Async_end'];
    flag_button.down = false;
    if useEyelink
        Eyelink('Message', 'Async_end');
    end
    fprintf('********* Async_end **********\n')
end

% Stop playback:
Screen('PlayMovie', movie, 0);

% Close movie:
Screen('CloseMovie', movie);

Screen('CopyWindow',fix,win);
Screen('Flip', win,0,1);

if useEyelink
    Eyelink('Message', 'End_Pesentation');
end

if useEyelink
    TrialRawData{1,2} = RawData;
    Initialization();
end