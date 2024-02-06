function realTimeFig(hObject, ~)
    % Extraire les donnees necessaires de l'objet audioplayer
    y = hObject.UserData{1};
    L = size(y,1);
    ax = hObject.UserData{2};
    name = hObject.UserData{3};
    fs = hObject.SampleRate;
    pos = hObject.CurrentSample;
    N = round(fs * 0.3);              % fft points 2N+1
    N1 = round(fs * 0.16);            % window width 2*0.16s

    % Verifier si l'axe est toujours valide
    if ~isvalid(ax)
        stop(hObject);
    else
        % Mettre a jour le spectre en temps reel

        % Le code ci-dessous est utilise pour mettre a jour le spectre en temps reel.
        % Il effectue une transformation de Fourier sur une fenetre de l'audio en cours de lecture
        % et calcule la puissance du spectre dans differentes bandes de frequences.
        % Ces informations sont ensuite utilisees pour mettre a jour un diagramme en barres.
        % Il utilise egalement une fenetre Blackman-Harris pour reduire les artefacts de fenetrage.

        % Definir les indices de debut et de fin pour la fenetre actuelle
        pos_i = max(pos-N, 1); 
        pos_f = min(pos+N, L);
        
        % Creer une fenetre Blackman-Harris et l'appliquer à la fenetre audio
        y1 = [zeros(pos_i-pos+N,1); mean(y(pos_i:pos_f,:),2); zeros(pos+N-pos_f,1)]...
             .*[zeros(N-N1,1); blackmanharris(2*N1+1); zeros(N-N1,1)];  % Multiplication par une fenetre Blackman-Harris
               
        % Calculer la transformee de Fourier et la puissance du spectre
        y_hat = fft(y1)/(2*N+1);
        sA2 = cumsum(abs(y_hat).^2);
        
        % Initialiser le vecteur pour stocker la puissance dans differentes bandes de frequences
        A = zeros(97,1);

        % Calculer la puissance dans differentes bandes de frequences
        for i = -48:48
            upper = floor(440*2.^((i+0.5)/12)*(2*N+1)/fs)+1;
            lower = floor(440*2.^((i-0.5)/12)*(2*N+1)/fs)+1;
            A(i+49) = sA2(upper)-sA2(lower);
        end
        A = sqrt(A);

        % Convertir l'amplitude en decibels
        A_dB = 20 * log10(sqrt(A) + 0.001);  % Ajout de 0.001 pour eviter le log de zero

               
        % Mettre à jour le graphique en barres
        bar(ax, A, 0.4,...
            'EdgeColor', 'none',...
            'FaceColor', [0 0.4 0.7]);
        hold(ax, 'on');
        b = bar(ax, -A, 0.4,...
            'EdgeColor', 'none',...
            'FaceColor', [0 0.4 0.7]);
        b.BaseLine.LineStyle = 'none';
        axis(ax, [1 97 -0.15 0.15]);
        title(ax, name, 'Interpreter', 'none');
        xlabel(ax, '$$ f/\mathrm{Hz} $$', 'Interpreter', 'latex');
        %plage de frequence
        set(ax, 'XTick', (-4:4).*12+49);
        set(ax, 'Xticklabel', 440*2.^(-4:4));
        set(ax, 'XGrid', 'on'); set(ax, 'GridLineStyle', ':');
        set(ax, 'YTick', []);
        set(ax, 'YGrid', 'off');
        hold(ax, 'off');
   
        drawnow;
    end


    