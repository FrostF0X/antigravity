FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/base

# Install Xpra
RUN curl http://xpra.org/gpg.asc > /etc/apt/keyrings/xpra.asc && \
echo "deb [signed-by=/etc/apt/keyrings/xpra.asc] http://xpra.org/ noble main" > \
  /etc/apt/sources.list.d/xpra.list && \
  apt-get update && apt-get install -y \
  xpra \
  xpra-x11 \
  xpra-html5 \
  python3-requests \
  python3-paramiko \
  python3-zeroconf \
  python3-avahi

# Install curl CLI
RUN apt-get install -y curl --no-install-recommends 

# Install tcpdump CLI
RUN apt-get install -y tcpdump 

# Install google-chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  apt-get update && \
  apt install -y ./google-chrome*.deb && \
  rm google-chrome*.deb && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  # Ensure chrome will work in a headless environment without gpu support by
  # specifying environment variables and flags
  echo "QT_X11_NO_MITSHM=1 _X11_NO_MITSHM=1 _MITSHM=0 $(tail -n -1 /opt/google/chrome/google-chrome) --disable-gpu --disable-dev-shm-usage --use-gl=swiftshader" >> /opt/google/chrome/google-chrome && \
  sed -i 'N;$!P;D' /opt/google/chrome/google-chrome

 # Clean up apt package lists
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# create xpra-xterm shortcut for upstart
COPY ./xpra-xterm.sh /etc/workstation-startup.d/110_start-base-xterm.sh
