#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/MrCapo/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/MrCapo/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   ____                   __  ___         ___      _    __            ____ 
  / __ \____  ___  ____  /  |/  /__  ____/ (_)___ | |  / /___ ___  __/ / /_
 / / / / __ \/ _ \/ __ \/ /|_/ / _ \/ __  / / __ `/ | / / __ `/ / / / / __/
/ /_/ / /_/ /  __/ / / / /  / /  __/ /_/ / / /_/ /| |/ / /_/ / /_/ / / /_  
\____/ .___/\___/_/ /_/_/  /_/\___/\__,_/_/\__,_/ |___/\__,_/\__,_/_/\__/  
    /_/                                                                    
 
EOF
}
header_info
echo -e "Loading..."
APP="OMV"
var_disk="4"
var_cpu="2"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/apt/sources.list.d/openmediavault.list ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated Successfully"
exit
}

start
build_container
description

echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}${CL} \n"
