# Prerequisites
## Init functions
. /etc/os-release
. initfunctions.sh
func_def_distro
func_def_host

## Global variables
navidrome_urlrelease = "https://api.github.com/repos/navidrome/navidrome/releases/latest"
navidrome_ug = "navidrome"
navidrome_opt = "/opt/navidrome"
navidrome_var = "/var/lib/navidrome"
navidrome_musicpath = ""
navidrome_service = "/etc/systemd/system/navidrome.service"

## Update repository list
"${pkgmgr}" update
    
## Upgrade system
"${pkgmgr}" apt upgrade
    
## Install necessary packages
"${pkginst}" vim ffmpeg curl

# Directory Structure
mkdir -p "${HOME}"/.cache

useradd -r -s /bin/false ${navidrome_ug}

install -d -o "${navidrome_ug}" -g "${navidrome_ug}" ${navidrome_opt}
install -d -o "${navidrome_ug}" -g "${navidrome_ug}" ${navidrome_var}

# Download and extract navidrome
curl -L $(curl -s "${navidrome_urlrelease}" | grep browser_download_url | cut -d '"' -f 4 | grep "Linux_x86_64.tar.gz") --output "${dir_cache}/Navidrome.tar.gz"

tar -xvzf Navidrome.tar.gz -C "${navidrome_opt}"

rm "${dir_cache}/Navidrome.tar.gz"

chown -R "${navidrome_ug}":"${navidrome_ug}" "${navidrome_opt}"

# Configuration file
touch "${navidrome_var}/navidrome.toml"

if [ -z "${navidrome_musicpath}" ] ; then
    printf '%s' "Specify music directory: "
    read -r navidrome_musicpath
fi

echo "MusicFolder = ${navidrome_musicpath}" >> "${navidrome_var}/navidrome.toml" ;

# Systemd Unit
touch "${navidrome_service}"
echo "[Unit]
Description=Navidrome Music Server and Streamer compatible with Subsonic/Airsonic
After=remote-fs.target network.target
AssertPathExists=/var/lib/navidrome

[Install]
WantedBy=multi-user.target

[Service]
User=${navidrome_ug}
Group=${navidrome_ug}
Type=simple
ExecStart=/opt/navidrome/navidrome --configfile "/var/lib/navidrome/navidrome.toml"
WorkingDirectory=/var/lib/navidrome
TimeoutStopSec=20
KillMode=process
Restart=on-failure

# See https://www.freedesktop.org/software/systemd/man/systemd.exec.html
DevicePolicy=closed
NoNewPrivileges=yes
PrivateTmp=yes
PrivateUsers=yes
ProtectControlGroups=yes
ProtectKernelModules=yes
ProtectKernelTunables=yes
RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6
RestrictNamespaces=yes
RestrictRealtime=yes
SystemCallFilter=~@clock @debug @module @mount @obsolete @reboot @setuid @swap
ReadWritePaths=/var/lib/navidrome

# You can uncomment the following line if you're not using the jukebox This
# will prevent navidrome from accessing any real (physical) devices
#PrivateDevices=yes

# You can change the following line to `strict` instead of `full` if you don't
# want navidrome to be able to write anything on your filesystem outside of
# /var/lib/navidrome.
ProtectSystem=full

# You can uncomment the following line if you don't have any media in /home/*.
# This will prevent navidrome from ever reading/writing anything there.
#ProtectHome=true

# You can customize some Navidrome config options by setting environment variables here. Ex:
#Environment=ND_BASEURL="/navidrome"
" >> "${navidrome_service}" ;

# Starting navidrome service
systemctl daemon-reload
systemctl start navidrome.service
systemctl status navidrome.service

# Enable startup
systemctl enable navidrome.service
