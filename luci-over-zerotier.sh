#!/bin/sh
#

# Allow LuCI over HTTP
uci add firewall rule
uci set firewall.@rule[-1].name='Allow-LuCI-ZeroTier'
uci set firewall.@rule[-1].src='vpn'
uci set firewall.@rule[-1].dest_port='80'
uci set firewall.@rule[-1].proto='tcp'
uci set firewall.@rule[-1].target='ACCEPT'

# Allow LuCI over HTTPS
uci add firewall rule
uci set firewall.@rule[-1].name='Allow-LuCI-ZeroTier-SSL'
uci set firewall.@rule[-1].src='vpn'
uci set firewall.@rule[-1].dest_port='443'
uci set firewall.@rule[-1].proto='tcp'
uci set firewall.@rule[-1].target='ACCEPT'

uci commit firewall
/etc/init.d/firewall restart

echo "LuCI is now accessible over Zerotier on ports 80 and 443."