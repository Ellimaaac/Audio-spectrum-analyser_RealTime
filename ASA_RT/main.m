% Analyse du spectre audio en temps reel
% Fichier requis: realTimeFig.m

clear; 

% Sélectionner un fichier audio
[file, path] = uigetfile(...
    {'*.wav;*.flac;*.mp3;*.mp4', 'Fichiers audio (*.wav;*.flac;*.mp3;*.mp4)'},...
    'Selectionnez un fichier audio');

if file == 0
    % L'utilisateur a annulé la sélection du fichier
    return;
end

% Charger le fichier audio
[y, fs] = audioread(fullfile(path, file));


% Créer la figure pour le spectre en temps réel
figure('Position', [100 300 700 400]);
% ax est une référence à l'axe graphique actuel, et ax.NextPlot = 'replacechildren'; 
% configure cet axe pour qu'il remplace les enfants existants à chaque 
% nouvelle opération graphique. Cela est souvent utilisé pour obtenir un comportement
% de mise à jour en temps réel, par exemple, lors de la visualisation d'un spectre en temps réel
ax = gca;
ax.NextPlot = 'replacechildren';

% Configurer le lecteur audio
player = audioplayer(y, fs);
player.UserData = {y, ax, file};
player.TimerFcn = @realTimeFig;
player.TimerPeriod = 0.03; % Période de rafraîchissement : 0.05s

% Afficher un message indiquant comment arrêter la lecture
fprintf('[Termine]\n');
fprintf('"stop(player)" ou fermez la fenêtre pour arrêter la lecture.\n');

% Démarrer la lecture du fichier audio
play(player);
