#!/bin/bash
WORK_PATH=$(cd $(dirname $0); pwd)
TEMP_PATH=~/workspace/.tmp/${MY_NAME}
echo "WORK_PATH: ${WORK_PATH}"
echo "TEMP_PATH: ${TEMP_PATH}"

sudo apt-get update

if [ ! -d "${TEMP_PATH}" ]; then
   mkdir -p ${TEMP_PATH}
fi
cd ${TEMP_PATH}
if [ ! -d ".config" ]; then
   mkdir .config
fi
if [ ! -d ".tools" ]; then
   mkdir .tools
fi

cd ${TEMP_PATH}/.config
if [ ! -d ".config" ]; then
   mkdir .config
   sudo rm -rf ~/.config
   sudo ln -s $PWD/.config ~/.config
fi
if [ ! -d ".tmux" ]; then
   mkdir .tmux
   sudo rm -rf ~/.tmux
   sudo ln -s $PWD/.tmux ~/.tmux
fi
if [ ! -d ".local" ]; then
   mkdir .local
   sudo rm -rf ~/.local
   sudo ln -s $PWD/.local ~/.local
fi
if [ ! -d ".ipython" ]; then
   mkdir .ipython
   sudo rm -rf ~/.ipython
   sudo ln -s $PWD/.ipython ~/.ipython
fi
if [ ! -d ".pki" ]; then
   mkdir .pki
   sudo rm -rf ~/.pki
   sudo ln -s $PWD/.pki ~/.pki
fi
if [ ! -d ".cache" ]; then
   mkdir .cache
   sudo rm -rf ~/.cache
   sudo ln -s $PWD/.cache ~/.cache
fi

# vivado
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            build-essential \
            libxtst6 \
            libglib2.0-0 \
            libsm6 \
            libxi6 \
            libxrender1 \
            libxrandr2 \
            libfreetype6 \
            libfontconfig \
            lsb-release \
            libswt-gtk-3-java \
            xterm \
            libnss3 \
            libasound2 \
            libegl1 \
            # buildroot
            libncurses-dev \
            cmake \
            libidn11-dev \
            cpio \
            unzip \
            rsync \
            bc \
            # rootfs
            qemu-user-static \
            debootstrap \
            kpartx \
            dosfstools

wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb 
dpkg -i /tmp/libpng12.deb 
if [ ! -f "${TEMP_PATH}/.tools/vivado" ]; then
   cd ${WORK_PATH}
   cd vivado
   mkdir ${TEMP_PATH}/vivado
   mkdir install_vivado
   cp install_config.txt install_vivado/
   tar zxvf Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz -C install_vivado
   ls install_vivado && sudo install_vivado/*/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config install_vivado/install_config.txt --location ${TEMP_PATH}/vivado/Xilinx
   sudo rm -rf install_vivado
   echo "source ${TEMP_PATH}/vivado/Xilinx/Vivado/2018.3/settings64.sh" >> ${HOME}/.bashrc
   echo "export VIVADO_PATH=${TEMP_PATH}/vivado/Xilinx/Vivado/2018.3/bin" >> ${HOME}/.bashrc
   echo "Vivado install ok" >> ${TEMP_PATH}/.tools/vivado
fi

# tmux
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   tmux
if [ ! -f "${TEMP_PATH}/.tools/tmux" ]; then
   cd ${WORK_PATH}
   cd tmux
   ln -s $PWD/.tmux.conf ~/.tmux.conf
   echo "export TMUX_PATH=${TEMP_PATH}/tmux" >> ${HOME}/.bashrc
   echo "tmux install ok" >> ${TEMP_PATH}/.tools/tmux
fi

sudo apt-get clean
sudo apt-get autoclean
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf /var/cache/*
sudo rm -rf /var/lib/apt/lists/*
