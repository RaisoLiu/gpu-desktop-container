#FROM jupyter/base-notebook
FROM cschranz/gpu-jupyter:cuda11.6-ubuntu20.04

ENV PATH="${CONDA_DIR}/bin:${PATH}" \
    HOME="/home/${NB_USER}"

USER root

RUN apt-get -y -q update \
 && apt-get -y -q upgrade \
 && apt-get -y -q install \
        dbus-x11 \
        firefox \
        xfce4 \
        xfce4-panel \
        xfce4-session \
        xfce4-settings \
        xorg \
        xubuntu-icon-theme \
    	curl \
    	xscreensaver \
    && apt-get remove -y gnome-screensaver  \
    && apt-get clean \
    && apt-get -y autoremove \
    # chown $HOME to workaround that the xorg installation creates a
    # /home/jovyan/.cache directory owned by root
 && chown -R $NB_UID:$NB_GID $HOME \
 && rm -rf /var/lib/apt/lists/*

ARG TURBOVNC_VERSION=2.2.6
RUN wget -q "https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb/download" -O turbovnc.deb \
 && apt-get install -y -q ./turbovnc.deb \
 && apt-get remove -y -q light-locker \
 && rm ./turbovnc.deb \
 && ln -s /opt/TurboVNC/bin/* /usr/local/bin/

COPY jupyter_remote_desktop_proxy /opt/install/jupyter_remote_desktop_proxy
COPY setup.py MANIFEST.in README.md LICENSE /opt/install/
RUN fix-permissions /opt/install

RUN chown -R $NB_UID:$NB_GID /opt/conda
USER $NB_USER
RUN conda install -y -q websockify=0.10.0
RUN cd /opt/install \
 && pip install -e .

WORKDIR "${HOME}"
