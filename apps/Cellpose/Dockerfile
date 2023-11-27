FROM zzb/gpu-dt:cuda12.1.0


USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.10 \
        python3-pip \
        libglib2.0-0 \
        libgl1-mesa-dev \
        libdbus-1-3 \
        libfontconfig1 \
        libxkbcommon-x11-0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render-util0 \
        libxcb-shape0  \
        libxcb1  \
        libxcb-xinerama0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $USER


RUN pip install cellpose[gui] && \
    pip install PyQt5==5.15.2 PyQt5-Qt5==5.15.2


RUN fix-permissions /opt/conda

