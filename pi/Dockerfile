FROM balenalib/raspberrypi3-debian:bookworm

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends \
        qt6-base-dev \
        wget
WORKDIR /app

RUN cd /app && \
    wget https://github.com/nicomiguelino/arm-on-x86/releases/download/v0.0.1/hello-armv7

ENV QT_QPA_PLATFORM=linuxfb

CMD ["bash"]
