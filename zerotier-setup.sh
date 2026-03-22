#!/bin/sh
#

if [ -z "$1" ]; then
    echo "Usage: $0 <network_id>"
    exit 1
fi

NETWORK_ID="$1"

uci set zerotier.global.enabled='1'
uci delete zerotier.earth
uci set zerotier.mynet=network
uci set zerotier.mynet.id="$NETWORK_ID"
uci commit zerotier
service zerotier restart

# Wait for Zerotier to bring up the interface
sleep 10

DEVICE=$(zerotier-cli get "$NETWORK_ID" portDeviceName)

# Create interface
uci -q delete network.ZeroTier
uci set network.ZeroTier=interface
uci set network.ZeroTier.proto='none'
uci set network.ZeroTier.device="$DEVICE"

# Configure firewall zone
uci add firewall zone
uci set firewall.@zone[-1].name='vpn'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='ACCEPT'
uci set firewall.@zone[-1].masq='1'
uci add_list firewall.@zone[-1].network='ZeroTier'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='vpn'
uci set firewall.@forwarding[-1].dest='lan'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='vpn'
uci set firewall.@forwarding[-1].dest='wan'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='vpn'

uci commit
reboot