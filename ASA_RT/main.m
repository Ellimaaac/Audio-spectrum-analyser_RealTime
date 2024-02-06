% Analyse du spectre audio en temps reel
% Fichier requis: realTimeFig.m

clear; 

% S�lectionner un fichier audio
[file, path] = uigetfile(...
    {'*.wav;*.flac;*.mp3;*.mp4', 'Fichiers audio (*.wav;*.flac;*.mp3;*.mp4)'},...
    'Selectionnez un fichier audio');

if file == 0
    % L'utilisateur a annul� la s�lection du fichier
    return;
end

% Charger le fichier audio
[y, fs] = audioread(fullfile(path, file));


% Cr�er la figure pour le spectre en temps r�el
figure('Position', [100 300 700 400]);
% ax est une r�f�rence � l'axe graphique actuel, et ax.NextPlot = 'replacechildren'; 
% configure cet axe pour qu'il remplace les enfants existants � chaque 
% nouvelle op�ration graphique. Cela est souvent utilis� pour obtenir un comportement
% de mise � jour en temps r�el, par exemple, lors de la visualisation d'un spectre en temps r�el
ax = gca;
ax.NextPlot = 'replacechildren';

% Configurer le lecteur audio
player = audioplayer(y, fs);
player.UserData = {y, ax, file};
player.TimerFcn = @realTimeFig;
player.TimerPeriod = 0.03; % P�riode de rafra�chissement : 0.05s

% Afficher un message indiquant comment arr�ter la lecture
fprintf('[Termine]\n');
fprintf('"stop(player)" ou fermez la fen�tre pour arr�ter la lecture.\n');

% D�marrer la lecture du fichier audio
play(player);
