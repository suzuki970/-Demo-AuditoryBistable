if useEyelink
    Eyelink('Message', 'ISI');
end

Screen('CopyWindow',empty,win);
Screen('Flip', win,0,1);

tic
while toc < cfg.TIME_ISI
    if useEyelink
        getDataEyelink();
        %         addpoints(h,RawData(data_index-1).time,RawData(data_index-1).pa);
        %         drawnow
    end
end

if useEyelink
    TrialRawData{1,3} = RawData;
    Initialization();
end