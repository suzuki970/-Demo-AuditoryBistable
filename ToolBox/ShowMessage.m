
myText1='Ready...';
TextColor=[0 0 0];
message = Screen('OpenOffscreenWindow',screenNumber,cfg.LUMINANCE_BACKGROUND);
Screen('TextSize', message, 30);
Screen('TextFont', message, 'Times New Roman');
% Screen('DrawText', message, myText1, centerX-150, centerY-20, TextColor);
DrawFormattedText(message, myText1, 'center', centerY-20, TextColor);
Screen('CopyWindow',message,win);
Screen('Flip', win);
pause(0.5);

% Enter to start
while 1
    clear keyCode;
    [keyIsDown,secs,keyCode]=KbCheck;
    if (keyCode(cfg.key.KEY_RETURN) )
        break;
    end
    % ESCEPE?????f
    if (keyCode(cfg.key.KEY_ESCAPE) )
        Screen('CloseAll');
        Screen('ClearAll');
        ListenChar(0);
        return
    end
end

myText1 = 'Enter : Start';
myText2 = 'Space : Calibration(with eye-tracker)';

TextColor=[0 0 0];
message = Screen('OpenOffscreenWindow',screenNumber,cfg.LUMINANCE_BACKGROUND);
Screen('TextSize', message, 30);
Screen('TextFont', message, 'Times New Roman');

DrawFormattedText(message, myText1, centerX-300, centerY-20, TextColor);
DrawFormattedText(message, myText2, centerX-300, centerY+30, TextColor);

Screen('CopyWindow',message,win);
Screen('Flip', win);

pause(0.5);

% Enter to start
while 1
    clear keyCode;
    [keyIsDown,secs,keyCode]=KbCheck;
    if (keyCode(cfg.key.KEY_RETURN) )
        break;
    end
    
    if (keyCode(cfg.key.KEY_ESCAPE) )
        Screen('CloseAll');
        Screen('ClearAll');
        ListenChar(0);
        return
    end
    
end