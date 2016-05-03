FROM	ubuntu
MAINTAINER	BPI  "BPI-SINOVOIP"

RUN	apt-get update && apt-get install -y \
	apt-utils \
	openssh-server \
	build-essential \
	gcc-arm-linux-gnueabihf \
	g++-arm-linux-gnueabihf \
	unzip \
	sudo \
	git \
	mercurial \
	vim \
	bc \
	u-boot-tools \
	device-tree-compiler \
	pkg-config \
	libusb-1.0-0-dev \
	python-software-properties \
	software-properties-common \
	binutils
RUN	apt-get install -qq -y \
	dialog wget lsb-release \
	ca-certificates device-tree-compiler pv bc lzop zip binfmt-support \ 
	build-essential ccache debootstrap ntpdate pigz \
	gawk gcc-arm-linux-gnueabihf gcc-arm-linux-gnueabi qemu-user-static \ 
	u-boot-tools uuid-dev zlib1g-dev unzip libusb-1.0-0-dev ntpdate \
	parted pkg-config libncurses5-dev whiptail debian-keyring \
	debian-archive-keyring f2fs-tools libfile-fcntllock-perl rsync \
	libssl-dev nfs-kernel-server \
	btrfs-tools gcc-aarch64-linux-gnu ncurses-term p7zip-full
RUN	apt-get install -qq -y \
	apt-cacher-ng \
	libc6-dev-armhf-cross libc6-dev-armel-cross
RUN	apt-get install -qq -y aptly

RUN	mkdir /var/run/sshd
RUN	echo 'root:root' | chpasswd
RUN 	sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN 	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

WORKDIR /root

VOLUME	["/media"]

EXPOSE	22

CMD	["/usr/sbin/sshd", "-D"]
