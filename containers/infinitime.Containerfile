FROM arch-base:latest

USER root

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
	cmake \
	clang \
	python-cryptography \
	python-intelhex \
	python-pip \
	python-click \
	python-cbor2

RUN curl https://nodejs.org/dist/v20.20.2/node-v20.20.2-linux-x64.tar.xz | \
		tar -C /usr/local --strip-components 1 -xJ;

RUN mkdir -p /opt/gcc-arm-none-eabi && \
	curl -L https://developer.arm.com/-/media/files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 | \
		tar -C /opt/gcc-arm-none-eabi --strip-components 1 -xj gcc-arm-none-eabi-10.3-2021.10;

RUN curl -O https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/sdks/nrf5/binaries/nrf5sdk153059ac345.zip && \
	unzip nrf5sdk153059ac345.zip -d /opt && \
	mv /opt/nRF5_SDK_15.3.0_59ac345 /opt/nrf-sdk && \
	rm nrf5sdk153059ac345.zip;

RUN npm i lv_font_conv@1.5.2 -g

RUN python3 -m pip install --break-system-packages adafruit-nrfutil

USER leonardo

ENV CONTAINER_ID=infinitime
