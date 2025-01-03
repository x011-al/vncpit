# Menggunakan base image Ubuntu
FROM ubuntu:20.04

# Mengatur non-interaktif untuk menghindari prompt selama instalasi
ENV DEBIAN_FRONTEND=noninteractive

# Update sistem dan instalasi paket yang dibutuhkan
RUN apt-get update && apt-get install -y \
    x11vnc \
    xvfb \
    xfce4 \
    xfce4-terminal \
    wget \
    curl \
    git \
    unzip \
    sudo \
    software-properties-common \
    libnss3-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instal Playit CLI
RUN wget -O /playit https://playit-cloud/download/cli/latest/playit-linux_amd64 && \
    chmod +x /playit

# Konfigurasi X11VNC
RUN mkdir ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd

# Menambahkan user untuk VNC session
RUN useradd -m vncuser && \
    echo "vncuser:vncpassword" | chpasswd && \
    adduser vncuser sudo

# Menyiapkan script untuk menjalankan VNC dan Playit
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Port default untuk VNC
EXPOSE 5900

# Menjalankan script start
CMD ["/start.sh"]
