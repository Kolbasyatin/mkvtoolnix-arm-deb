FROM debian:latest

RUN apt update && apt install -y build-essential debhelper ruby \
  libbz2-dev liblzo2-dev zlib1g-dev libmagic-dev \
  libflac-dev libogg-dev libvorbis-dev \
  libboost-dev  libboost-filesystem-dev \
  libboost-date-time-dev libboost-system-dev \
  libcmark-dev \
  nlohmann-json3-dev qtbase5-dev qtbase5-dev-tools \
  qt5-default  qtmultimedia5-dev \
  libgtest-dev libfmt-dev \
  pkg-config po4a docbook-xsl xsltproc

WORKDIR "/app/mkvtoolnix"

RUN curl -O https://mkvtoolnix.download/sources/mkvtoolnix-45.0.0.tar.xz \
    && tar xJf mkvtoolnix-45.0.0.tar.xz \
    && cd mkvtoolnix-45.0.0 \
    && cp -R packaging/debian debian

RUN cd mkvtoolnix-45.0.0 && dpkg-buildpackage -b -uc -us 

FROM debian:latest
WORKDIR "/mkvtools"
COPY --from=0 /app/mkvtoolnix/mkvtoolnix_45.0.0-0~bunkus01_armhf.deb \
              /app/mkvtoolnix/mkvtoolnix-gui_45.0.0-0~bunkus01_armhf.deb /mkvtools/

