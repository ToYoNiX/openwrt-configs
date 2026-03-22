# OpenWRT Router Configs & Scripts

A collection of configurations, scripts, and firmware for running OpenWRT as a low-power VPN node — giving you authenticated access to your home LAN from anywhere in the world.

---

## Repo Structure
```
├── Installed Packages.txt       # Full list of packages baked into the firmware
├── luci-over-zerotier.sh        # Firewall rules to expose LuCI over Zerotier
├── openwrt-*-factory.bin        # Factory firmware (first-time flash from stock)
├── openwrt-*-sysupgrade.bin     # Sysupgrade firmware (upgrading existing OpenWRT)
├── README.md
└── zerotier-config.sh           # Zerotier setup script
```

---

## Why OpenWRT?

OpenWRT is an open-source, actively maintained Linux-based firmware for routers. Compared to stock firmware it gives you full control over your network: package management via `opkg`, a clean web UI (LuCI), and a large community with broad hardware support.

- **Open source** with a transparent codebase
- **Actively maintained** with regular security updates
- **Huge hardware support** — check the [Hardware Table](https://openwrt.org/toh/start)
- **Extensible** — install only what you need

---

## The Use Case: Remote LAN Access via VPN

The core purpose of this setup is simple: an always-on, low-power box that acts as a VPN node, letting you reach any device on your home network from anywhere with the right credentials.

No public IP required. No complex port forwarding. Just a zero-config overlay VPN tunneled over HTTPS.

### Why Zerotier?

After testing several options, Zerotier stood out for this use case:

- Works like a virtual router over HTTPS
- No public IP needed
- Handles NAT traversal automatically
- Lightweight enough to run on storage-constrained hardware
- Has solid [OpenWRT documentation](https://openwrt.org/docs/guide-user/services/vpn/zerotier)

---

## Hardware

The firmware images in this repo are built for the **TP-Link Archer C6 V3.20**. It's affordable (~$50), widely available, and has strong OpenWRT community support — a solid choice for a 24/7 low-power node.

If you're using a different device, use the [Firmware Selector](https://firmware-selector.openwrt.org/) to find or build a compatible image. The packages baked into the firmware are listed in `Installed Packages.txt`.

---

## Installation

> ⚠️ **Disclaimer:** I'm not responsible for bricked routers. If something goes wrong, refer to the [OpenWRT docs](https://openwrt.org/docs/start) for recovery steps.

### 1. Flash OpenWRT

If you're on the **TP-Link Archer C6 V3.20**, the firmware images are included in this repo:

- **First-time flash** (coming from stock firmware): use the `-factory.bin`
- **Upgrading** an existing OpenWRT install: use the `-sysupgrade.bin`

For any other device, download the appropriate image from [firmware-selector.openwrt.org](https://firmware-selector.openwrt.org/) and follow the installation guide for your model.

### 2. Packages

The firmware images already include everything listed in `Installed Packages.txt` — no post-flash `opkg` installs needed. If you're building your own image, use the Firmware Selector to bake packages in at build time rather than installing them after the fact, since storage on these devices is limited.

---

## Configuration

### Zerotier

1. Create a Zerotier account and network at [my.zerotier.com](https://my.zerotier.com)
2. Follow the [OpenWRT Zerotier guide](https://openwrt.org/docs/guide-user/services/vpn/zerotier) to join your router to the network
3. Run `zerotier-config.sh` with your network ID to apply the configuration:

```sh
sh zerotier-config.sh <your_network_id>
```

4. Run `luci-over-zerotier.sh` to open the firewall ports needed to reach LuCI over the VPN

The script will configure Zerotier, set up the network interface, configure the firewall zones and forwarding rules, and reboot the router automatically.

---

## Resources

- [OpenWRT Documentation](https://openwrt.org/docs/start)
- [OpenWRT Hardware Table](https://openwrt.org/toh/start)
- [Firmware Selector](https://firmware-selector.openwrt.org/)
- [Zerotier OpenWRT Guide](https://openwrt.org/docs/guide-user/services/vpn/zerotier)
