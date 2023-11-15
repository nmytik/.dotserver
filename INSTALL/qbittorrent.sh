#!/bin/sh

# Prerequisites
## Init functions
. /etc/os-release
. initfunctions.sh
func_def_distro
func_def_host

## Global variables
qbittorrent_ug = "qbtnoxuser"
qbittorrent_service = "/etc/systemd/system/qbittorrent-nox.service"
qbittorrent_config = "/home/${qbittorrent_ug}/.config/qBittorrent"
qbittorrent_downloadpath = ""


## Update repository list
"${pkgmgr}" update
    
## Upgrade system
"${pkgmgr}" apt upgrade
    
# Install qBitTorrent-NOX
"${pkginst}" qbittorrent-nox

# Add qBitTorrent-NOX user
useradd -r -s /bin/false "${qbittorrent_ug}"

# Directory permissions
if [ -z "${qbittorrent_downloadpath}" ] ; then
    printf '%s' "Specify download directory: "
    read -r qbittorrent_downloadpath
fi

chown -R "${qbittorrent_ug}":"${qbittorrent_ug}" "${qbittorrent_downloadpath}"
chmod 775 -R "${qbittorrent_downloadpath}"

# Configuration files
mkdir -p ${qbittorrent_config}
touch "${qbittorrent_config}/qBittorrent.conf"
echo "[AutoRun]
enabled=true
program=chmod -R 770 \"%F/\"

[LegalNotice]
Accepted=true

[Preferences]
Advanced\RecheckOnCompletion=false
Advanced\trackerPort=9000
Connection\PortRangeMin=43370
Connection\ResolvePeerCountries=true
Downloads\SavePath="${qbittorrent_downloadpath}"
Downloads\ScanDirsV2=@Variant(\0\0\0\x1c\0\0\0\0)
Downloads\TempPath="${qbittorrent_downloadpath}"/IncompleteTorrents
Downloads\TorrentExportDir="${qbittorrent_downloadpath}"/DotTorrent
DynDNS\Enabled=false
DynDNS\Service=0
Queueing\QueueingEnabled=false
WebUI\Address=*
WebUI\AlternativeUIEnabled=false
WebUI\AuthSubnetWhitelist=@Invalid()
WebUI\AuthSubnetWhitelistEnabled=false
WebUI\BanDuration=3600
WebUI\CSRFProtection=true
WebUI\ClickjackingProtection=true
WebUI\CustomHTTPHeaders=
WebUI\CustomHTTPHeadersEnabled=false
WebUI\HTTPS\CertificatePath=
WebUI\HTTPS\Enabled=false
WebUI\HTTPS\KeyPath=
WebUI\HostHeaderValidation=true
WebUI\LocalHostAuth=true
WebUI\MaxAuthenticationFailCount=5
WebUI\Password_PBKDF2="@ByteArray(62qsfbG8bIB9F62fdsHgzA==:tPVDyk8QRV1VuxJPGolyJUiBS+DPK/rTp5IIWsxcKCp718A/G3YQ+2J6RB5eJ9bennl5hzAIn0d/r/8My4jP6w==)"
WebUI\Port=8076
WebUI\RootFolder=
WebUI\SecureCookie=true
WebUI\ServerDomains=*
WebUI\SessionTimeout=3600
WebUI\UseUPnP=true
WebUI\Username="${qbittorrent_ug}"
" >> "${qbittorrent_config}" ;

# Systemctl Unit
touch "${qbittorrent_service}"
echo "[Unit]
Description=qBittorrent-nox service for user %I
Documentation=man:qbittorrent-nox(1)
Wants=network-online.target
After=local-fs.target network-online.target nss-lookup.target

[Service]
Type=simple
PrivateTmp=false
User=qbtuser
Group=users
ExecStart=/usr/bin/qbittorrent-nox
TimeoutStopSec=1800

[Install]
WantedBy=multi-user.target
" >> "${qbittorrent_service}" ;

# Starting navidrome service
systemctl daemon-reload
systemctl start qbittorrent-nox.service
systemctl status qbittorrent-nox.service

# Enable startup
systemctl enable qbittorrent-nox.service
