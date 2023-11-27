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
        libxcb-shape0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $USER 

RUN pip install --no-cache-dir deeplabcut[gui,tf]==2.3.0 && \
    pip uninstall -y opencv-python opencv-python-headless && \
    pip install --no-cache-dir opencv-python-headless

RUN fix-permissions /opt/conda

