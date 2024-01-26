# Audio-spectrum-analyser
with MATLAB

# **Objective:**
To design an audio spectrum analyser using MATLAB exclusively to capture, process and visualise audio signals.

# Main Features :
**1. Signal Acquisition**:

    - Use of the audioread function to read the audio signal from a file or directly from the   microphone.
    - Conversion of the signal into a format suitable for processing.
    
**2. Signal Processing**:

    - Use of the fft function to perform the Fast Fourier Transform (FFT) to obtain the frequency spectrum.
    - Filtering of unwanted noise using filtering methods available in MATLAB.
    
**3. Visualisation**:

    - Use the plot function to display the data in graphical form.
    - Ability to choose logarithmic or linear scaling for axes.
    
**4. User control**:

    - Simple user interface using MATLAB GUI (Graphical User Interface) to start/stop analysis, choose recording duration and customise parameters.
    
**5. Real-time display**:

    - Real-time update of the audio spectrum on the figure during recording.
    - Digital display of dominant frequencies.
    
**6. Recording and Playback**:

    - Use the audiowrite and audioread functions to record and play back recordings.
