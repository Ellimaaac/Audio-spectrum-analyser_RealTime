function realTimeFig(hObject, ~)
    % Extraire les donn�es n�cessaires de l'objet audioplayer
    y = hObject.UserData{1};
    L = size(y,1);
    ax = hObject.UserData{2};
    name = hObject.UserData{3};
    fs = hObject.SampleRate;
    pos = hObject.CurrentSample;
    N = round(fs * 0.3);              % fft points 2N+1
    N1 = round(fs * 0.16);            % window width 2*0.16s

    % V�rifier si l'axe est toujours valide
    if ~isvalid(ax)
        stop(hObject);
    else
        % Mettre � jour le spectre en temps r�el

        % Le code ci-dessous est utilise pour mettre a jour le spectre en temps reel.
        % Il effectue une transformation de Fourier sur une fenetre de l'audio en cours de lecture
        % et calcule la puissance du spectre dans differentes bandes de fr��quences.
        % Ces informations sont ensuite utilisees pour mettre a jour un diagramme en barres.
        % Il utilise egalement une fenetre Blackman-Harris pour reduire les artefacts de fenetrage.

        % D�finir les indices de d�but et de fin pour la fen�tre actuelle
        pos_i = max(pos-N, 1); 
        pos_f = min(pos+N, L);
        
        % Cr�er une fen�tre Blackman-Harris et l'appliquer � la fen�tre audio
        y1 = [zeros(pos_i-pos+N,1); mean(y(pos_i:pos_f,:),2); zeros(pos+N-pos_f,1)]...
             .*[zeros(N-N1,1); blackmanharris(2*N1+1); zeros(N-N1,1)];  % Multiplication par une fen��tre Blackman-Harris
               
        % Calculer la transform�e de Fourier et la puissance du spectre
        y_hat = fft(y1)/(2*N+1);
        sA2 = cumsum(abs(y_hat).^2);
        
        % Initialiser le vecteur pour stocker la puissance dans diff�rentes bandes de fr�quences
        A = zeros(97,1);

        % Calculer la puissance dans diff�rentes bandes de fr�quences
        for i = -48:48
            upper = floor(440*2.^((i+0.5)/12)*(2*N+1)/fs)+1;
            lower = floor(440*2.^((i-0.5)/12)*(2*N+1)/fs)+1;
            A(i+49) = sA2(upper)-sA2(lower);
        end
        A = sqrt(A);

        % Convertir l'amplitude en d�cibels
        A_dB = 20 * log10(sqrt(A) + 0.001);  % Ajout de 0.001 pour �viter le log de z�ro

               
        % Mettre � jour le graphique en barres
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
        %plage de fr�quence
        set(ax, 'XTick', (-4:4).*12+49);
        set(ax, 'Xticklabel', 440*2.^(-4:4));
        set(ax, 'XGrid', 'on'); set(ax, 'GridLineStyle', ':');
        set(ax, 'YTick', []);
        set(ax, 'YGrid', 'off');
        hold(ax, 'off');
   
        drawnow;
    end


    