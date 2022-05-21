
PsychPortAudio('DeleteBuffer');

stim_count = 1;
playTime = tic;

stim_size = pixel_size(cfg.DOT_PITCH, cfg.STIM_SIZE, cfg.VISUAL_DISTANCE);
stim_locs = pixel_size(cfg.DOT_PITCH, cfg.STIM_LOCS, cfg.VISUAL_DISTANCE);

while toc(playTime) < cfg.playTime
    
    out = stim_sound{cfg.condition_frame(stim_count),1}; % load stim sound
    isi = (length(out) / cfg.AUDIO_SAMPLING_RATE) + cfg.TIME_ISI; % set stim isi

    if visionMode
        if cfg.condition_frame(stim_count) == 1 % when sound A presented
            Screen('CopyWindow',empty,win);
            Screen('DrawTexture', win, imagetex, [], ...
                [centerX - stim_size - stim_locs, centerY - (stim_size*ratio), centerX + stim_size - stim_locs, centerY + (stim_size*ratio)]);
        elseif cfg.condition_frame(stim_count) == 2 % when sound B presented
            Screen('CopyWindow',empty,win);
            Screen('DrawTexture', win, imagetex, [], ...
                [centerX - stim_size + stim_locs, centerY - (stim_size*ratio), centerX + stim_size + stim_locs, centerY + (stim_size*ratio)]);
        end
        
        Screen('Flip', win,0,1);
    end
    
    
%     imageArray=Screen('GetImage',win);
%     imwrite(imageArray,['test_' num2str(stim_count) '.png']);
       
    % auditory stimulus onset
    PsychPortAudio('DeleteBuffer');
    PsychPortAudio('FillBuffer', pahandle, out);
    sTime = PsychPortAudio('Start', pahandle);
    
    % silence
    timer.silence = tic;
    while toc(timer.silence) < isi
    
    end
    
    if visionMode
        Screen('CopyWindow',empty,win);
        Screen('Flip', win,0,1);
    end
    
    stim_count = stim_count+1;
    
    clear keyCode;
    [keyIsDown,secs,keyCode]=KbCheck;
    % interrupt by ESC
    if (keyCode(cfg.key.KEY_ESCAPE))
        Screen('CloseAll');
        Screen('ClearAll');
        ListenChar(0);
        sca;
        return
    end

   
end

