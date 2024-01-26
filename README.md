# Audio-spectrum-analyser
with MATLAB

# **Objective:**
 Real-time update of the audio spectrum on the figure during playing.
 
>[!NOTE]
La section suivante utilise la fonction uigetfile pour ouvrir une boîte de dialogue permettant à l'utilisateur de sélectionner un fichier audio (au format .wav, .flac, .mp3, ou .mp4).

>[!NOTE]
Si l'utilisateur sélectionne un fichier (c'est-à-dire filename n'est pas égal à 0), le programme continue à lire le fichier audio en utilisant la fonction audioread.

>[!NOTE]
Ensuite, une nouvelle fenêtre graphique est créée pour afficher le spectre en temps réel.

>[!NOTE]
audioplayer est créé pour jouer le fichier audio.
