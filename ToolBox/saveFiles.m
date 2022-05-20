
if useEyelink
    Eyelink('StopRecording');
    Eyelink('CloseFile');
    try
        fprintf('Receiving data file ''%s''\n', edfFile );
        status = Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch rdf
        fprintf('Problem receiving data file ''%s''\n', edfFile );
        rdf;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
foobar = ['results/' cfg.participantsInfo.name];

switch cfg.participantsInfo.no
    case 't'
        foobarExp = ['results/' cfg.participantsInfo.name '/' cfg.participantsInfo.no '_Training'];
    case '0'
        foobarExp = ['results/' cfg.participantsInfo.name '/' cfg.participantsInfo.no '_Behavior'];
    case {'1A','2A'}
        foobarExp = ['results/' cfg.participantsInfo.name '/' cfg.participantsInfo.no '_LBP'];
    case {'1B','2B'}
        foobarExp = ['results/' cfg.participantsInfo.name '/' cfg.participantsInfo.no '_SBP'];
    case {'B'}
        foobarExp = ['results/' cfg.participantsInfo.name '/' cfg.participantsInfo.no '_EyeBlinks'];
end

% if ~demoMode
if ~exist(foobar,'dir')
    mkdir(foobar);
end
% end

if ~exist(foobarExp,'dir')
    mkdir(foobarExp);
end

if useEyelink
    save([foobarExp save_name], 'RawData', 'cfg');
    
    results = cfg.res;
    save([foobarExp save_name '_condition'], 'cfg','results');
else
    save([foobarExp save_name], 'cfg');
end

T = jsonencode(cfg);
fileID = fopen([foobarExp save_name '.json'],'w');
fprintf(fileID,T);
fclose(fileID);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

