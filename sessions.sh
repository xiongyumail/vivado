#!/bin/bash
IMAGE_NAME="vivado"
IMAGE_VERSION="2018.3"

WORK_PATH=$(cd $(dirname $0); pwd)
echo "WORK_PATH: ${WORK_PATH}"

export PROJECTS_PATH=${WORK_PATH}/projects

session=${IMAGE_NAME}

tmux has-session -t $session >/dev/null 2>&1
if [ $? = 0 ];then
    tmux attach-session -t $session
    exit
fi

tmux new-session -d -s $session -n chip_test
tmux split-window -t $session:0 -h

tmux send-keys -t $session:0.0 'cd ${PROJECTS_PATH};vivado' C-m
tmux send-keys -t $session:0.1 'cd ${PROJECTS_PATH};' C-m

tmux select-pane -t $session:0.1
tmux attach-session -t $session