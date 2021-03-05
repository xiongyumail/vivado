# vivado

Vivado installed into a docker image for CI purposes.

## Install

1. Clone

```
git clone --recursive https://github.com/xiongyumail/vivado.git
```
2. Install docker.io

```
sudo apt install docker.io
```

3. Go to Xilinx official website to download Vivado: https://china.xilinx.com/member/forms/download/xef-vivado.html?filename=Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz
4. Copy the Vivado installation package `Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz` to `tools/vivado`.

## Running

```
./vivado.sh
```