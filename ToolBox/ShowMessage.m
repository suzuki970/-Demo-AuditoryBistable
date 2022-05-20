
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
    if (keyCode(returnKey) )
        break;
    end
    % ESCEPE?????f
    if (keyCode(escapeKey) )
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
    if (keyCode(returnKey) )
        break;
    end
    
    if (keyCode(escapeKey) )
        Screen('CloseAll');
        Screen('ClearAll');
        ListenChar(0);
        return
    end
    
    if (keyCode(spaceKey))
        if useEyelink
            EyelinkCalibration
            Initialization();
            break
        end
    end
end