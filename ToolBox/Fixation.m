if useEyelink
    Eyelink('Message', 'Fixation');
end

Screen('CopyWindow',fix,win);
Screen('Flip', win,0,1);

tic
while toc < cfg.TIME_FIXATION
    if useEyelink
        getDataEyelink();
    end
end

% if useEyelink
%     TrialRawData{1,1} = RawData;
%     Initialization();
% end