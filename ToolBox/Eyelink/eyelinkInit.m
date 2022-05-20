if useEyelink
    eyelinkSetup();
    edfFile = [num2str(cfg.participantsInfo.no) '_' num2str(iSession) '_' cfg.participantsInfo.name '.edf']; % open file to record data to
    status = Eyelink('Openfile', edfFile);
    if status ~= 0
        Screen('CloseAll');
        Screen('ClearAll');
        ListenChar(0);
        sca;
        return
    end
    EyelinkCalibration();
    Initialization();
end