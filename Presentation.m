
PsychPortAudio('DeleteBuffer');

if useEyelink
    Eyelink('Message', 'Start_Pesentation');
end

count = 1;

cfg.RT = [];
cfg.response = {};

playTime = tic;

stim_size = pixel_size(cfg.DOT_PITCH, cfg.STIM_SIZE, cfg.VISUAL_DISTANCE);
stim_locs = pixel_size(cfg.DOT_PITCH, cfg.STIM_LOCS, cfg.VISUAL_DISTANCE);


while toc(playTime) < cfg.playTime
    
    out = stim_sound{cfg.condition_frame(count),1}; % load stim sound
    isi = (length(out) / cfg.AUDIO_SAMPLING_RATE) + cfg.TIME_ISI; % set stim isi

    if cfg.condition_frame(count) == 1 % when sound A presen
        Screen('CopyWindow',empty,win);
        Screen('DrawTexture', win, imagetex, [], ...
            [centerX - stim_size - stim_locs, centerY - (stim_size*ratio), centerX + stim_size - stim_locs, centerY + (stim_size*ratio)]);
    elseif cfg.condition_frame(count) == 2
        Screen('CopyWindow',empty,win);
        Screen('DrawTexture', win, imagetex, [], ...
            [centerX - stim_size + stim_locs, centerY - (stim_size*ratio), centerX + stim_size + stim_locsE, centerY + (stim_size*ratio)]);
    end
    
    Screen('Flip', win,0,1);

    PsychPortAudio('DeleteBuffer');
    PsychPortAudio('FillBuffer', pahandle, out);
    sTime = PsychPortAudio('Start', pahandle);
    
    timer.silence = tic;
    while toc(timer.silence) < isi
    
    end
    
    Screen('CopyWindow',empty,win);
    Screen('Flip', win,0,1);
    
    count = count+1;
    
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
    if useEyelink
        getDataEyelink();
    end
end



%     Screen('DrawTexture', win, tex); % Draw the new texture immediately to screen:
%     Screen('Flip', win);  % Update display:
%     Screen('Close', tex); % Release texture:
%

%     %%
%     if (keyCode(KEY_LEFT)) && (~keyCode(KEY_RIGHT)) && (~keyCode(KEY_DOWN))
%         if flag_button.right
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Splitted_end'];
%             flag_button.right = false;
%             if useEyelink
%                 Eyelink('Message', 'Splitted_end');
%             end
%             fprintf('********* Splitted_end **********\n\n')
%         end
%         if flag_button.down
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Async_end'];
%             flag_button.down = false;
%             if useEyelink
%                 Eyelink('Message', 'Async_end');
%             end
%             fprintf('********* Async_end **********\n\n')
%         end
%         if ~flag_button.left
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Grouped_start'];
%             if useEyelink
%                 Eyelink('Message', 'Grouped');
%             end
%             fprintf('********* Grouped_start **********\n\n')
%         end
%
%         flag_button.left = true;
%     end
%     %%
%     if (keyCode(KEY_RIGHT)) && (~keyCode(KEY_LEFT)) && (~keyCode(KEY_DOWN))
%         if flag_button.left
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Grouped_end'];
%             flag_button.left = false;
%             if useEyelink
%                 Eyelink('Message', 'Grouped_end');
%             end
%             fprintf('********* Grouped_end **********\n\n')
%         end
%         if flag_button.down
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Async_end'];
%             flag_button.down = false;
%             if useEyelink
%                 Eyelink('Message', 'Async_end');
%             end
%             fprintf('********* Async_end **********\n\n')
%         end
%         if ~flag_button.right
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Splitted_start'];
%             if useEyelink
%                 Eyelink('Message', 'Splitted_start');
%             end
%             fprintf('********* Splitted_start **********\n\n')
%         end
%
%         flag_button.right = true;
%     end
%     %%
%     if (keyCode(KEY_DOWN)) && (~keyCode(KEY_LEFT)) && (~keyCode(KEY_RIGHT))
%         if flag_button.left
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Grouped_end'];
%             flag_button.left = false;
%             if useEyelink
%                 Eyelink('Message', 'Grouped_end');
%             end
%             fprintf('********* Grouped_end **********\n\n')
%         end
%         if flag_button.right
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Splitted_end'];
%             flag_button.right = false;
%             if useEyelink
%                 Eyelink('Message', 'Splitted_end');
%             end
%             fprintf('********* Splitted_end **********\n\n')
%         end
%         if ~flag_button.down
%             cfg.RT = [cfg.RT;toc];
%             cfg.response = [cfg.response;'Async_start'];
%             if useEyelink
%                 Eyelink('Message', 'Async_start');
%             end
%             fprintf('********* Async_start **********\n\n')
%         end
%         flag_button.down = true;
%     end


% if flag_button.left
%     cfg.RT = [cfg.RT;toc];
%     cfg.response = [cfg.response;'Grouped_end'];
%     flag_button.left = false;
%     if useEyelink
%         Eyelink('Message', 'Grouped_end');
%     end
%     fprintf('********* Grouped_end **********\n')
% end
%
% if flag_button.right
%     cfg.RT = [cfg.RT;toc];
%     cfg.response = [cfg.response;'Splitted_end'];
%     flag_button.right = false;
%     if useEyelink
%         Eyelink('Message', 'Splitted_end');
%     end
%     fprintf('********* Splitted_end **********\n')
% end
%
% if flag_button.down
%     cfg.RT = [cfg.RT;toc];
%     cfg.response = [cfg.response;'Async_end'];
%     flag_button.down = false;
%     if useEyelink
%         Eyelink('Message', 'Async_end');
%     end
%     fprintf('********* Async_end **********\n')
% end
%
% % Stop playback:
% Screen('PlayMovie', movie, 0);
%
% % Close movie:
% Screen('CloseMovie', movie);
%
% Screen('CopyWindow',fix,win);
% Screen('Flip', win,0,1);
%
% if useEyelink
%     Eyelink('Message', 'End_Pesentation');
% end
%
% if useEyelink
%     TrialRawData{1,2} = RawData;
%     Initialization();
% end